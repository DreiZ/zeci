//
//  ZAdvertiseView.h
//  ZECI
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const NotificationContants_Advertise_Key;

@interface ZAdvertiseView : UIView
/** 显示广告页面方法*/
- (void)show;

/** 图片路径*/
@property (nonatomic, copy) NSString *filePath;
@end
