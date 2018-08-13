//
//  ZIntroductryPagesManager.m
//  ZECI
//
//  Created by zzz on 2018/6/7.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZIntroductryPagesManager.h"
#import "ZIntroductryPagesView.h"

@interface ZIntroductryPagesManager ()
@property (nonatomic,weak) UIWindow *curWindow;
@property (nonatomic,strong) ZIntroductryPagesView *pageView;

@end

static ZIntroductryPagesManager *shareInstance = nil;

@implementation ZIntroductryPagesManager
+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[ZIntroductryPagesManager alloc] init];
    });
    return shareInstance;
}

+(void)showIntroductryPageView:(NSArray<NSString *> *)imageArray {
    
    if (![ZIntroductryPagesManager shareInstance].pageView) {
        [ZIntroductryPagesManager shareInstance].pageView = [ZIntroductryPagesView pagesViewWithFrame:CGRectMake(0, 0, kWindowW, kWindowH) images:imageArray];
    }
    
    [ZIntroductryPagesManager shareInstance].curWindow = [UIApplication sharedApplication].keyWindow;
    [[ZIntroductryPagesManager shareInstance].curWindow addSubview:[ZIntroductryPagesManager shareInstance].pageView];
}
@end
