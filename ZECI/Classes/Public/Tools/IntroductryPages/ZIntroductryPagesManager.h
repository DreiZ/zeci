//
//  ZIntroductryPagesManager.h
//  ZECI
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZIntroductryPagesManager : NSObject
+ (instancetype)shareInstance;

+(void)showIntroductryPageView:(NSArray <NSString *>*)imageArray;
@end
