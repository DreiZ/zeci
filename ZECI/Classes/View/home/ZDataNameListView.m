//
//  ZDataNameListView.m
//  ZECI
//
//  Created by zzz on 2018/8/24.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataNameListView.h"
#import "ZDataNameListCell.h"
#import "ZHomeViewModel.h"

@interface ZDataNameListView ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZDataNameListView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    
    _searchArr = @[].mutableCopy;
    
    [self addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.top.equalTo(self.mas_top).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(-0);
    }];
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
            
        }
        _iTableView.backgroundColor = [UIColor clearColor];
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _searchArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDataNameListCell *cell = [ZDataNameListCell z_cellWithTableView:tableView];
    cell.nameLabel.text = _searchArr[indexPath.row];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZDataNameListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_selectBlock) {
        _selectBlock(_searchArr[indexPath.row]);
    }
}


// 开始所搜
- (void)startSearch:(NSString *)string{
    if (self.searchArr.count > 0) {
        
        [self.searchArr removeAllObjects];
    }
    
    // 开始搜索
    NSString * key = string.lowercaseString;
    NSMutableArray * tempArr = [NSMutableArray array];
    
    if (![key isEqualToString:@"" ] && ![key isEqual:[NSNull null]]) {
        
        [[ZHomeViewModel shareInstance].singPigDatas enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ZSinglePig * dto = [ZHomeViewModel shareInstance].singPigDatas[idx];
            
            //担心框架有事后为误转, 再次都设置转为小写
            NSString * name = dto.earTag.lowercaseString;
            NSString * namePinyin = dto.namePinYin.lowercaseString;
            NSString * nameFirstLetter = dto.nameFirstLetter.lowercaseString;
            
            NSRange rang1 = [name rangeOfString:key];
            if (rang1.length > 0) { // 比牛  -比
                [tempArr addObject:dto.earTag];
            }else {
                if ([nameFirstLetter containsString:key]) {
                    
                    [tempArr addObject:dto.earTag];
                }else { //二首
                    if ([nameFirstLetter containsString:[key substringToIndex:1]]) {
                        
                        if ([namePinyin containsString:key]) {
                            [tempArr addObject:dto.earTag];
                        }
                    }
                }
            }
        }];
        
        [tempArr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (![self.searchArr containsObject:tempArr[idx]]) {
                
                [self.searchArr addObject:tempArr[idx]];
            }
        }];
        
        
    }
    
    [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(-0);
        make.bottom.equalTo(self.mas_bottom).offset(-0);
        make.height.mas_equalTo([ZDataNameListCell z_getCellHeight:nil] * self.searchArr.count > self.height - 14 ? self.height - 14:[ZDataNameListCell z_getCellHeight:nil] * self.searchArr.count);
    }];
    [self.iTableView reloadData];
    
}

@end
