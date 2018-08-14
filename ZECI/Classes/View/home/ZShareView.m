//
//  ZShareView.m
//  ZECI
//
//  Created by zzz on 2018/8/14.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZShareView.h"

@interface ZShareView ()
@end

@implementation ZShareView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    backBtn.alpha = 0.5;
    [backBtn bk_addEventHandler:^(id sender) {
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = 6;
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(100));
        make.width.mas_equalTo(CGFloatIn750(330));
    }];
    
    
    UIImage *backImage = [UIImage imageNamed:@"close"];
    UIButton *closeBtn = [[UIButton alloc] initWithFrame:CGRectMake(13, 0, 40, 40)];
    [closeBtn bk_addEventHandler:^(id sender) {
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.image = backImage;
    backImageView.layer.masksToBounds = YES;
    [closeBtn addSubview:backImageView];
    [backImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(closeBtn.mas_left).offset(13);
        make.centerY.equalTo(closeBtn.mas_centerY);
    }];
    
    [contView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contView.mas_top).offset(10);
        make.right.equalTo(contView.mas_right).offset(-10);
        make.height.width.mas_equalTo(40);
    }];
    
    NSMutableArray *imageViewArr = @[].mutableCopy;
    NSMutableArray *btnArr = @[].mutableCopy;
    NSArray *imageArr = @[@"weixin", @"pengyouquan"];
    for (int i = 0; i < imageArr.count; i++) {
        UIImageView *image = [self getImageViewWith:imageArr[i] supreView:contView];
        [imageViewArr addObject:image];
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(contView.mas_centerY);
            make.left.equalTo(contView.mas_left).offset(20 + i * CGFloatIn750(100));
            make.width.height.mas_equalTo(37);
        }];
        UIButton *btn = [self getBtn:i supreView:contView];
        [btnArr addObject:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(image);
        }];
    }
}

- (UIButton *)getBtn:(NSInteger)index  supreView:(UIView *)supreView{
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [tempBtn addTarget:self action:@selector(shareBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tempBtn.tag = index;
    [supreView addSubview:tempBtn];
    return tempBtn;
}

- (UIImageView *)getImageViewWith:(NSString *)imageStr supreView:(UIView *)supreView{
    UIImageView *timageview = [[UIImageView alloc] init];
    timageview.image = [UIImage imageNamed:imageStr];
    timageview.layer.masksToBounds = YES;
    timageview.contentMode = UIViewContentModeScaleAspectFit;
    [supreView addSubview:timageview];
    return timageview;
}

- (void)shareBtnClick:(UIButton *)sender {
    //@"微信好友", @"朋友圈"
    if (self.sureBlock) {
        self.sureBlock(sender.tag);
    }
}
@end

