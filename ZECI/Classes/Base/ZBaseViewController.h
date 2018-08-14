//
//  ZBaseViewController.h
//  ZECI
//
//  Created by zzz on 2018/6/5.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WRNavigationBar.h"
//#import "UIScrollView+EmptyDataSet.h"

@interface ZBaseViewController : UIViewController
@property (nonatomic, getter=isLoading) BOOL loading;
//是否是横屏
@property (nonatomic,assign) BOOL isHorizontal;

+(UINavigationController *)defaultNavi;

- (void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal;
- (void)refreshData;
@end
