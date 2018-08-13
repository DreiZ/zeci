//
//  UIView+Radio.m
//  hntx
//
//  Created by zzz on 16/8/17.
//  Copyright © 2016年 zoomwoo. All rights reserved.
//

#import "UIView+Radio.h"

@implementation UIView (Radio)
//static CGFloat raido = 640;
CGFloat CGFloatIn640(CGFloat value)
{
     return  (value/640.)*kScreenWidth;
}

CGFloat CGFloatIn750(CGFloat value)
{
    return  (value/750.)*kScreenWidth;
}
@end
