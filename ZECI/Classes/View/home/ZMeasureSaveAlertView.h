//
//  ZMeasureSaveAlertView.h
//  ZECI
//
//  Created by zzz on 2018/8/15.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZMeasureSaveAlertView : ZBaseView
@property (nonatomic,strong) UILabel *titleLabel;
@property (nonatomic,strong) UILabel *alertLabel;

@property (nonatomic,strong) void (^sureBlock)(NSInteger);
@end
