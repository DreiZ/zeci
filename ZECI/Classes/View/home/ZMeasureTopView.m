//
//  ZMeasureTopView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureTopView.h"

@interface ZMeasureTopView ()
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thridLabel;
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
    
    
    UIView *rightBackView = [[UIView alloc] initWithFrame:CGRectZero];
    rightBackView.backgroundColor = kMainColor;
    rightBackView.layer.masksToBounds = YES;
    rightBackView.layer.cornerRadius = 10;
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
        _firstLabel.text = @"33";
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentCenter;
        [_firstLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(50)]];
    }
    return _firstLabel;
}

- (UILabel *)thridLabel {
    if (!_thridLabel) {
        _thridLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thridLabel.textColor = [UIColor whiteColor];
        _thridLabel.text = @"12";
        _thridLabel.numberOfLines = 1;
        _thridLabel.textAlignment = NSTextAlignmentCenter;
        [_thridLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(50)]];
    }
    return _thridLabel;
}


- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondLabel.textColor = [UIColor whiteColor];
        _secondLabel.text = @"42";
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentCenter;
        [_secondLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(50)]];
    }
    return _secondLabel;
}
@end
