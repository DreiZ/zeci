//
//  ZSingDataListVC.m
//  ZECI
//
//  Created by zzz on 2018/8/24.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZSingDataListVC.h"
#import "ZDataListCell.h"
#import "ZHomeViewModel.h"

@interface ZSingDataListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZSingDataListVC

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self setNavgation];
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
    }];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = [ZHomeViewModel shareInstance].singPigDatas[self.index].earTag;
}

- (UITableView *)iTableView {
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
        _iTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 64)];
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHomeViewModel shareInstance].singPigDatas[self.index].singleList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDataListCell *cell = [ZDataListCell z_cellWithTableView:tableView];
    cell.singlePigData = [ZHomeViewModel shareInstance].singPigDatas[self.index].singleList[indexPath.row];
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
        NSMutableArray *tempArr = [[NSMutableArray alloc] initWithArray:[ZHomeViewModel shareInstance].singPigDatas[self.index].singleList];
        [tempArr removeObjectAtIndex:indexPath.row];
        [ZHomeViewModel shareInstance].singPigDatas[self.index].singleList = tempArr;
        [self.iTableView reloadData];
        [[ZHomeViewModel shareInstance] updateTestHistory];
        
        if ([ZHomeViewModel shareInstance].singPigDatas[self.index].singleList.count == 0) {
            [[ZHomeViewModel shareInstance].singPigDatas removeObjectAtIndex:self.index];
            [[ZHomeViewModel shareInstance] updateTestHistory];
            if (self.refreshBlock) {
                self.refreshBlock();
            }
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
