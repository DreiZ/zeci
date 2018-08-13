//
//  ZLoginViewModel.h
//  ZECI
//
//  Created by zzz on 2018/6/25.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseViewModel.h"

typedef void (^loginUserResultBlock)(BOOL isSuccess, NSString *message);

@interface ZLoginViewModel : ZBaseViewModel
//
///**
// *  登陆后返回用户信息
// *
// *  @param username 用户名
// *  @param password 密码
// *  @param block    是否成功登陆，若成功登陆返回用户信息
// */
//-(void)loginWithUsername:(NSString *)username
//                password:(NSString *)password
//                   block:(loginUserResultBlock)block;
//
///**
// *  注册新用户
// *
// *  @param username 用户名
// *  @param password 密码
// *  @param block    是否成功注册，若注册成功返回用户信息
// */
//-(void)retrieveWithUsername:(NSString *)username
//                   password:(NSString *)password
//                       code:(NSString *)code
//                      block:(loginUserResultBlock)block;
@end
