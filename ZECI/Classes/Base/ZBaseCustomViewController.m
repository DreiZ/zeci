//
//  ZBaseCustomViewController.m
//  ZECI
//
//  Created by zzz on 2018/6/5.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCustomViewController.h"
#import "AppDelegate.h"
#import "WRNavigationBar.h"


@interface ZBaseCustomViewController ()
@end

@implementation ZBaseCustomViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationController.navigationBar.hidden = YES;
    if (@available(iOS 11.0, *)) {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self setupNavBar];
}

- (void)setupNavBar {
    [self.view addSubview:self.customNavBar];
    [self.customNavBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    // 设置自定义导航栏背景图片
    self.customNavBar.barBackgroundImage = [UIImage imageWithColor:kMainColor];
    
    // 设置自定义导航栏标题颜色
    self.customNavBar.titleLabelColor = [UIColor whiteColor];
    
    if (self.navigationController.childViewControllers.count != 1) {
        [self.customNavBar wr_setLeftButtonWithImage:[UIImage imageNamed:@"fanhuiyi"]];
    }
}

- (WRCustomNavigationBar *)customNavBar {
    if (_customNavBar == nil) {
        _customNavBar = [WRCustomNavigationBar CustomNavigationBar];
    }
    return _customNavBar;
}

@end
