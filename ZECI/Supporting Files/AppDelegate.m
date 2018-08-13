//
//  AppDelegate.m
//  ZECI
//
//  Created by zzz on 2018/6/5.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "AppDelegate.h"
#import "ZIntroductryPagesManager.h"
#import "ZAdvertiseHelper.h"
#import "ZHomeVC.h"

@interface AppDelegate ()
@property (nonatomic,strong) ZHomeVC *homeVC;
@property (nonatomic,strong) UINavigationController *homeNavi;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window.rootViewController = self.homeNavi;
    // 欢迎视图
//    [ZIntroductryPagesManager showIntroductryPageView:@[@"intro_0", @"intro_1", @"intro_2", @"intro_3"]];
//    NSArray <NSString *> *imagesURLS = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189872684&di=03f9df0b71bb536223236235515cf227&imgtype=0&src=http%3A%2F%2Fatt1.dzwww.com%2Fforum%2F201405%2F29%2F1033545qqmieznviecgdmm.gif", @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1495189851096&di=224fad7f17468c2cc080221dd78a4abf&imgtype=0&src=http%3A%2F%2Fimg3.duitang.com%2Fuploads%2Fitem%2F201505%2F12%2F20150512124019_GPjEJ.gif"];
//    // 启动广告
//    [ZAdvertiseHelper showAdvertiserView:imagesURLS];
    return YES;
}

#pragma mark lazy loading
- (UIWindow *)window {
    if(_window == nil) {
        _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
        [_window makeKeyAndVisible];
    }
    return _window;
}

- (ZBaseTabBarController *)tabBarController {
    if(_tabBarController == nil) {
        _tabBarController = [[ZBaseTabBarController alloc] init];
    }
    return _tabBarController;
}

- (UINavigationController *)homeNavi {
    if (!_homeNavi) {
        _homeNavi = [[UINavigationController alloc] initWithRootViewController:self.homeVC];
    }
    return _homeNavi;
}

-(ZHomeVC *)homeVC{
    if (!_homeVC) {
        _homeVC = [[ZHomeVC alloc] init];
    }
    return _homeVC;
}

#pragma mark---------------------setup Notification
- (void)setupNotification{
     [self.window setRootViewController:self.tabBarController];
    [self.window makeKeyAndVisible];
}
@end
