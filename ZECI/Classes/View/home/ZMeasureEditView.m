//
//  ZMeasureEditView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureEditView.h"

@interface ZMeasureEditView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *editTextField;
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thridLabel;
@end

@implementation ZMeasureEditView

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
    
    __weak typeof(self) weakSelf = self;
    UIButton *backBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [backBtn setBackgroundColor:[UIColor blackColor]];
    backBtn.alpha = 0.5;
    [backBtn bk_addEventHandler:^(id sender) {
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    
    UIView *contView = [[UIView alloc] initWithFrame:CGRectZero];
    contView.backgroundColor = [UIColor whiteColor];
    contView.layer.masksToBounds = YES;
    contView.layer.cornerRadius = 6;
    [self addSubview:contView];
    [contView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(CGFloatIn750(530));
        make.width.mas_equalTo(CGFloatIn750(560));
    }];
    
    UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    hintLabel.textColor = kFont3Color;
    hintLabel.text = @"修改数据";
    hintLabel.numberOfLines = 0;
    hintLabel.textAlignment = NSTextAlignmentLeft;
    [hintLabel setFont:[UIFont systemFontOfSize:18.0f]];
    [contView addSubview:hintLabel];
    [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.top.equalTo(contView.mas_top).offset(25);
    }];
    
    [contView addSubview:self.firstLabel];
    [self.firstLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.top.equalTo(hintLabel.mas_bottom).offset(20);
    }];
    
    [contView addSubview:self.secondLabel];
    [self.secondLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.top.equalTo(self.firstLabel.mas_bottom).offset(12);
    }];

    [contView addSubview:self.thridLabel];
    [self.thridLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.top.equalTo(self.secondLabel.mas_bottom).offset(12);
    }];
    
    UILabel *editLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    editLabel.textColor = kFont3Color;
    editLabel.text = @"耳标修改为";
    editLabel.numberOfLines = 0;
    editLabel.textAlignment = NSTextAlignmentLeft;
    [editLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [contView addSubview:editLabel];
    [editLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contView.mas_left).offset(25);
        make.top.equalTo(self.thridLabel.mas_bottom).offset(22);
    }];
    
    
    UIButton *sureBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [sureBtn setTitle:@"确定" forState:UIControlStateNormal];
    [sureBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [sureBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [contView addSubview:sureBtn];
    [sureBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(55);
        make.height.mas_equalTo(26);
        make.right.equalTo(contView.mas_right).offset(-10);
        make.bottom.equalTo(contView.mas_bottom).offset(-20);
    }];
    [sureBtn bk_addEventHandler:^(id sender) {
        if (weakSelf.sureBlock) {
            weakSelf.sureBlock(weakSelf.editTextField.text);
        }
        [weakSelf removeFromSuperview];
    } forControlEvents:UIControlEventTouchUpInside];
    
    [contView addSubview:self.editTextField];
    [self.editTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(sureBtn.mas_top).offset(-6);
        make.height.mas_equalTo(40);
        make.left.equalTo(contView.mas_left).offset(15);
        make.right.equalTo(contView.mas_right).offset(-15);
    }];
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kMainColor;
    [contView addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.editTextField);
        make.top.equalTo(self.editTextField.mas_bottom);
        make.height.mas_equalTo(1);
    }];
    
    self.editTextField.text = @"2342342345";
}

- (UILabel *)firstLabel {
    if (!_firstLabel) {
        _firstLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _firstLabel.textColor = kFont3Color;
        _firstLabel.text = @"3234233";
        _firstLabel.numberOfLines = 1;
        _firstLabel.textAlignment = NSTextAlignmentLeft;
        [_firstLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _firstLabel;
}

- (UILabel *)thridLabel {
    if (!_thridLabel) {
        _thridLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _thridLabel.textColor = kFont3Color;
        _thridLabel.text = @"122223";
        _thridLabel.numberOfLines = 1;
        _thridLabel.textAlignment = NSTextAlignmentLeft;
        [_thridLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _thridLabel;
}


- (UILabel *)secondLabel {
    if (!_secondLabel) {
        _secondLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _secondLabel.textColor = kFont3Color;
        _secondLabel.text = @"444442";
        _secondLabel.numberOfLines = 1;
        _secondLabel.textAlignment = NSTextAlignmentLeft;
        [_secondLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(26)]];
    }
    return _secondLabel;
}


- (UITextField *)editTextField {
    if (!_editTextField ) {
        _editTextField  = [[UITextField alloc] init];
//        _editTextField.layer.masksToBounds = YES;
//        _editTextField.layer.cornerRadius = 10;
//        _editTextField.layer.borderColor = kMainColor.CGColor;
//        _editTextField.layer.borderWidth = 1;
        _editTextField.textAlignment = NSTextAlignmentCenter;
        _editTextField.textColor = kFont6Color;
        [_editTextField setFont:[UIFont systemFontOfSize:14]];
        [_editTextField setBorderStyle:UITextBorderStyleNone];
        [_editTextField setBackgroundColor:[UIColor clearColor]];
        [_editTextField setReturnKeyType:UIReturnKeySearch];
        [_editTextField setPlaceholder:@"请输入相关条目"];
        _editTextField.delegate = self;
        [_editTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    }
    return _editTextField;
}


- (void)textFieldDidChange:(UITextField*)textField {
    if (textField.text.length > 20) {
        [self showSuccessWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = 20;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}
@end
