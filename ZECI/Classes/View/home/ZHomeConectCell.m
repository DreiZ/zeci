//
//  ZHomeConectCell.m
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeConectCell.h"

@interface ZHomeConectCell ()
@property (nonatomic,strong) UILabel *bluetoothLabel;
@end

@implementation ZHomeConectCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    static NSString *identifier = @"ZHomeConectCell";
    
    ZHomeConectCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[ZHomeConectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
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
    [hintLabel setFont:[UIFont systemFontOfSize:16.0f]];
    [self.contentView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(84);
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
        [_bluetoothLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(30)]];
    }
    return _bluetoothLabel;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return 50;
}
@end

