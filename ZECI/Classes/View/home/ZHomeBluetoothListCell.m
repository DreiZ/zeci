//
//  ZHomeBluetoothListCell.m
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeBluetoothListCell.h"

@interface ZHomeBluetoothListCell ()
@property (nonatomic,strong) UILabel *BluetoothLabel;

@end

@implementation ZHomeBluetoothListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeBluetoothListCell";
    
    ZHomeBluetoothListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeBluetoothListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    hintImageView.image = [UIImage imageNamed:@"lanyayi"];
    hintImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:hintImageView];
    [hintImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.mas_left).offset([ZPublicManager getIsIpad] ? 20:10);
    }];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"fanhui"];
    arrowImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset([ZPublicManager getIsIpad] ? -20:10);
    }];
    [self.contentView addSubview:self.BluetoothLabel];
    [self.BluetoothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(hintImageView.mas_right).offset([ZPublicManager getIsIpad] ? 20:10);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
  
}

- (UILabel *)BluetoothLabel {
    if (!_BluetoothLabel) {
        _BluetoothLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _BluetoothLabel.textColor = kFont3Color;
        _BluetoothLabel.text = @"";
        _BluetoothLabel.numberOfLines = 1;
        _BluetoothLabel.textAlignment = NSTextAlignmentLeft;
        [_BluetoothLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    }
    return _BluetoothLabel;
}

- (void)setBluetoothName:(NSString *)name {
    _BluetoothLabel.text = name;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return [ZPublicManager getIsIpad] ? 80:50;
}
@end
