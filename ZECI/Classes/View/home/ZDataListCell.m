//
//  ZDataListCell.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataListCell.h"

@interface ZDataListCell ()
@property (nonatomic,strong) UILabel *detaiLabel;
@property (nonatomic,strong) UILabel *timeLabel;
@end

@implementation ZDataListCell


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZDataListCell";
    
    ZDataListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZDataListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initDetailView];
    }
    return self;
}

- (void)initDetailView {
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.clipsToBounds = YES;
    
    
    UIImageView *hintImageView = [[UIImageView alloc] init];
    hintImageView.image = [UIImage imageNamed:@"touxiang"];
    hintImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset(15);
        make.width.height.mas_equalTo(32);
    }];
    
    
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-15);
        make.width.mas_equalTo(84);
    }];
    
    [self.contentView addSubview:self.detaiLabel];
    [self.detaiLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(hintImageView.mas_right).offset(20);
        make.right.equalTo(self.timeLabel.mas_left).offset(-20);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)detaiLabel {
    if (!_detaiLabel) {
        _detaiLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _detaiLabel.textColor = kFont3Color;
        _detaiLabel.text = @"2018022:12 12 32";
        _detaiLabel.numberOfLines = 1;
        _detaiLabel.textAlignment = NSTextAlignmentLeft;
        [_detaiLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _detaiLabel;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _timeLabel.textColor = kFont9Color;
        _timeLabel.text = @"2018-12-12";
        _timeLabel.numberOfLines = 1;
        _timeLabel.textAlignment = NSTextAlignmentRight;
        [_timeLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    }
    return _timeLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return 50;
}
@end
