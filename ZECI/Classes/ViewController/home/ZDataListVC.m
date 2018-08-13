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
#import "ZDataLineChatVC.h"

@interface ZDataListVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) ZDataListSearchView *searchView;
@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZDataListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgation];
    [self setMainView];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"数据库";
}

- (void)setMainView {
    self.view.backgroundColor = kBackColor;
    
    [self.view addSubview:self.searchView];
    [self.searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(55);
    }];
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.searchView.mas_bottom).offset(10);
    }];
}



#pragma mark lazy loading...
- (ZDataListSearchView *)searchView {
    if (!_searchView) {
        _searchView = [[ZDataListSearchView alloc] init];
        _searchView.searchBlock = ^(NSString *value) {
            
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
        } _iTableView.delegate = self;
        _iTableView.dataSource = self;
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZDataListCell *cell = [ZDataListCell z_cellWithTableView:tableView];
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
    [self.navigationController pushViewController:chatvc animated:YES];
}
@end
