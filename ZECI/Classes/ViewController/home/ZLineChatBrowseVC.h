//
//  ZLineChatBrowseVC.h
//  ZECI
//
//  Created by zzz on 2018/8/15.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCustomViewController.h"

@interface ZLineChatBrowseVC : ZBaseCustomViewController

- (instancetype)initWithImage:(UIImage*)image lastPageFrame:(CGRect)imageFrame;

@property(strong, nonatomic) UIImage* photo;
@property(assign, nonatomic) CGRect photoOrginFrame;
@end
