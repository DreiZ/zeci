//
//  ZHomeVC.m
//  ZECI
//
//  Created by zzz on 2018/6/25.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeVC.h"
#import "ZHomeNavView.h"
#import "ZHomeConectCell.h"
#import "ZHomeBluetoothListCell.h"

#import "ZCompanyInfoVC.h"

@interface ZHomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZHomeNavView *navView;

@end

@implementation ZHomeVC

+(UINavigationController *)defaultNavi {
    
    ZHomeVC *homevc = [[ZHomeVC alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:homevc];
    
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationView];
    [self setUI];
}

- (void)setupNavigationView {
//    self.customNavBar.title = @"玛丽莲·梦露";
    self.customNavBar.hidden = YES;
//
    
    self.view.backgroundColor = kBackColor;
}

- (void)setUI {
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.top.equalTo(self.navView.mas_bottom).offset(10);
    }];
}

#pragma mark lazy loading...
-(ZHomeNavView *)navView {
    if (!_navView) {
        __weak typeof(self) weakSelf = self;
        _navView = [[ZHomeNavView alloc] init];
        _navView.topSelectBlock = ^(NSInteger index) {
            if (index == 1) {
                ZCompanyInfoVC *companyVC = [[ZCompanyInfoVC alloc] init];
                [weakSelf.navigationController pushViewController:companyVC animated:YES];
            }
        };
    }
    return _navView;
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
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        return 5;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZHomeConectCell *cell = [ZHomeConectCell z_cellWithTableView:tableView];
        
        return cell;
    }else{
        ZHomeBluetoothListCell *cell = [ZHomeBluetoothListCell z_cellWithTableView:tableView];
        
        return cell;
    }
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZHomeConectCell z_getCellHeight:nil];
    }else{
        return [ZHomeBluetoothListCell z_getCellHeight:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return 40;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, 40)];
        sectionView.backgroundColor = kBackColor;
        sectionView.clipsToBounds = YES;
        
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = kFont3Color;
        hintLabel.text = @"可连接设备";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentLeft;
        [hintLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [sectionView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(sectionView);
            make.left.equalTo(sectionView.mas_left).offset(10);
        }];
        
        return sectionView;
       
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
@end
