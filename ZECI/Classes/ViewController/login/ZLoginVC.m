//
//  ZLoginVC.m
//  ZECI
//
//  Created by zzz on 2018/6/25.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZLoginVC.h"
#import "ZRetrieveVC.h"
#import "ZGetPasswordVC.h"
#import "ZThridPartyBindlingVC.h"

#import "ZLoginViewModel.h"

@interface ZLoginVC ()<UITextFieldDelegate>
//输入类型
@property (assign, nonatomic) ZFormatterType formatterType;
//自定义类型
@property (strong, nonatomic) NSString *inputTypeStr;
//长度限制 默认8
@property (assign, nonatomic) NSInteger max;

@property (nonatomic,strong) UIButton *closeBtn;
@property (nonatomic,strong) UIButton *loginBtn;
@property (nonatomic,strong) UIButton *resignBtn;
@property (nonatomic,strong) UIButton *getPasswdBtn;

@property (nonatomic,strong) UITextField *userNameTF;
@property (nonatomic,strong) UITextField *passwordTF;


@property (nonatomic,strong) ZLoginViewModel *loginViewModel;
@end

@implementation ZLoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.customNavBar setHidden:YES];
    [self setupMainView];
    
}

- (void)setupMainView {
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self.view addSubview:self.closeBtn];
    [_closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(6);
        make.top.equalTo(self.view.mas_top).offset(27);
        make.width.height.mas_equalTo(35);
    }];
    
    [self.view addSubview:self.userNameTF];
    [_userNameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(44);
        make.right.equalTo(self.view.mas_right).offset(-44);
        make.bottom.equalTo(self.view.mas_centerY).offset(-44);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.passwordTF];
    [_passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left).offset(44);
        make.right.equalTo(self.view.mas_right).offset(-44);
        make.bottom.equalTo(self.view.mas_centerY).offset(15);
        make.height.mas_equalTo(30);
    }];
    
    [self.view addSubview:self.loginBtn];
    [_loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(40);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(75);
        make.left.equalTo(self.view.mas_left).offset(48);
        make.right.equalTo(self.view.mas_right).offset(-48);
    }];
    
    _resignBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_resignBtn setTitle:@"注册" forState:UIControlStateNormal];
    [_resignBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [_resignBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:_resignBtn];
    [_resignBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.passwordTF.mas_right).offset(10);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    _getPasswdBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [_getPasswdBtn addTarget:self action:@selector(getPasswdBtnOnclick:) forControlEvents:UIControlEventTouchUpInside];
    [_getPasswdBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_getPasswdBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    [_getPasswdBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [self.view addSubview:_getPasswdBtn];
    [_getPasswdBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.passwordTF.mas_left);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(10);
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
    }];
    
    
    UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomLineView.backgroundColor = kFont3Color;
    [self.view addSubview:bottomLineView];
    [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.loginBtn.mas_left).offset(8);
        make.right.equalTo(self.loginBtn.mas_right).offset(-8);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(55);
        make.height.mas_equalTo(0.5);
    }];
    
    
    UILabel *thLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    thLabel.textColor = [UIColor colorWithHexString:@"a3a3a3"];
    thLabel.text = @"第三方登录";
    thLabel.numberOfLines = 0;
    thLabel.backgroundColor = [UIColor whiteColor];
    thLabel.textAlignment = NSTextAlignmentCenter;
    [thLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [self.view addSubview:thLabel];
    [thLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(68);
        make.centerY.equalTo(bottomLineView.mas_centerY);
        make.centerX.equalTo(bottomLineView.mas_centerX);
    }];
    
    
    NSArray *titleArr = @[@"QQ登录",@"微信登录"];
    NSArray *imageArr = @[@"qqdenglu",@"weixindenglu"];
    NSMutableArray *hintLabelArr = @[].mutableCopy;
    NSMutableArray *btnArr = @[].mutableCopy;
    for (int i = 0; i < titleArr.count; i++) {
        [hintLabelArr addObject:[self getLabel:titleArr[i]]];
        [btnArr addObject:[self getBtn:i image:imageArr[i]]];
    }
    
    
    [hintLabelArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:50 tailSpacing:50];
    [btnArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:50 tailSpacing:50];
    
    UIButton *btn = btnArr[0];
    [btnArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(thLabel.mas_bottom).offset(CGFloatIn750(20));
    }];
    
    [hintLabelArr mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn.mas_bottom).offset(CGFloatIn750(14));
    }];
}

#pragma mark 懒加载及 initView
- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = kFontA3Color;
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(24)]];
    [self.view addSubview:tempLabel];
    return tempLabel;
}

- (UIButton *)getBtn:(NSInteger)index  image:(NSString *)image{
    UIButton *tempBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [tempBtn addTarget:self action:@selector(bindBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [tempBtn bk_addEventHandler:^(UIButton *sender) {
        
    } forControlEvents:UIControlEventTouchUpInside];
    
    tempBtn.tag = index;
    [tempBtn setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    [self.view addSubview:tempBtn];
    return tempBtn;
}

- (UIButton *)closeBtn {
    if (!_closeBtn) {
        _closeBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_closeBtn addTarget:self action:@selector(closeBtnOnClick:) forControlEvents:UIControlEventTouchUpInside];
        [_closeBtn setBackgroundImage:[UIImage imageNamed:@"loginclose"] forState:UIControlStateNormal];
    }
    return _closeBtn;
}


- (UITextField *)userNameTF {
    if (!_userNameTF ) {
        UILabel *leftView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 35, 30)];
        leftView.textColor = kFont3Color;
        leftView.text = @"+86";
        leftView.numberOfLines = 0;
        leftView.textAlignment = NSTextAlignmentCenter;
        [leftView setFont:[UIFont systemFontOfSize:12.0f]];
        
        _userNameTF  = [[UITextField alloc] init];
        _userNameTF.tag = 101;
        [_userNameTF setFont:[UIFont systemFontOfSize:12]];
        _userNameTF.leftView = leftView;
        _userNameTF.leftViewMode = UITextFieldViewModeAlways;
        [_userNameTF setBorderStyle:UITextBorderStyleNone];
        [_userNameTF setBackgroundColor:[UIColor clearColor]];
        [_userNameTF setReturnKeyType:UIReturnKeySearch];
        [_userNameTF setPlaceholder:@"手机号码"];
        _userNameTF.delegate = self;
        _userNameTF.keyboardType = UIKeyboardTypePhonePad;
        [_userNameTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"a0a0a0"];
        [_userNameTF addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.userNameTF);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _userNameTF;
}


- (UITextField *)passwordTF {
    if (!_passwordTF ) {
        _passwordTF = [[UITextField alloc] init];
        _passwordTF.tag = 102;
        [_passwordTF setFont:[UIFont systemFontOfSize:12]];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        [_passwordTF setBorderStyle:UITextBorderStyleNone];
        [_passwordTF setBackgroundColor:[UIColor clearColor]];
        [_passwordTF setReturnKeyType:UIReturnKeySearch];
        [_passwordTF setPlaceholder:@"密码"];
        [_passwordTF setSecureTextEntry:YES];
        _passwordTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 130)];
        _passwordTF.leftViewMode = UITextFieldViewModeAlways;
        _passwordTF.delegate = self;
        _passwordTF.keyboardType = UIKeyboardTypeDefault;
        [_passwordTF addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
        
        UIView *bottomLineView = [[UIView alloc] initWithFrame:CGRectZero];
        bottomLineView.backgroundColor = [UIColor colorWithHexString:@"a0a0a0"];
        [_passwordTF addSubview:bottomLineView];
        [bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.passwordTF);
            make.height.mas_equalTo(0.5);
        }];
    }
    return _passwordTF;
}

- (UIButton *)loginBtn {
    if (!_loginBtn) {
        _loginBtn = [[UIButton alloc] initWithFrame:CGRectZero];
        [_loginBtn bk_addEventHandler:^(id sender) {
            if (self.userNameTF.text.length != 11) {
                [self showErrorWithMsg:@"请输入正确的手机号"];
                return;
            }
            
            if (self.passwordTF.text.length == 0) {
                [self showErrorWithMsg:@"请输入密码"];
                return;
            }
            if (self.passwordTF.text.length < 6) {
                [self showErrorWithMsg:@"密码长度不能小于6位"];
                return;
            }
            
//            [self.loginViewModel loginWithUsername:self.userNameTF.text password:self.passwordTF.text block:^(BOOL isSuccess, NSString *message) {
//                
//            }];
        } forControlEvents:UIControlEventTouchUpInside];
        
        _loginBtn.layer.masksToBounds = YES;
        _loginBtn.layer.cornerRadius = 20;
        _loginBtn.backgroundColor = kMainColor;
        [_loginBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_loginBtn.titleLabel setFont:[UIFont systemFontOfSize:18]];
    }
    return _loginBtn;
}

#pragma mark 按钮 click


- (void)bindBtnClick:(id)sender {
    
}

- (void)getPasswdBtnOnclick:(id)sender {
    
}

#pragma mark textField delegate ---------
- (void)textFieldDidChange:(UITextField*)textField {
    if (_formatterType == ZFormatterTypeDecimal) {
        if ([textField.text  doubleValue] - pow(10, _max) - 0.01  > 0.000001) {
            [self showErrorWithMsg:@"输入内容超出限制"];
            NSString *str = [textField.text substringToIndex:textField.text.length - 1];
            textField.text = str;
        }
        

        return;
        
    }
    if (textField.text.length > _max) {
        [self showErrorWithMsg:@"输入内容超出限制"];
        
        NSString *str = textField.text;
        NSInteger length = _max;
        if (str.length <= length) {
            length = str.length - 1;
        }
        str = [str substringToIndex:length];
        textField.text = str;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField.tag == 101) {
        _formatterType = ZFormatterTypePhoneNumber;
        _max = 11;
    }else if (textField.tag == 102) {
        _formatterType = ZFormatterTypeAny;
        _max = 12;
    }
    
    NSString *regexString;
    switch (_formatterType) {
        case ZFormatterTypeAny:
        {
            return YES;
        }
        case ZFormatterTypePhoneNumber:
        {
            regexString = @"^\\d{0,11}$";
            break;
        }
        case ZFormatterTypeNumber:
        {
            regexString = @"^\\d*$";
            break;
        }
        case ZFormatterTypeDecimal:
        {
            regexString = [NSString stringWithFormat:@"^(\\d+)\\.?(\\d{0,%lu})$", (unsigned long)2];
            break;
        }
        case ZFormatterTypeAlphabet:
        {
            regexString = @"^[a-zA-Z]*$";
            break;
        }
        case ZFormatterTypeNumberAndAlphabet:
        {
            regexString = @"^[a-zA-Z0-9]*$";
            break;
        }
        case ZFormatterTypeIDCard:
        {
            regexString = @"^\\d{1,17}[0-9Xx]?$";
            break;
        }
        case ZFormatterTypeCustom:
        {
            regexString = [NSString stringWithFormat:@"^[%@]{0,%lu}$", _inputTypeStr, (long)_max];
            break;
        }
        default:
            break;
    }
    NSString *currentText = [textField.text stringByReplacingCharactersInRange:range withString:string];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regexString];
    
    return [regexTest evaluateWithObject:currentText] || currentText.length == 0;
}


- (void)closeBtnOnClick:(id)sender {
//    [self.navigationController popViewControllerAnimated:YES];
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
@end

