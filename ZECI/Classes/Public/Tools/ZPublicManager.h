//
//  ZPublicManager.h
//  ZECI
//
//  Created by zzz on 2018/6/6.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZPublicManager : NSObject
+ (ZPublicManager *)shareInstance;

-(void)umenShare;
/** 清理缓存 */
- (void)cleanCachesVC:(UIViewController *)vc completionHandler:(void (^)(NSString *))completionHandler;
/** 遍历文件夹获得文件夹大小，返回多少M */
- (float )folderSizeAtPath:(NSString*) folderPath;
- (NSInteger)getDevice;

+ (CGSize)stringSizeWithString:(NSString *)stringText Font:(CGFloat)font limitSize:(CGSize)limitSize ;

+ (NSString *)timeWithStr:(NSString *)timeStr format:(NSString *)format;

+ (BOOL)getIsIpad;
@end
