//
//  ZDataListVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataListVC.h"
#import "ZDataListSearchView.h"

#import "ZDataListCell.h"
#import "ZHomeViewModel.h"

#import "ZDataLineChatVC.h"

@interface ZDataListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZDataListSearchView *searchView;
@property (nonatomic,strong) UITableView *iTableView;

@property (nonatomic,strong) NSMutableArray *searchArr;
@property (nonatomic,assign) BOOL isSearchState;
@end

@implementation ZDataListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    [self setDataSource];
    [self setMainView];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"数据库";
}

- (void)setDataSource {
    self.searchArr = @[].mutableCopy;
}

- (void)setMainView {
    self.view.backgroundColor = kBackColor;
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo([ZPublicManager getIsIpad] ? 70:55);
    }];
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom).offset([ZPublicManager getIsIpad] ? 15:10);
    }];
}


#pragma mark lazy loading...
- (ZDataListSearchView *)searchView {
    if (!_searchView) {
        __weak typeof(self) weakSelf = self;
        _searchView = [[ZDataListSearchView alloc] init];
        _searchView.searchBlock = ^(NSString *value) {
            [weakSelf startSearch:value];
        };
        
        _searchView.valueChange = ^(NSString *value) {
            [weakSelf startSearch:value];
        };
    }
    return _searchView;
}

-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
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
    if (_isSearchState) {
        return _searchArr.count;
    }
    return [ZHomeViewModel shareInstance].singPigDatas.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDataListCell *cell = [ZDataListCell z_cellWithTableView:tableView];
    ZSinglePig* singlePig;
    if (_isSearchState) {
        singlePig = _searchArr[indexPath.row];
    }else{
        singlePig = [ZHomeViewModel shareInstance].singPigDatas[indexPath.row];
    }
    if (singlePig && singlePig.singleList) {
        cell.singleData = [singlePig.singleList lastObject];
    }
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZDataListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDataLineChatVC *chatvc = [[ZDataLineChatVC alloc] init];
    if (_isSearchState) {
        chatvc.singlePigData = _searchArr[indexPath.row];
    }else{
        chatvc.singlePigData = [ZHomeViewModel shareInstance].singPigDatas[indexPath.row];
    }
    [self.navigationController pushViewController:chatvc animated:YES];
}


#pragma mark 侧滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[ZHomeViewModel shareInstance].singPigDatas removeObjectAtIndex:indexPath.row];
        [self.iTableView reloadData];
        [[ZHomeViewModel shareInstance] updateHistory];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark search handle
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
                [tempArr addObject:dto];
            }else {
                if ([nameFirstLetter containsString:key]) {
                    
                    [tempArr addObject:dto];
                }else { //二首
                    if ([nameFirstLetter containsString:[key substringToIndex:1]]) {
                        
                        if ([namePinyin containsString:key]) {
                            [tempArr addObject:dto];
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
        
        self.isSearchState = YES;
        
    }else{
        
        self.isSearchState = NO;
    }
    
    [self.iTableView reloadData];
}
@end
