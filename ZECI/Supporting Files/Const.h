//
//  Const.h
//  ZECI
//
//  Created by zzz on 2018/6/6.
//  Copyright © 2018年 zzz. All rights reserved.
//

#ifndef Const_h
#define Const_h

#define ZLoginStateChangedNotificationKey @"ZLoginStateChangedNotificationKey"
//是否第一次安装app，而且没登录过
#define kIsFirstLogin @"isFirstLogin"
//重新选择地址之后发出通知
#define kRefreshMainRegion @"refreshMainRegion"
#define kRefreshLoginOut @"refreshLoginOut"

//弱引用/强引用  可配对引用在外面用MPWeakSelf(self)，block用MPStrongSelf(self)  也可以单独引用在外面用MPWeakSelf(self) block里面用weakself
#define kWeak(type)  __weak typeof(type) weak##type = type

//是否是空对象
#define kIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//标题字体
#define kTitleFont      [UIFont systemFontOfSize:15]
//子标题字体
#define kSubtitleFont      [UIFont systemFontOfSize:13]

//通过RGB设置颜色
#define kRGBColor(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]
#define kMainColor [UIColor colorWithHexString:@"00a3ff"]//主色调
#define kNavColor [UIColor colorWithHexString:@"1fa9fd"]//导航栏颜色
#define kLineColor [UIColor colorWithHexString:@"dddddd"]// 线条颜色
#define kDarkBackColor [UIColor colorWithHexString:@"dddddd"]// 深色背景
#define kBackEDColor [UIColor colorWithHexString:@"ededed"]// 文字颜色
#define kFont3Color [UIColor colorWithHexString:@"333333"]// 文字颜色
#define kFont6Color [UIColor colorWithHexString:@"666666"]// 文字颜色
#define kFont9Color [UIColor colorWithHexString:@"999999"]// 文字颜色
#define kFontA3Color [UIColor colorWithHexString:@"a3a3a3"]// 文字颜色
#define kBackColor [UIColor colorWithHexString:@"ededed"]// 背景颜色
#define kMainRedColor [UIColor colorWithHexString:@"e01222"]// 背景颜色
#define kMainBlueColor [UIColor colorWithHexString:@"1296db"]// 背景颜色
//应用程序的屏幕高度

//应用程序的屏幕高度
#define kWindowH        [UIScreen mainScreen].bounds.size.height
//应用程序的屏幕宽度
#define kWindowW        [UIScreen mainScreen].bounds.size.width
#define kSafeAreaTopHeight (kWindowH == 812.0 ? 88 : 64)
#define kSafeAreaBottomHeight (kWindowH == 812.0 ? 34 : 0)
#define kTAB_BAR_HEIGHT self.tabBarController.tabBar.height

//通过Storyboard ID 在对应Storyboard中获取场景对象  （\：换行）
#define kVCFromSb(storyboardId, storyboardName)     [[UIStoryboard storyboardWithName:storyboardName bundle:nil] \
instantiateViewControllerWithIdentifier:storyboardId]

//移除iOS7之后，cell默认左侧的分割线边距   Preserve:保存
#define kRemoveCellSeparator \
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{\
cell.separatorInset = UIEdgeInsetsZero;\
cell.layoutMargins = UIEdgeInsetsZero; \
cell.preservesSuperviewLayoutMargins = NO; \
}

//Docment文件夹目录
#define kDocumentPath NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject



#endif /* Const_h */
