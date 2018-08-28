//
//  ZCompanyInfoVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZCompanyInfoVC.h"
#import "ZCompanyInfoCell.h"

#import "ZWebVC.h"

@interface ZCompanyInfoVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) NSArray *listArr;

@end

@implementation ZCompanyInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setData];
    [self setNavgation];
    [self setMainView];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"公司信息";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
}

- (void)setData{
    _listArr = @[@[@"公司名称",@"四川翊晟芯科信息技术有限公司"],@[@"联系电话",@"400-1122-300"],@[@"官方网站",@""]];
}

- (void)setMainView {
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-100
                                                         );
        make.top.equalTo(self.view.mas_top).offset(kSafeAreaTopHeight);
    }];
    
    UIView *bottomView = [self bottomView];
    
    [self.view addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
}


- (UILabel *)getLabel:(NSString *)title {
    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = kFont3Color;
    tempLabel.text = title;
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentLeft;
    [tempLabel setFont:[UIFont systemFontOfSize:CGFloatIn750(28)]];
    [self.view addSubview:tempLabel];
    return tempLabel;
}

#pragma mark lazy loading...
-(UITableView *)iTableView {
    if (!_iTableView) {
        _iTableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _iTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _iTableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
        if ([_iTableView respondsToSelector:@selector(contentInsetAdjustmentBehavior)]) {
            _iTableView.estimatedRowHeight = 0;
            _iTableView.estimatedSectionHeaderHeight = 0;
            _iTableView.estimatedSectionFooterHeight = 0;
            if (@available(iOS 11.0, *)) {
                _iTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            } else {
                // Fallback on earlier versions
            }
        } else {
            self.automaticallyAdjustsScrollViewInsets = NO;
        }
        _iTableView.delegate = self;
        _iTableView.dataSource = self;
        _iTableView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
        _iTableView.tableHeaderView = [self topView];
    }
    return _iTableView;
}

- (UIView *)topView {
    UIView *topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, [ZPublicManager getIsIpad] ? 230:170)];
    topView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    
    UIImageView *companyImageView = [[UIImageView alloc] init];
    companyImageView.image = [UIImage imageNamed:@"icon_logo"];
    companyImageView.contentMode = UIViewContentModeScaleAspectFit;
    companyImageView.layer.masksToBounds = YES;
    [topView addSubview:companyImageView];
    [companyImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.centerY.equalTo(topView.mas_centerY).offset(-10);
        make.width.mas_equalTo(CGFloatIn750(229));
        make.height.mas_equalTo(CGFloatIn750(100));
    }];

    UILabel *tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    tempLabel.textColor = kFont6Color;
    tempLabel.text = @"V 1.0.0";
    tempLabel.numberOfLines = 1;
    tempLabel.textAlignment = NSTextAlignmentCenter;
    [tempLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    [topView addSubview:tempLabel];
    [tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(topView.mas_centerX);
        make.top.equalTo(companyImageView.mas_bottom).offset(5);
    }];
    
    return topView;
}

- (UIView *)bottomView {
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectZero];
    bottomView.backgroundColor = [UIColor colorWithHexString:@"f6f6f6"];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    topLabel.textColor = kFont9Color;
    topLabel.text = @"Copyright © 2017-2021 All Rights Reserved.";
    topLabel.numberOfLines = 1;
    topLabel.textAlignment = NSTextAlignmentCenter;
    [topLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    [bottomView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(bottomView.mas_top).offset(20);
    }];
    
    UILabel *bottomLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    bottomLabel.textColor = kFont9Color;
    bottomLabel.text = @"四川翊晟芯信息科技有限公司";
    bottomLabel.numberOfLines = 1;
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    [bottomLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 18:15]];
    [bottomView addSubview:bottomLabel];
    [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(bottomView.mas_centerX);
        make.top.equalTo(topLabel.mas_bottom).offset(4);
    }];
    
    return bottomView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _listArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZCompanyInfoCell *cell = [ZCompanyInfoCell z_cellWithTableView:tableView];
    cell.nameLabel.text = _listArr[indexPath.row][0];
    cell.rightLabel.text = _listArr[indexPath.row][1];
    [cell setHiddenArrowImageView:indexPath.row == 0 ? YES:NO];
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZCompanyInfoCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        NSString *tel = @"4001122300";
        if (tel.length > 0) {
            NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"tel:%@",tel];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str] options:@{} completionHandler:^(BOOL success) {
                
            }];
        }
    }else if(indexPath.row == 2){
        ZWebVC *wvc = [[ZWebVC alloc] init];
        wvc.url = @"http://www.eacenic.cn/";
        [self.navigationController pushViewController:wvc animated:YES];
    }
}
@end
