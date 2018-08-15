//
//  ZMeasureSaveView.h
//  ZECI
//
//  Created by zzz on 2018/8/15.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZMeasureSaveView : ZBaseView
@property (nonatomic,strong) void (^saveBlock)(void);
@end
