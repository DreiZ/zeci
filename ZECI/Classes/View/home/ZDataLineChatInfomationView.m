//
//  ZDataLineChatInfomationView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataLineChatInfomationView.h"

@interface ZDataLineChatInfomationView ()
@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation ZDataLineChatInfomationView


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
    
    [self addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(0);
        make.right.equalTo(self.mas_right).offset(-12);
    }];
    
    
    NSArray *colors = @[[UIColor colorWithHexString:@"fe5151"],
                        [UIColor colorWithHexString:@"00cc42"],
                        [UIColor colorWithHexString:@"0091ff"]];
    NSArray *titleArr = @[@"第一层数据",@"第二层数据",@"第三层数据"];
    
    UIView *tempView = nil;
    for (int i = 0; i < colors.count; i++) {
        UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        tempLabel.textColor = [UIColor colorWithHexString:@"1b1b1b"];
        tempLabel.text = [NSString stringWithFormat:@"%@",titleArr[i]];
        tempLabel.numberOfLines = 1;
        tempLabel.textAlignment = NSTextAlignmentLeft;
        [tempLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(18)]];
        [self addSubview:tempLabel];
        if (!tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(self.mas_top).offset(55);
                make.right.equalTo(self.mas_right).offset(-12);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.equalTo(tempView.mas_bottom).offset(10);
                make.right.equalTo(self.mas_right).offset(-12);
            }];
        }
        tempView = tempLabel;
        
        UIView *hintView = [[UIView alloc] initWithFrame:CGRectZero];
        hintView.backgroundColor = colors[i];
        hintView.layer.masksToBounds = YES;
        [self addSubview:hintView];
        [hintView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(tempLabel.mas_centerY);
            make.right.equalTo(tempLabel.mas_left).offset(-12);
            make.height.width.mas_equalTo(8);
        }];
    }
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _titleLabel.textColor = kFont6Color;
        _titleLabel.text = @"耳标编号：23240923";
        _titleLabel.numberOfLines = 1;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        [_titleLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    }
    return _titleLabel;
}

@end
