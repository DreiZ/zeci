//
//  UIScrollView+MJRefreshHelper.m
//  hntx
//
//  Created by zzz on 2017/9/5.
//  Copyright © 2017年 zoomwoo. All rights reserved.
//

#import "UIScrollView+MJRefreshHelper.h"

@interface UIScrollView ()

@end
@implementation UIScrollView (MJRefreshHelper)
-(void)refreshHeadTarget:(id)target
                  action:(SEL)action
{
//    HN_MJRefreshFrogHeader *header = [HN_MJRefreshFrogHeader headerWithRefreshingTarget:target refreshingAction:action];
//    header.automaticallyChangeAlpha = YES;
//    header.lastUpdatedTimeLabel.hidden = YES;
//    [header setTitle:@"           正在刷新" forState:MJRefreshStateRefreshing];
//    header.stateLabel.font = [UIFont systemFontOfSize:12];
//    header.stateLabel.textColor = kHN_FontLightGrayDarkColor;
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:target refreshingAction:action];
}

-(void)refreshFootTarget:(id)target
                  action:(SEL)action
{
    
//    HN_MJRefreshFrogFooter *footer = [HN_MJRefreshFrogFooter footerWithRefreshingTarget:target refreshingAction:action];
//    footer.stateLabel.font = [UIFont systemFontOfSize:12];
//    footer.stateLabel.textColor = kHN_FontLightGrayDarkColor;
    self.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
}

-(void)refreshEndHead
{
    [self.mj_header endRefreshing];
}

-(void)refreshEndFoot
{
    [self.mj_footer endRefreshing];
    self.mj_footer.hidden = NO;
}


-(void)refreshNoMoreData
{
    self.mj_footer.hidden = YES;
    [self.mj_footer endRefreshingWithNoMoreData];
}

-(void)refreshResetNoMoreData
{
    [self.mj_footer resetNoMoreData];
}
@end
