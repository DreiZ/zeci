//
//  ZMeasureNavView.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZMeasureNavView : ZBaseView
@property (nonatomic,strong) void (^topSelectBlock)(NSInteger);
@end
