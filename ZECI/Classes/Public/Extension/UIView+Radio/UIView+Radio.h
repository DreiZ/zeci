//
//  UIView+Radio.h
//  hntx
//
//  Created by zzz on 16/8/17.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZPublicManager.h"

static inline CGFloat getValue(CGFloat value)
{
    if ([[ZPublicManager shareInstance] getDevice] < 6) {
        return  floorf((value/640.)*kScreenWidth);
    }
    return value/2.;
    
}

static inline CGFloat getValueWithoutLimit(CGFloat value)
{
    return  ceilf((value/640.)*kScreenWidth);
}

static inline CGFloat getValueBybig(CGFloat value)
{
    if ([[ZPublicManager  shareInstance] getDevice] < 6) {
        return  ceilf((value/750.)*kScreenWidth);
    }
    return value/2.;
    
}

static inline CGFloat getValueBybigWithoutLimit(CGFloat value)
{
    return  ceilf((value/750.)*kScreenWidth);
}

@interface UIView (Radio)
extern CGFloat CGFloatIn640(CGFloat valure);
extern CGFloat CGFloatIn750(CGFloat value);
@end
