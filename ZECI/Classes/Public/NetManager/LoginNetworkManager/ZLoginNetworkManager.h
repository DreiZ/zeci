//
//  ZLoginNetworkManager.h
//  ZECI
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseNetWorkManager.h"
@class ZLoginModel;

@interface ZLoginNetworkManager : ZBaseNetWorkManager

/**
 登录后返回用户信息

 @param params 登录数据
 @param completionHandler 数据返回
 @return 返回数据 block
 */
+ (id)loginWithParams:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler;
@end
