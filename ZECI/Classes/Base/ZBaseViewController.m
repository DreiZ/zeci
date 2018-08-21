//
//  ZBaseViewController.m
//  ZECI
//
//  Created by zzz on 2018/6/5.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseViewController.h"
#import "WRNavigationBar.h"
//#import "UIScrollView+EmptyDataSet.h"
//#import "AFNetworkReachabilityManager.h"

@interface ZBaseViewController ()

@end

@implementation ZBaseViewController

+(UINavigationController *)defaultNavi {
    
    ZBaseViewController *basevc = [[ZBaseViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:basevc];
    
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 添加方向监听
    [self getDeviceScape];
    [self addApplicationOrientationObserver];
}

- (void)setNavItem {
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navRight"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
}

- (void)onClickLeft {
    
}

- (void)onClickRight {
    
}

#pragma mark 初始化 datasource delegate
- (void)refreshData {
    
}


//屏幕装
- (void)getDeviceScape {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
        {
//            NSLog(@"右");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
//            NSLog(@"左");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
//            NSLog(@"上");
            self.isHorizontal = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
//            NSLog(@"下");
            self.isHorizontal = NO;
            
        }
            break;
        case UIInterfaceOrientationUnknown:
        {
//            NSLog(@"不知道");
        }
            break;
            
        default:
            break;
    }
    
}


- (void)addApplicationOrientationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillRotate:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRotate:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)handleDeviceOrientationChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    UIInterfaceOrientation appOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    
//    NSLog(@"\nOrientation:%@\n User Info :%@", @(appOrientation), userInfo);
}

- (void)handleWillRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
//    NSLog(@"\nWill Rotate %@", userInfo);
}

- (void)handleDidRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"\nDid Rotate %@", userInfo);
    if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 1  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 2)) {
//        NSLog(@"横屏");
    }else if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 3  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 4)) {
//        NSLog(@"竖屏");
    }
    [self getDeviceScape];
}

- (void)setIsHorizontal:(BOOL)isHorizontal {
    _isHorizontal = isHorizontal;
    [self reLayoutSubViewsWithIsHorizontal:_isHorizontal];
}

- (void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    
}
@end
