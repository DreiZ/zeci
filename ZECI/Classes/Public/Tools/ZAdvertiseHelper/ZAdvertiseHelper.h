//
//  ZAdvertiseHelper.h
//  ZECI
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZAdvertiseView.h"

@interface ZAdvertiseHelper : NSObject

+ (instancetype)sharedInstance;

+ (void)showAdvertiserView:(NSArray<NSString *> *)imageArray;
@end
