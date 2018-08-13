//
//  ZMeasureNavView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureNavView.h"

@interface ZMeasureNavView ()
@property (nonatomic,strong) UIButton *backBtn;
@property (nonatomic,strong) UIButton *companyBtn;
@property (nonatomic,strong) UIButton *listBtn;
@end

@implementation ZMeasureNavView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = kMainColor;
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIView *contView= [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(44);
    }];
    
    [contView addSubview:self.backBtn];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contView.mas_centerY);
        make.left.equalTo(contView.mas_left).offset(0);
        make.height.width.mas_equalTo(44);
    }];
    
    [contView addSubview:self.listBtn];
    [self.listBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contView.mas_centerY);
        make.right.equalTo(contView.mas_right).offset(0);
        make.height.width.mas_equalTo(44);
    }];
    
    [contView addSubview:self.companyBtn];
    [self.companyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(contView.mas_centerY);
        make.right.equalTo(self.listBtn.mas_left).offset(-10);
        make.height.width.mas_equalTo(44);
    }];
}


- (UIButton *)backBtn {
    if (!_backBtn) {
        __weak typeof(self) weakSelf = self;
        _backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_backBtn setImage:[UIImage imageNamed:@"fanhuiyi"] forState:UIControlStateNormal];
        [_backBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.topSelectBlock) {
                weakSelf.topSelectBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}


- (UIButton *)listBtn {
    if (!_listBtn) {
        _listBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_listBtn setImage:[UIImage imageNamed:@"jilu"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [_listBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.topSelectBlock) {
                weakSelf.topSelectBlock(2);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _listBtn;
}

- (UIButton *)companyBtn {
    if (!_companyBtn) {
        _companyBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_companyBtn setImage:[UIImage imageNamed:@"logo"] forState:UIControlStateNormal];
        __weak typeof(self) weakSelf = self;
        [_companyBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.topSelectBlock) {
                weakSelf.topSelectBlock(1);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _companyBtn;
}
@end

