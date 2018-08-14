//
//  ZBaseViewController.m
//  ZECI
//
//  Created by zzz on 2018/6/5.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseViewController.h"
#import "WRNavigationBar.h"
//#import "UIScrollView+EmptyDataSet.h"
//#import "AFNetworkReachabilityManager.h"

@interface ZBaseViewController ()

@end

@implementation ZBaseViewController

+(UINavigationController *)defaultNavi {
    
    ZBaseViewController *basevc = [[ZBaseViewController alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:basevc];
    
    return navi;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // 添加方向监听
    [self getDeviceScape];
    [self addApplicationOrientationObserver];
}

- (void)setNavItem {
    UIBarButtonItem *leftButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navLeft"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickLeft)];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    UIBarButtonItem *rightButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"navRight"] style:UIBarButtonItemStylePlain target:self action:@selector(onClickRight)];
    self.navigationItem.rightBarButtonItem = rightButtonItem;
    
//    // 这里我就不适配了 (适配后 push/pop 时右边的黑影就会自动消失)
//    UIButton *searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 230, 30)];
//    [searchButton setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
//    searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
//    [searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
//    [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
//    [searchButton addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
//    self.navigationItem.titleView = searchButton;
}

- (void)onClickLeft {
    
}

- (void)onClickRight {
    
}
//
//#pragma mark - DZNEmptyDataSetSource Methods
//
//- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//    if (self.loading) {
//        text = @"数据加载中...";
//    }else{
//        if ([self getNetworkStatus]) {
//            text = @"暂无数据,点击重新加载";
//        }else{
//            text = @"网络异常,点击重新加载";
//        }
//    }
//
//    font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14.0];
//    textColor = [UIColor colorWithHexString:@"999999"];
//
//
//    if (!text) {
//        return nil;
//    }
//
//    if (font) [attributes setObject:font forKey:NSFontAttributeName];
//    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//
////副标题
//- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView
//{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//
//    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
//    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
//    paragraph.alignment = NSTextAlignmentCenter;
//    text = @"Get started by uploading a photo.";
//    font = [UIFont boldSystemFontOfSize:15.0];
//    textColor = [UIColor colorWithHexString:@"545454"];
//
//
//    if (!text) {
//        return nil;
//    }
//
//    if (font) [attributes setObject:font forKey:NSFontAttributeName];
//    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//    if (paragraph) [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];
//
//    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
//    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"00adf1"] range:[attributedString.string rangeOfString:@"add favorites"]];
//
//    return attributedString;
//}
//
//
//- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView
//{
//    if (self.isLoading) {
//        return [UIImage imageNamed:@"biceaicon"];
//    }else{
//        if ([self getNetworkStatus]) {
//            return nil;
//        }else{
//            return nil;
//        }
//    }
//}
//
//- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView
//{
//    //    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
//    //    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
//    //    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
//    //    animation.duration = 0.25;
//    //    animation.cumulative = YES;
//    //    animation.repeatCount = MAXFLOAT;
//    CGFloat duration = 0.6f;
//
//    CGFloat height = 20.f;
//
//
//
//    CAKeyframeAnimation * animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
//
//    CGFloat currentTy = 0;
//
//    animation.duration = duration;
//
//    animation.values = @[@(currentTy), @(currentTy - height/4), @(currentTy-height/4*2), @(currentTy-height/4*3), @(currentTy - height), @(currentTy-height/4*3), @(currentTy -height/4*2), @(currentTy - height/4), @(currentTy)];
//
//    animation.keyTimes = @[ @(0), @(0.025), @(0.085), @(0.2), @(0.5), @(0.8), @(0.915), @(0.975), @(1) ];
//
//    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//
//    animation.repeatCount = HUGE_VALF;
//
//    //    [sender.layer addAnimation:animation forKey:@"kViewShakerAnimationKey"];
//
//    return animation;
//}
//
////按钮标题
//- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *text = nil;
//    UIFont *font = nil;
//    UIColor *textColor = nil;
//    text = @"Start Browsing";
//    font = [UIFont boldSystemFontOfSize:16.0];
//    textColor = [UIColor colorWithHexString:(state == UIControlStateNormal) ? @"05adff" : @"6bceff"];
//
//    if (!text) {
//        return nil;
//    }
//
//    NSMutableDictionary *attributes = [NSMutableDictionary new];
//    if (font) [attributes setObject:font forKey:NSFontAttributeName];
//    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
//
//    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
//}
//
////按钮背景
//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state
//{
//    NSString *imageName = @"button_background_";
//
//    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
//    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
//
//    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
//    capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
//    rectInsets = UIEdgeInsetsMake(0.0, -20, 0.0, -20);
//
//
//    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
//
//    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
//}
//
//- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return [UIColor whiteColor];
//}
//
//- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return 0.0;
//}
//
//- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView
//{
//    return 9.0;
//}
//
//
//#pragma mark - DZNEmptyDataSetDelegate Methods
//
//- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView
//{
//    return YES;
//}
//
//- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView
//{
//    if (!self.isLoading) {
//        return NO;
//    }
//    return YES;
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view
//{
//    self.loading = YES;
//    [scrollView reloadEmptyDataSet];
//    [self refreshData];
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button
//{
//    self.loading = YES;
//    [scrollView reloadEmptyDataSet];
//    [self refreshData];
//}
//
//
//- (BOOL)getNetworkStatus {
//    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
//    if(mgr.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable){
//        //        [[HNPublicTool shareInstance] showHudMessage:@"没有网络，请检查手机网络连接"];
//        return NO;
//    }else{
//        return YES;
//    }
//}

#pragma mark 初始化 datasource delegate
- (void)refreshData {
    
}


//屏幕装
- (void)getDeviceScape {
    UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
    switch (orientation) {
        case UIInterfaceOrientationLandscapeRight:
        {
            NSLog(@"右");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        {
            NSLog(@"左");
            self.isHorizontal = YES;
        }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
        {
            NSLog(@"上");
            self.isHorizontal = NO;
        }
            break;
        case UIInterfaceOrientationPortrait:
        {
            NSLog(@"下");
            self.isHorizontal = NO;
            
        }
            break;
        case UIInterfaceOrientationUnknown:
        {
            NSLog(@"不知道");
        }
            break;
            
        default:
            break;
    }
    
}


- (void)addApplicationOrientationObserver
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDeviceOrientationChanged:) name:UIDeviceOrientationDidChangeNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleWillRotate:) name:UIApplicationWillChangeStatusBarOrientationNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleDidRotate:) name:UIApplicationDidChangeStatusBarOrientationNotification object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)handleDeviceOrientationChanged:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    UIInterfaceOrientation appOrientation = [UIApplication sharedApplication].statusBarOrientation;
    
    
    NSLog(@"\nOrientation:%@\n User Info :%@", @(appOrientation), userInfo);
}

- (void)handleWillRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"\nWill Rotate %@", userInfo);
}

- (void)handleDidRotate:(NSNotification *)notification
{
    NSDictionary *userInfo = [notification userInfo];
    NSLog(@"\nDid Rotate %@", userInfo);
    if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 1  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 2)) {
        NSLog(@"横屏");
    }else if ([userInfo objectForKey:@"UIApplicationStatusBarOrientationUserInfoKey"] && ([userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 3  ||[userInfo[@"UIApplicationStatusBarOrientationUserInfoKey"] integerValue] == 4)) {
        NSLog(@"竖屏");
    }
    [self getDeviceScape];
}

- (void)setIsHorizontal:(BOOL)isHorizontal {
    _isHorizontal = isHorizontal;
    [self reLayoutSubViewsWithIsHorizontal:_isHorizontal];
}

- (void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    
}
@end
