//
//  ZHomeConnectCell.m
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeConnectCell.h"

@interface ZHomeConnectCell ()
@property (nonatomic,strong) UILabel *BluetoothLabel;
@property (nonatomic,strong) UILabel *connectHintLabel;
@property (nonatomic,strong) UILabel *RSSLabel;
@end

@implementation ZHomeConnectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeConnectCell";
    
    ZHomeConnectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeConnectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = kFont3Color;
    hintLabel.text = @"设备名称";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:16]];
    [self.contentView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.mas_equalTo(84);
        make.left.equalTo(self.mas_left).offset(10);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    
    UIImageView *arrowImageView = [[UIImageView alloc] init];
    arrowImageView.image = [UIImage imageNamed:@"fanhui"];
    arrowImageView.layer.masksToBounds = YES;
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(self.mas_right).offset(-10);
    }];
    
    [self.contentView addSubview:self.connectHintLabel];
    [self.connectHintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(hintLabel.mas_right).offset(4);
        make.width.mas_equalTo(80);
    }];
    
    
    [self.contentView addSubview:self.BluetoothLabel];
    [self.BluetoothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_centerY).offset(-3);
        make.right.equalTo(arrowImageView.mas_left).offset(-10);
    }];
    
    [self.contentView addSubview:self.RSSLabel];
    [self.RSSLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_centerY).offset(3);
        make.right.equalTo(arrowImageView.mas_left).offset(-10);
        make.left.equalTo(self.connectHintLabel.mas_right).offset(20);
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
        _BluetoothLabel.text = @"sdfrfgsdg";
        _BluetoothLabel.numberOfLines = 1;
        _BluetoothLabel.textAlignment = NSTextAlignmentLeft;
        [_BluetoothLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    }
    return _BluetoothLabel;
}

- (UILabel *)connectHintLabel {
    if (!_connectHintLabel) {
        _connectHintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _connectHintLabel.textColor = kFont9Color;
        _connectHintLabel.text = @"(点此去测量)";
        _connectHintLabel.numberOfLines = 1;
        _connectHintLabel.textAlignment = NSTextAlignmentLeft;
        [_connectHintLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 14:12]];
    }
    return _connectHintLabel;
}

- (UILabel *)RSSLabel {
    if (!_RSSLabel) {
        _RSSLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _RSSLabel.textColor = kFont6Color;
        _RSSLabel.text = @"";
        _RSSLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
        _RSSLabel.numberOfLines = 1;
        _RSSLabel.textAlignment = NSTextAlignmentRight;
        [_RSSLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 16:13]];
    }
    return _RSSLabel;
}

- (void)setConnectName:(NSString *)connectName {
    _connectName = connectName;
    _BluetoothLabel.text = connectName;
    if (connectName && connectName.length > 0) {
        _connectHintLabel.hidden = NO;
    }else{
        _connectHintLabel.hidden = YES;
    }
}

- (void)setMacAddress:(NSString *)macAddress {
    _macAddress = macAddress;
    _RSSLabel.text = macAddress;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return [ZPublicManager getIsIpad] ? 100:60;
}
@end

