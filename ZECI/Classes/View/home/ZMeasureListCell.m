//
//  ZMeasureListCell.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureListCell.h"

@interface ZMeasureListCell ()
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thridLabel;
@end

@implementation ZMeasureListCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView {
    UIView *rightBackView = [[UIView alloc] initWithFrame:CGRectZero];
    rightBackView.layer.masksToBounds = YES;
    rightBackView.layer.borderColor = kLineColor.CGColor;
    rightBackView.layer.borderWidth = 0.5;
    [self addSubview:rightBackView];
    [rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(0.5);
        make.left.equalTo(self.mas_left).offset(12);
        make.right.equalTo(self.mas_right).offset(-12);
    }];
    
    UIImageView *hintImageView = [[UIImageView alloc] init];
    hintImageView.image = [UIImage imageNamed:@"touxiang"];
    hintImageView.layer.masksToBounds = YES;
    [rightBackView addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(CGFloatIn750(100));
        make.height.mas_equalTo(CGFloatIn750(100));
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(rightBackView.mas_left).offset(20);
    }];
    
    [rightBackView addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintImageView.mas_right).offset(26);
        make.centerY.equalTo(rightBackView.mas_centerY);
    }];
    
    [rightBackView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintImageView.mas_right).offset(26);
        make.centerY.equalTo(rightBackView.mas_bottom).multipliedBy(0.2);
    }];
    
    
    [rightBackView addSubview:self.thridLabel];
    [self.thridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintImageView.mas_right).offset(26);
        make.centerY.equalTo(rightBackView.mas_bottom).multipliedBy(0.8);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *editBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [editBtn setImage:[UIImage imageNamed:@"xiugai"] forState:UIControlStateNormal];
    [editBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.editBlock) {
            weakSelf.editBlock(1);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [rightBackView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(40);
        make.right.equalTo(rightBackView.mas_right).offset(-10);
        make.centerY.equalTo(rightBackView.mas_centerY);
    }];
}


- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstLabel.textColor = kFont6Color;
        _firstLabel.text = @"3234233";
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        [_firstLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _firstLabel;
}

- (UILabel *)thridLabel {
    if (!_thridLabel) {
        _thridLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thridLabel.textColor = kFont6Color;
        _thridLabel.text = @"122223";
        _thridLabel.numberOfLines = 1;
        _thridLabel.textAlignment = NSTextAlignmentLeft;
        [_thridLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _thridLabel;
}


- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondLabel.textColor = kFont6Color;
        _secondLabel.text = @"444442";
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        [_secondLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _secondLabel;
}

+(CGFloat)z_getCellHeight:(id)sender {
    return 80;
}
@end
