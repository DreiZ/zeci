//
//  ZMeasureSaveAlertView.m
//  ZECI
//
//  Created by zzz on 2018/8/15.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureSaveAlertView.h"

@interface ZMeasureSaveAlertView ()

@end

@implementation ZMeasureSaveAlertView

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
        make.height.mas_equalTo(190);
        make.width.mas_equalTo(250);
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = kMainColor;
    hintLabel.text = @"提示";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentCenter;
    [hintLabel setFont:[UIFont boldSystemFontOfSize:18.0f]];
    [contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(contView.mas_centerX);
        make.top.equalTo(contView.mas_top).offset(25);
    }];
    _titleLabel = hintLabel;
    
    [contView addSubview:self.alertLabel];
    [self.alertLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.right.equalTo(contView.mas_right).offset(-25);
        make.top.equalTo(hintLabel.mas_bottom).offset(20);
    }];
    

    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn setTitle:@"保存" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [contView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_centerX);
        make.height.mas_equalTo(40);
        make.right.equalTo(contView.mas_right).offset(0);
        make.bottom.equalTo(contView.mas_bottom).offset(0);
    }];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.sureBlock) {
            weakSelf.sureBlock(1);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * cancleBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [cancleBtn setTitle:@"暂不保存" forState:UIControlStateNormal];
    [cancleBtn setTitleColor:kFont6Color forState:UIControlStateNormal];
    [cancleBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [contView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contView.mas_centerX);
        make.height.mas_equalTo(40);
        make.left.equalTo(contView.mas_left).offset(0);
        make.bottom.equalTo(contView.mas_bottom).offset(0);
    }];
    [cancleBtn bk_addEventHandler:^(UIButton *sender) {
        if (weakSelf.sureBlock) {
            weakSelf.sureBlock(0);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    UIView *spaceLineView = [[UIView alloc] initWithFrame:CGRectZero];
    spaceLineView.backgroundColor = kLineColor;
    [contView addSubview:spaceLineView];
    [spaceLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sureBtn.mas_top);
        make.centerX.equalTo(contView.mas_centerX);
        make.bottom.equalTo(contView.mas_bottom);
        make.width.mas_equalTo(0.5);
    }];
   
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kMainColor;
    [contView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(contView);
        make.bottom.equalTo(sureBtn.mas_top).offset(-4);
        make.height.mas_equalTo(1);
    }];
}

- (UILabel *)alertLabel {
    if (!_alertLabel) {
        _alertLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _alertLabel.textColor = kFont3Color;
        _alertLabel.text = @"";
        _alertLabel.numberOfLines = 0;
        _alertLabel.textAlignment = NSTextAlignmentLeft;
        [_alertLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad]? 16:14]];
    }
    return _alertLabel;
}
@end

