//
//  ZMeasureSaveImageToPhotoView.m
//  ZECI
//
//  Created by zzz on 2018/8/21.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureSaveImageToPhotoView.h"

@implementation ZMeasureSaveImageToPhotoView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initMainView];
    }
    return self;
}

#pragma mark 初始化view
- (void)initMainView {
    self.backgroundColor = [UIColor clearColor];
    self.clipsToBounds = YES;
    self.layer.masksToBounds = YES;
    
    UIImageView *saveImageView = [[UIImageView alloc] init];
    saveImageView.image = [UIImage imageNamed:@"baocun"];
    saveImageView.layer.masksToBounds = YES;
    [self addSubview:saveImageView];
    [saveImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo([ZPublicManager getIsIpad] ? 45:34);
        make.height.mas_equalTo([ZPublicManager getIsIpad] ? 48:36);
        make.centerX.equalTo(self.mas_centerX).offset(0);
        make.top.equalTo(self.mas_top);
    }];
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.textColor = kMainColor;
    titleLabel.text = @"保存折线图到相册";
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [titleLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ?14.0f:12.0f]];
    [self addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(saveImageView.mas_bottom).offset([ZPublicManager getIsIpad] ? 10:7);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *saveBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [saveBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.saveBlock) {
            weakSelf.saveBlock();
        }
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:saveBtn];
    [saveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}

@end
