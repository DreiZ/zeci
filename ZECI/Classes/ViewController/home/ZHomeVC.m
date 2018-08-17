//
//  ZHomeVC.m
//  ZECI
//
//  Created by zzz on 2018/6/25.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeVC.h"
#import "ZHomeNavView.h"
#import "ZHomeConnectCell.h"
#import "ZHomeBluetoothListCell.h"
#import "LoadingAnimationView.h"

#import "ZCompanyInfoVC.h"
#import "ZDataListVC.h"
#import "ZMeasureVC.h"
#import "ZHomeModel.h"

@interface ZHomeVC ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZHomeNavView *navView;

@property (nonatomic,strong) CBPeripheral *connectPeripheral;
@property (nonatomic,strong) UILabel *bluetoothStateLabel;
@property (nonatomic,strong) UIView *bluetoothSearchView;

@end

@implementation ZHomeVC

+(UINavigationController *)defaultNavi {
    
    ZHomeVC *homevc = [[ZHomeVC alloc] init];
    
    UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:homevc];
    
    return navi;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationView];
    [self setMainUI];
    
    [self setBluetooth];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (_iTableView) {
        [_iTableView reloadData];
    }
}

- (void)setupNavigationView {
    self.customNavBar.hidden = YES;
    
    self.view.backgroundColor = kBackColor;
}

- (void)setMainUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    [self.view addSubview:self.iTableView];
    [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_bottom).offset(-50
                                                         );
        make.top.equalTo(self.navView.mas_bottom).offset(10);
    }];
    
    self.bluetoothSearchView = [self bluetoothSearchView];
}

- (void)setBluetooth {
    __weak typeof(self) weakSelf = self;
    
    [ZPublicBluetoothManager shareInstance].findChangeBlock = ^{
        [weakSelf.iTableView reloadData];
    };
    
    [ZPublicBluetoothManager shareInstance].connectBlock = ^(CBPeripheral *cbPeripheral) {
        weakSelf.connectPeripheral = cbPeripheral;
        [weakSelf.iTableView reloadData];
    };
    
    [ZPublicBluetoothManager shareInstance].testMatchingBlock = ^{
        [[AppDelegate App] showSuccessWithMsg:@"连接匹配成功"];
        [weakSelf stopAnimationView];
        ZMeasureVC *svc = [[ZMeasureVC alloc] init];
        [weakSelf.navigationController pushViewController:svc animated:YES];
    };
    
    [ZPublicBluetoothManager shareInstance].bluetoothChangeBlock = ^{
        if ([ZPublicBluetoothManager shareInstance].peripheralState == CBManagerStatePoweredOn && ![ZPublicBluetoothManager shareInstance].cbPeripheral) {
            [[ZPublicBluetoothManager shareInstance] scanForPeripherals];
        }
    
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([ZPublicBluetoothManager shareInstance].peripheralState == CBManagerStatePoweredOn) {
                weakSelf.bluetoothStateLabel.text = @"";
                weakSelf.navView.bluetoothState = YES;
            }else{
                weakSelf.bluetoothStateLabel.text = @"手机蓝牙未打开";
                weakSelf.navView.bluetoothState = NO;
            }
        });
    };
    
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:@"bluetoothChange" object:nil] subscribeNext:^(NSNotification * _Nullable noti) {
        [[ZPublicBluetoothManager shareInstance] scanForPeripherals];
        if (weakSelf.iTableView) {
            [weakSelf.iTableView reloadData];
        }
    }];
   
}

- (UIView *)bluetoothSearchView {
    
    UIView *bluetoothSearchView = [[UIView alloc] init];
    [self.view addSubview:bluetoothSearchView];
    [bluetoothSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo([ZPublicManager getIsIpad] ? 100:80);
    }];
    
    __weak typeof(self) weakSelf = self;
    UIButton *searchBluetoothBtn = [[UIButton alloc] initWithFrame:CGRectZero];
    [searchBluetoothBtn bk_addEventHandler:^(id sender) {
        [[ZPublicBluetoothManager shareInstance].peripherals removeAllObjects];
        [weakSelf startAnimationView];
        [[ZPublicBluetoothManager shareInstance] scanForPeripherals];
    } forControlEvents:UIControlEventTouchUpInside];
    [searchBluetoothBtn setTitleEdgeInsets:UIEdgeInsetsMake(0, 0, -24, 0)];
    [searchBluetoothBtn setTitleColor:kFont6Color forState:UIControlStateNormal];
    [searchBluetoothBtn setTitle:@"刷新" forState:UIControlStateNormal];
    [searchBluetoothBtn.titleLabel setFont:[UIFont systemFontOfSize:12]];
    [bluetoothSearchView addSubview:searchBluetoothBtn];
    [searchBluetoothBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(bluetoothSearchView);
        make.top.bottom.equalTo(bluetoothSearchView);
        make.width.equalTo(searchBluetoothBtn.mas_height);
    }];
    
    return bluetoothSearchView;
}

- (void)startAnimationView {
    [LoadingAnimationView showInView:self.bluetoothSearchView];
    
}
- (void)stopAnimationView {
    [LoadingAnimationView dismiss];
    
}

#pragma mark lazy loading...
-(ZHomeNavView *)navView {
    if (!_navView) {
        __weak typeof(self) weakSelf = self;
        _navView = [[ZHomeNavView alloc] init];
        _navView.topSelectBlock = ^(NSInteger index) {
            if (index == 1) {
                ZCompanyInfoVC *companyVC = [[ZCompanyInfoVC alloc] init];
                [weakSelf.navigationController pushViewController:companyVC animated:YES];
            }else if (index == 2){
                ZDataListVC *listVC = [[ZDataListVC alloc] init];
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            }else{
                if ([ZPublicBluetoothManager shareInstance].peripheralState != CBManagerStatePoweredOn) {
                    [weakSelf showSuccessWithMsg:@"请先打开手机蓝牙"];
                }else{
                    [[ZPublicBluetoothManager shareInstance] scanForPeripherals];
                }
            }
        };
    }
    return _navView;
}

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
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else{
        if ([ZPublicBluetoothManager shareInstance].peripherals) {
            return [ZPublicBluetoothManager shareInstance].peripherals.count;
        }
        return 0;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZHomeConnectCell *cell = [ZHomeConnectCell z_cellWithTableView:tableView];
        if (self.connectPeripheral) {
            cell.connectName = self.connectPeripheral.name;
        }else{
            cell.connectName = @"";
        }
        return cell;
    }else{
        CBPeripheral *cbPeripheral = [ZPublicBluetoothManager shareInstance].peripherals[indexPath.row];
        ZHomeBluetoothListCell *cell = [ZHomeBluetoothListCell z_cellWithTableView:tableView];
        [cell setBluetoothName:cbPeripheral.name];
        return cell;
    }
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [ZHomeConnectCell z_getCellHeight:nil];
    }else{
        return [ZHomeBluetoothListCell z_getCellHeight:nil];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        return [ZPublicManager getIsIpad] ? 60:40;
    }
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 1) {
        UIView *sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, [ZPublicManager getIsIpad] ? 60:40)];
        sectionView.backgroundColor = kBackColor;
        sectionView.clipsToBounds = YES;
        
        
        UILabel *hintLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        hintLabel.textColor = kFont3Color;
        hintLabel.text = @"可连接设备";
        hintLabel.numberOfLines = 0;
        hintLabel.textAlignment = NSTextAlignmentLeft;
        [hintLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 16:13]];
        [sectionView addSubview:hintLabel];
        [hintLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(sectionView);
            make.left.equalTo(sectionView.mas_left).offset(10);
        }];
        
        _bluetoothStateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _bluetoothStateLabel.textColor = kMainColor;
        _bluetoothStateLabel.text = @"手机蓝牙未打开";
        _bluetoothStateLabel.numberOfLines = 0;
        _bluetoothStateLabel.textAlignment = NSTextAlignmentLeft;
        [_bluetoothStateLabel setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 16:13]];
        [sectionView addSubview:_bluetoothStateLabel];
        [_bluetoothStateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(sectionView);
            make.right.equalTo(sectionView.mas_right).offset(-10);
        }];
        if ([ZPublicBluetoothManager shareInstance].peripheralState == CBManagerStatePoweredOn) {
            self.bluetoothStateLabel.text = @"";
            self.navView.bluetoothState = YES;
        }else{
            self.bluetoothStateLabel.text = @"手机蓝牙未打开";
            self.navView.bluetoothState = NO;
        }

        return sectionView;
       
    }
    return nil;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        ZMeasureVC *svc = [[ZMeasureVC alloc] init];
        [self.navigationController pushViewController:svc animated:YES];
    }else{
        [ZPublicBluetoothManager shareInstance].cbPeripheral = [ZPublicBluetoothManager shareInstance].peripherals[indexPath.row];
        [[ZPublicBluetoothManager shareInstance] connectToPeripheral];
    }
}

#pragma mark 屏幕旋转处理
//获取设备方向 更新 UI
-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    if (isHorizontal) {
        
    }else{
       
    }
}
@end
