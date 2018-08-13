//
//  ZLoginNetworkManager.m
//  ZECI
//
//  Created by zzz on 2018/6/26.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZLoginNetworkManager.h"
#import "ZLoginModel.h"

@implementation ZLoginNetworkManager
+ (id)loginWithParams:(NSDictionary *)params completionHandler:(void (^)(id, NSError *))completionHandler {
    NSString *path = @"shuidianUser/shuidianUserLogin";
    return [self post:path params:params completionHandler:^(id responseObj, NSError *error) {
        [ZLoginModel mj_objectWithKeyValues:[ZLoginNetworkManager handleData:responseObj]];
    }];
}

+ (NSMutableDictionary *)handleData:(NSDictionary *)data {
    NSMutableDictionary *returnData = [[NSMutableDictionary alloc] initWithDictionary:data];
    NSArray *keyValue = [returnData allKeys];
    for (NSString *key in keyValue) {
        if ([returnData[key] isKindOfClass:[NSNull class]]) {
            [returnData setObject:@"" forKey:key];
        }
    }
    return returnData;
}
@end
