//
//  ZPublicUserManager.h
//  ZQingSongGuang
//
//  Created by zzz on 2018/7/23.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZLoginModel.h"

@interface ZPublicUserManager : NSObject
@property (nonatomic,strong) ZLoginResultModel *userInfoModel;

+ (ZPublicUserManager *)shareInstance;
+ (void)saveUser:(ZLoginResultModel*)data;
+ (void)cleanUser;

- (void)updateDataToHistory;
@end
