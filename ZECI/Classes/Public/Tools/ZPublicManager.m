//
//  ZPublicManager.m
//  ZECI
//
//  Created by zzz on 2018/6/6.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZPublicManager.h"
#import <UMShare/UMShare.h>

@implementation ZPublicManager
+ (ZPublicManager *)shareInstance {
    static ZPublicManager *publicManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicManager = [[ZPublicManager alloc] init];
    });
    return publicManager;
}

#pragma mark 友盟分享
-(void)umenShare {
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5b3c29e2b27b0a0ac200028d"];
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdabd790a9b61c1d8" appSecret:@"f6874bcbdd9221bf7c53f8137279bb48" redirectURL:@"http://mobile.umeng.com/social"];
}


/** 清理缓存 */
- (void)cleanCachesVC:(UIViewController *)vc completionHandler:(void (^)(NSString *))completionHandler {
    UIAlertController *ac = [UIAlertController alertControllerWithTitle:@"清理缓存" message:@"" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        return;
    }];
    UIAlertAction *ensureAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            NSFileManager *manager = [NSFileManager defaultManager];
            NSArray *files = [manager subpathsAtPath:cachePath];
            for (NSString *p in files) {
                NSError *error = nil;
                NSString *path = [cachePath stringByAppendingPathComponent:p];
                if ([manager fileExistsAtPath:path]) {
                    [manager removeItemAtPath:path error:&error];
                }
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                completionHandler(@"清理成功");
            });
        });
        
        [self showSuccessWithMsg:@"清理成功"];
    }];
    [ac addAction:cancelAction];
    [ac addAction:ensureAction];
    [vc presentViewController:ac animated:YES completion:nil];
}

- (long long)fileSizeAtPath:(NSString*) filePath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

/** 遍历文件夹获得文件夹大小，返回多少M */
- (float )folderSizeAtPath:(NSString*) folderPath {
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}


-(NSInteger)getDevice {
    NSInteger deviceHeight = kScreenHeight;
    if (deviceHeight>=736) {
        return  61;
    }
    if (deviceHeight>=667) {
        return 6;
    }
    if (deviceHeight>=568) {
        return 5;
    }
    if (deviceHeight>=480) {
        return 4;
    }
    return 5;
}

+ (CGSize)stringSizeWithString:(NSString *)stringText Font:(CGFloat)font limitSize:(CGSize)limitSize
{
    
    CGSize stringTextSize = [stringText boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:font]} context:nil].size;
    
    return stringTextSize;
}

+(NSString *)timeWithStr:(NSString *)timeStr format:(NSString *)format
{
    NSTimeInterval time= [timeStr integerValue] + 28800;//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    
    NSString *currentDateStr = [dateFormatter stringFromDate:detaildate];
    return currentDateStr;
}


+ (BOOL)getIsIpad {
    NSString *deviceType = [UIDevice currentDevice].model;
    
    if([deviceType isEqualToString:@"iPhone"]) {
        
        //iPhone
        
        return NO;
    }
    
    else if([deviceType isEqualToString:@"iPod touch"]) {
        
        //iPod Touch
        return NO;
    } else if([deviceType isEqualToString:@"iPad"]) {
        
        //iPad
        
        return YES;
    }
    return NO;
}
@end
