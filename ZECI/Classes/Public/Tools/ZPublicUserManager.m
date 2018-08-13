//
//  ZPublicUserManager.m
//  ZQingSongGuang
//
//  Created by zzz on 2018/7/23.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZPublicUserManager.h"

@implementation ZPublicUserManager
+ (ZPublicUserManager *)shareInstance {
    static ZPublicUserManager *publicUserManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicUserManager = [[ZPublicUserManager alloc] init];
    });
    return publicUserManager;
}

-(ZLoginResultModel *)userInfoModel {
    if (!_userInfoModel) {
        _userInfoModel = [ZPublicUserManager getUser];
    }
    return _userInfoModel;
}

- (void)updateDataToHistory {
    [ZPublicUserManager saveUser:self.userInfoModel];
}
/**
 存储user的数据
 
 @param data 传入的
 */
+ (void)saveUser:(ZLoginResultModel*)data
{
    NSData *archiveCarPriceData = [NSKeyedArchiver archivedDataWithRootObject:data];
    [[NSUserDefaults standardUserDefaults] setObject:archiveCarPriceData forKey:@"CFBundle_QSG_SAVEUSER"];
    
    [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 获取保存user的数据
 
 @return 返回的数组
 */
+ (ZLoginResultModel*)getUser
{
    NSData *myEncodedObject = [[NSUserDefaults standardUserDefaults] objectForKey:@"CFBundle_QSG_SAVEUSER"];
    if(myEncodedObject == nil)
        return nil;
    ZLoginResultModel *u = [NSKeyedUnarchiver unarchiveObjectWithData:myEncodedObject];
    return u;
}

/**
 清空user的数据
 */
+ (void)cleanUser
{
    [ZPublicUserManager shareInstance].userInfoModel = nil;
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"isLogin"];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"CFBundle_QSG_SAVEUSER"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
