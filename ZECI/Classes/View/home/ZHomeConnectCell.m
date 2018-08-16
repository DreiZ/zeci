//
//  ZHomeConnectCell.m
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeConnectCell.h"

@interface ZHomeConnectCell ()
@property (nonatomic,strong) UILabel *bluetoothLabel;
@property (nonatomic,strong) UILabel *connectHintLabel;

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
    }];
    
    
    [self.contentView addSubview:self.bluetoothLabel];
    [self.bluetoothLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.right.equalTo(arrowImageView.mas_left).offset(-10);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kLineColor;
    [self.contentView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
}

- (UILabel *)bluetoothLabel {
    if (!_bluetoothLabel) {
        _bluetoothLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bluetoothLabel.textColor = kFont3Color;
        _bluetoothLabel.text = @"sdfrfgsdg";
        _bluetoothLabel.numberOfLines = 1;
        _bluetoothLabel.textAlignment = NSTextAlignmentLeft;
        [_bluetoothLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    }
    return _bluetoothLabel;
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

- (void)setConnectName:(NSString *)connectName {
    _connectName = connectName;
    if (connectName && connectName.length > 0) {
        _connectHintLabel.hidden = NO;
    }else{
        _connectHintLabel.hidden = YES;
    }
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return [ZPublicManager getIsIpad] ? 80:50;
}
@end

