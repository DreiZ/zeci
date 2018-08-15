//
//  ZMeasureTopView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureTopView.h"

@interface ZMeasureTopView ()
@property (nonatomic,strong) UIView *rightBackView;
@property (nonatomic,strong) UIImageView *hintImageView;

@end

@implementation ZMeasureTopView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIImageView *hintImageView = [[UIImageView alloc] init];
    hintImageView.image = [UIImage imageNamed:@"zhu1"];
    hintImageView.layer.masksToBounds = YES;
    [self addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(352));
        make.height.mas_equalTo(CGFloatIn750(293));
        make.right.equalTo(self.mas_centerX).multipliedBy(1.2);
        make.centerY.equalTo(self.mas_centerY);
    }];
    _hintImageView = hintImageView;
    
    UIView *rightBackView = [[UIView alloc] initWithFrame:CGRectZero];
    rightBackView.backgroundColor = kMainColor;
    rightBackView.layer.masksToBounds = YES;
    rightBackView.layer.cornerRadius = 10;
    _rightBackView = rightBackView;
    [self addSubview:rightBackView];
    [rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).multipliedBy(0.9);
        make.height.mas_equalTo(CGFloatIn750(272));
        make.width.mas_equalTo(CGFloatIn750(172));
    }];
    
    
    [rightBackView addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(rightBackView);
        make.centerY.equalTo(rightBackView.mas_centerY);
    }];
    
    [rightBackView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(rightBackView);
        make.centerY.equalTo(rightBackView.mas_bottom).multipliedBy(0.2);
    }];
    
    
    [rightBackView addSubview:self.thridLabel];
    [self.thridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(rightBackView);
        make.centerY.equalTo(rightBackView.mas_bottom).multipliedBy(0.8);
    }];
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstLabel.textColor = [UIColor whiteColor];
        _firstLabel.text = @"11";
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        [_firstLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? CGFloatIn750(40): CGFloatIn750(50)]];
    }
    return _firstLabel;
}

- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.text = @"22";
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        [_secondLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? CGFloatIn750(40): CGFloatIn750(50)]];
    }
    return _secondLabel;
}


- (UILabel *)thridLabel {
    if (!_thridLabel) {
        _thridLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thridLabel.textColor = [UIColor whiteColor];
        _thridLabel.text = @"33";
        _thridLabel.numberOfLines = 1;
        _thridLabel.textAlignment = NSTextAlignmentCenter;
        [_thridLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? CGFloatIn750(40): CGFloatIn750(50)]];
    }
    return _thridLabel;
}


- (void)resetUIWith:(BOOL)isPad {
    if (isPad) {
        [_hintImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(300));
            make.height.mas_equalTo(CGFloatIn750(250));
            make.centerX.equalTo(self.mas_centerX);
            make.bottom.equalTo(self.mas_centerY).offset(-10);
        }];
        
        [_rightBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.mas_centerY).offset(20);
            make.centerX.equalTo(self.mas_centerX);
            make.width.mas_equalTo(CGFloatIn750(282));
            make.height.mas_equalTo(CGFloatIn750(132));
        }];
        
        [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.rightBackView);
            make.centerX.equalTo(self.rightBackView.mas_centerX);
        }];
        
        
        [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.rightBackView);
            make.centerX.equalTo(self.rightBackView.mas_right).multipliedBy(0.2);
        }];
        
        [self.thridLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.rightBackView);
            make.centerX.equalTo(self.rightBackView.mas_right).multipliedBy(0.8);
        }];
    }else{
        [_hintImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.mas_equalTo(CGFloatIn750(352));
            make.height.mas_equalTo(CGFloatIn750(293));
            make.right.equalTo(self.mas_centerX).multipliedBy(1.2);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
        [_rightBackView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.mas_centerY);
            make.right.equalTo(self.mas_right).multipliedBy(0.9);
            make.height.mas_equalTo(CGFloatIn750(272));
            make.width.mas_equalTo(CGFloatIn750(172));
        }];
        
        [self.secondLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.rightBackView);
            make.centerY.equalTo(self.rightBackView.mas_centerY);
        }];
        
    
        [self.firstLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.rightBackView);
            make.centerY.equalTo(self.rightBackView.mas_bottom).multipliedBy(0.2);
        }];
        
        
        [self.thridLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.rightBackView);
            make.centerY.equalTo(self.rightBackView.mas_bottom).multipliedBy(0.8);
        }];
    }
}

- (void)setSingleData:(ZSingleData *)singleData {
    _singleData = singleData;
    _firstLabel.text = singleData.firstNum;
    _thridLabel.text = singleData.thirdNum;
    _secondLabel.text = singleData.secondNum;
}
@end
