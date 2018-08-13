//
//  UIScrollView+MJRefreshHelper.h
//  hntx
//
//  Created by zzz on 2017/9/5.
//  Copyright © 2017年 zoomwoo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (MJRefreshHelper)
-(void)refreshHeadTarget:(id)target
                  action:(SEL)action;
-(void)refreshFootTarget:(id)target
                  action:(SEL)action;
-(void)refreshEndHead;
-(void)refreshEndFoot;
-(void)refreshNoMoreData;
-(void)refreshResetNoMoreData;
@end
