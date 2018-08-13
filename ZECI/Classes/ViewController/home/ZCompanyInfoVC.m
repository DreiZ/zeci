//
//  ZCompanyInfoVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZCompanyInfoVC.h"

@interface ZCompanyInfoVC ()

@end

@implementation ZCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavgation];
    [self setMainView];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"公司信息";
}

- (void)setMainView {
    UIImageView *companyImageView = [[UIImageView alloc] init];
    companyImageView.image = [UIImage imageNamed:@"logo"];
    companyImageView.layer.masksToBounds = YES;
    [self.view addSubview:companyImageView];
    [companyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(40+kSafeAreaTopHeight);
    }];
    
    
    
    NSArray *titleArr = @[@"四川翊晟芯科信息技术有限公司",
                          @"版本号：V1.0.0",
                          @"联系方式：400-1122-300",
                          @"网站：http://www.eacenic.cn/"];
    UIView  *tempView = nil;
    for (int i = 0; i < titleArr.count; i++) {
        UILabel *tempLabel = [self getLabel:titleArr[i]];
        if (tempView) {
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(56);
                make.top.equalTo(tempView.mas_bottom).offset(27);
            }];
        }else{
            [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.view).offset(56);
                make.top.equalTo(companyImageView.mas_bottom).offset(45);
            }];
        }
        tempView = tempLabel;
    }
}


- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = kFont3Color;
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentLeft;
    [tempLabel setFont:[UIFont systemFontOfSize:14]];
    [self.view addSubview:tempLabel];
    return tempLabel;
}

@end
