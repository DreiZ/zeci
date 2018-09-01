//
//  ZMeasureSaveAlertView.h
//  ZECI
//
//  Created by zzz on 2018/8/15.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZMeasureSaveAlertView : ZBaseView
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *alert;

@property (nonatomic,strong) void (^sureBlock)(NSInteger);
@end
