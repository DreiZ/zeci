//
//  ZDataListSearchView.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataListSearchView.h"

@interface ZDataListSearchView ()<UITextFieldDelegate>
@property (nonatomic,strong) UITextField *searchTextField;
@end

@implementation ZDataListSearchView


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
    
    [self addSubview:self.searchTextField];
    [self.searchTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
        make.height.mas_equalTo(30);
        make.left.equalTo(self.mas_left).offset(15);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
}

- (UITextField *)searchTextField {
    if (!_searchTextField ) {
        _searchTextField  = [[UITextField alloc] init];
        _searchTextField.layer.masksToBounds = YES;
        _searchTextField.layer.cornerRadius = 10;
        _searchTextField.layer.borderColor = kMainColor.CGColor;
        _searchTextField.layer.borderWidth = 1;
        [_searchTextField setFont:[UIFont systemFontOfSize:13]];
        [_searchTextField setBorderStyle:UITextBorderStyleNone];
        [_searchTextField setBackgroundColor:[UIColor clearColor]];
        [_searchTextField setReturnKeyType:UIReturnKeySearch];
        [_searchTextField setPlaceholder:@"请输入相关条目"];
        _searchTextField.delegate = self;
        [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 15, 1)];
        _searchTextField.leftView = leftView;
        _searchTextField.leftViewMode = UITextFieldViewModeAlways;
        
        __weak typeof(self) weakSelf = self;
        UIButton *rightView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 47, 30)];
        [rightView setImage:[UIImage imageNamed:@"sousuo"] forState:UIControlStateNormal];
        _searchTextField.rightView = rightView;
        _searchTextField.rightViewMode = UITextFieldViewModeAlways;
        [rightView bk_addEventHandler:^(id sender) {
            if (weakSelf.searchTextField.text && weakSelf.searchTextField.text .length > 0) {
                if (weakSelf.searchBlock) {
                    weakSelf.searchBlock(weakSelf.searchTextField.text);
                }
            }else{
                [self.superview showSuccessWithMsg:@"请输入内容"];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _searchTextField;
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
    
    if (_valueChange) {
        _valueChange(textField.text);
    }
    
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    return YES;
}

@end
