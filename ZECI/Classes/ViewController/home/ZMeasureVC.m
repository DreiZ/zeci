//
//  ZMeasureVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureVC.h"
#import "ZMeasureNavView.h"
#import "ZCompanyInfoVC.h"
#import "ZDataListVC.h"
#import "ZMeasureTopView.h"

#import "ZMeasureListCell.h"

#import "ZMeasureEditView.h"

@interface ZMeasureVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) ZMeasureNavView *navView;
@property (nonatomic,strong) ZMeasureTopView *topView;
@property (nonatomic,strong) ZMeasureEditView *editView;

@property (nonatomic,strong) UITableView *iTableView;

@end

@implementation ZMeasureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
    [self setMainView];
}


- (void)setupNavigationView {
    self.customNavBar.hidden = YES;
    self.view.backgroundColor = kBackColor;
}

- (void)setMainView {
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    if (self.isHorizontal) {
        [self.view addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
            make.width.mas_equalTo(kWindowW/2.0f);
        }];
        
        [self.view addSubview:self.iTableView];
        [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom).offset(0);
            make.left.equalTo(self.topView.mas_right);
        }];
        [self.topView resetUIWith:[ZPublicManager getIsIpad]];
    }else{
        [self.view addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(434));
        }];
        
        [self.view addSubview:self.iTableView];
        [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.topView.mas_bottom).offset(0);
        }];
    }
}

#pragma mark lazy loading...
-(ZMeasureNavView *)navView {
    if (!_navView) {
        __weak typeof(self) weakSelf = self;
        _navView = [[ZMeasureNavView alloc] init];
        _navView.topSelectBlock = ^(NSInteger index) {
            if (index == 1) {
                ZCompanyInfoVC *companyVC = [[ZCompanyInfoVC alloc] init];
                [weakSelf.navigationController pushViewController:companyVC animated:YES];
            }else if (index == 2){
                ZDataListVC *listVC = [[ZDataListVC alloc] init];
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            }else{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        };
    }
    return _navView;
}

- (ZMeasureTopView *)topView {
    if (!_topView) {
        _topView = [[ZMeasureTopView alloc] init];
    }
    
    return _topView;
}

- (ZMeasureEditView *)editView {
    if (!_editView) {
        _editView = [[ZMeasureEditView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
    }
    _editView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    return _editView;
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
    __weak typeof(self) weakSelf = self;
    ZMeasureListCell *cell = [ZMeasureListCell z_cellWithTableView:tableView];
    cell.editBlock = ^(NSInteger index) {
        [weakSelf.view addSubview:weakSelf.editView];
    };
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMeasureListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    if (!_topView || !_iTableView) {
        return;
    }
    if (self.isHorizontal) {
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
            make.width.mas_equalTo(kWindowW/2.0f);
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom).offset(0);
            make.left.equalTo(self.topView.mas_right);
        }];
        
        [self.topView resetUIWith:[ZPublicManager getIsIpad]];
    }else{
        [self.topView resetUIWith:NO];
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(434));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.topView.mas_bottom).offset(0);
        }];
    }
}
@end
