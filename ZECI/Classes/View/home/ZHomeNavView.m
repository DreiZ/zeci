//
//  ZHomeNavView.m
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeNavView.h"

@interface ZHomeNavView ()
@property (nonatomic,strong) UIButton *BluetoothBtn;
@property (nonatomic,strong) UIButton *companyBtn;
@property (nonatomic,strong) UIButton *listBtn;
@end

@implementation ZHomeNavView

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
    
    [contView addSubview:self.BluetoothBtn];
    [self.BluetoothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
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


- (UIButton *)BluetoothBtn {
    if (!_BluetoothBtn) {
        __weak typeof(self) weakSelf = self;
        _BluetoothBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_BluetoothBtn setImage:[UIImage imageNamed:@"lanya"] forState:UIControlStateNormal];
        [_BluetoothBtn bk_addEventHandler:^(id sender) {
            if (weakSelf.topSelectBlock) {
                weakSelf.topSelectBlock(0);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _BluetoothBtn;
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

- (void)setBluetoothState:(BOOL)bluetoothState {
    if (bluetoothState) {
        [_BluetoothBtn setImage:[UIImage imageNamed:@"lanya"] forState:UIControlStateNormal];
    }else{
        [_BluetoothBtn setImage:[UIImage imageNamed:@"lanyayi"] forState:UIControlStateNormal]; 
    }
}
@end
