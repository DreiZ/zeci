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
@property (nonatomic,strong) UIView *contView;

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
    self.contView = rightBackView;
    [rightBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.bottom.equalTo(self.mas_bottom).offset(0.5);
        make.left.equalTo(self.mas_left).offset([ZPublicManager getIsIpad] ? 24:12);
        make.right.equalTo(self.mas_right).offset([ZPublicManager getIsIpad] ? -24:-12);
    }];
    
    UIImageView *hintImageView = [[UIImageView alloc] init];
    hintImageView.image = [UIImage imageNamed:@"touxiang"];
    hintImageView.layer.masksToBounds = YES;
    [rightBackView addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 65:50);
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(rightBackView.mas_left).offset([ZPublicManager getIsIpad] ? 28:20);
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
            weakSelf.editBlock(weakSelf.singleData);
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [rightBackView addSubview:editBtn];
    [editBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 60:40);
        make.right.equalTo(rightBackView.mas_right).offset([ZPublicManager getIsIpad] ? -20:-10);
        make.centerY.equalTo(rightBackView.mas_centerY);
    }];
}


- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstLabel.textColor = kFont6Color;
        _firstLabel.text = @"";
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        [_firstLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 14:12]];
    }
    return _firstLabel;
}

- (UILabel *)thridLabel {
    if (!_thridLabel) {
        _thridLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thridLabel.textColor = kFont6Color;
        _thridLabel.text = @"";
        _thridLabel.numberOfLines = 1;
        _thridLabel.textAlignment = NSTextAlignmentLeft;
        [_thridLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 14:12]];
    }
    return _thridLabel;
}


- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondLabel.textColor = kFont6Color;
        _secondLabel.text = @"";
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        [_secondLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 14:12]];
    }
    return _secondLabel;
}

- (void)setSingleData:(ZSingleData *)singleData {
    _singleData = singleData;
    _firstLabel.text = [ZPublicManager timeWithStr:singleData.testTime format:@"YYYY-MM-dd"];
    _thridLabel.text = [NSString stringWithFormat:@"%@ %@ %@",singleData.firstNum,singleData.secondNum,singleData.thirdNum];
    _secondLabel.text = singleData.earTag;
}

- (void)setIsSelectData:(BOOL)isSelectData {
    _isSelectData = isSelectData;
    if (isSelectData) {
        self.contView.layer.masksToBounds = YES;
        self.contView.layer.borderColor = kMainColor.CGColor;
        self.contView.layer.borderWidth = 1;
    }else{
        self.contView.layer.masksToBounds = YES;
        self.contView.layer.borderColor = kLineColor.CGColor;
        self.contView.layer.borderWidth = 0.5;
    }
}

+(CGFloat)z_getCellHeight:(id)sender {
    return [ZPublicManager getIsIpad] ? 100:80;
}
@end
