//
//  ZMeasureVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZMeasureVC.h"
#import "ZCompanyInfoVC.h"
#import "ZDataListVC.h"

#import "ZMeasureTopView.h"
#import "ZMeasureEditView.h"
#import "ZMeasureNavView.h"
#import "ZMeasureSaveView.h"
#import "ZMeasureSaveAlertView.h"
#import "ZMeasureListCell.h"
#import "AppDelegate.h"
#import "ZGuideView.h"

#import "ZHomeViewModel.h"

static NSInteger zindex = 0;

@interface ZMeasureVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic,strong) ZMeasureNavView *navView;
@property (nonatomic,strong) ZMeasureTopView *topView;
@property (nonatomic,strong) ZMeasureEditView *editView;
@property (nonatomic,strong) ZMeasureSaveView *saveView;
@property (nonatomic,strong) ZMeasureSaveAlertView *saveAlertView;
@property (nonatomic,strong) ZGuideView *guideV;

@property (nonatomic,strong) UITableView *iTableView;
@property (nonatomic,strong) ZSingleData *selectData;
@property (nonatomic,strong) ZSingleData *testData;
@property (nonatomic,strong) UILabel *tempLabel;

@property (nonatomic,assign) BOOL isBackSave;
@end

@implementation ZMeasureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationView];
    [self setMainView];
    [self setTestBluetooth];
}


- (void)setupNavigationView {
    self.customNavBar.hidden = YES;
    self.view.backgroundColor = kBackColor;
}


- (void)setMainView {
    [self.view addSubview:self.navView];
    [self.navView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(kSafeAreaTopHeight);
    }];
    
    if (self.isHorizontal) {
        [self.view addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
            make.width.mas_equalTo(kWindowW/2.0f);
        }];
        
        [self.view addSubview:self.iTableView];
        [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom).offset(10);
            make.left.equalTo(self.topView.mas_right);
        }];
        
        [self.view addSubview:self.saveView];
        [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 80:60);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -20 : -15);
            make.left.equalTo(self.view.mas_left).offset([ZPublicManager getIsIpad] ? 15:12);
        }];
        
        [self.topView resetUIWith:[ZPublicManager getIsIpad]];
    }else {
        
        [self.view addSubview:self.topView];
        [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(434));
        }];
        
        [self.view addSubview:self.iTableView];
        [self.iTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.topView.mas_bottom).offset(0);
        }];
        
        [self.view addSubview:self.saveView];
        [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 80:60);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -20 : -15);
            make.left.equalTo(self.view.mas_left).offset([ZPublicManager getIsIpad] ? 15:12);
        }];
    }
}

- (void)setTestBluetooth {
    __weak typeof(self) weakSelf = self;
    [ZPublicBluetoothManager shareInstance].testDataBlock = ^(NSString *testData) {
        NSInteger tempTime = [ZPublicManager getNowTimestamp];
        
        weakSelf.testData.testTime = [NSString stringWithFormat:@"%ld",tempTime + zindex * 24*60*60];//
        
        if (testData && testData.length > 0 && [testData hasSuffix:@"E"]) {
            if ([testData hasPrefix:@"R"]){
                //耳标数据
                weakSelf.testData.earTag = testData;
                
            }else if ([testData hasPrefix:@"H"] ) {
                //定格测量数据
                [self setTestBlueDataWithData:testData withIndex:1];
                
                [weakSelf addTestData:weakSelf.testData];
                weakSelf.testData = nil;
                
            }else if ([testData hasPrefix:@"D"]){
                //电量
            }else if ([testData hasPrefix:@"B"]){
                //实时数据
                [self setTestBlueDataWithData:testData withIndex:1];
                
            }else {
                //以数字开头
                char commitChar = [testData characterAtIndex:0];
                //实时数据
                if ((commitChar>47)&&(commitChar<58)) {
                    [self setTestBlueDataWithData:testData withIndex:0];
                }
            }
        }
    };
}

- (void)setTestBlueDataWithData:(NSString *)testData withIndex:(NSInteger)offsetCount{
    
    if (testData.length > 2+offsetCount) {
        self.testData.firstNum = [testData substringWithRange:NSMakeRange(0+offsetCount,2)];
    }
    
    if (testData.length > 4+offsetCount) {
        self.testData.secondNum = [testData substringWithRange:NSMakeRange(2+offsetCount,2)];
    }
    
    if (testData.length > 6+offsetCount) {
        self.testData.thirdNum = [testData substringWithRange:NSMakeRange(4+offsetCount,2)];
    }
    
    if (self.topView) {
        self.topView.firstLabel.text = self.testData.firstNum;
        self.topView.secondLabel.text = self.testData.secondNum;
        self.topView.thridLabel.text = self.testData.thirdNum;
    }
}

#pragma mark lazy loading...
-(ZSingleData *)testData {
    if (!_testData) {
        _testData = [[ZSingleData alloc] init];
    }
    return _testData;
}

- (ZMeasureNavView *)navView {
    if (!_navView) {
        __weak typeof(self) weakSelf = self;
        _navView = [[ZMeasureNavView alloc] init];
        _navView.topSelectBlock = ^(NSInteger index) {
            if (index == 1) {
                ZCompanyInfoVC *companyVC = [[ZCompanyInfoVC alloc] init];
                [weakSelf.navigationController pushViewController:companyVC animated:YES];
            }else if (index == 2){
                ZDataListVC *listVC = [[ZDataListVC alloc] init];
                [weakSelf.navigationController pushViewController:listVC animated:YES];
            }else{
                if ([ZHomeViewModel shareInstance].testPigs && [ZHomeViewModel shareInstance].testPigs.count > 0) {
                    [weakSelf backSaveTestPigsData];
                }else{
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }
        };
        
//        _tempLabel = [[UILabel alloc] initWithFrame:CGRectZero];
//        _tempLabel.textColor = [UIColor whiteColor];
//        _tempLabel.text = [NSString stringWithFormat:@"%ld",zindex];
//        _tempLabel.numberOfLines = 0;
//        _tempLabel.textAlignment = NSTextAlignmentCenter;
//        [_tempLabel setFont:[UIFont systemFontOfSize:16.0f]];
//        [_navView addSubview:_tempLabel];
//        [_tempLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.centerX.equalTo(self.navView.mas_centerX);
//            make.bottom.equalTo(self.navView.mas_bottom).offset(-20);
//        }];
//
//        UIButton *te1Btn = [[UIButton alloc] initWithFrame:CGRectZero];
//        te1Btn.backgroundColor = [UIColor whiteColor];
//        [te1Btn bk_addEventHandler:^(id sender) {
//            zindex--;
//            self.tempLabel.text = [NSString stringWithFormat:@"%ld",zindex];
//        } forControlEvents:UIControlEventTouchUpInside];
//        [_navView addSubview:te1Btn];
//        [te1Btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(40);
//            make.centerY.equalTo(self.tempLabel.mas_centerY);
//            make.right.equalTo(self.tempLabel.mas_left).offset(-20);
//        }];
//
//        UIButton *te2Btn = [[UIButton alloc] initWithFrame:CGRectZero];
//        te2Btn.backgroundColor = [UIColor blackColor];
//        [te2Btn bk_addEventHandler:^(id sender) {
//            zindex++;
//            self.tempLabel.text = [NSString stringWithFormat:@"%ld",zindex];
//        } forControlEvents:UIControlEventTouchUpInside];
//        [_navView addSubview:te2Btn];
//        [te2Btn mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.width.height.mas_equalTo(40);
//            make.centerY.equalTo(self.tempLabel.mas_centerY);
//            make.left.equalTo(self.tempLabel.mas_right).offset(20);
//        }];
    }
    return _navView;
}

- (ZMeasureTopView *)topView {
    if (!_topView) {
        _topView = [[ZMeasureTopView alloc] init];
    }
    
    return _topView;
}

- (ZMeasureEditView *)editView {
    if (!_editView) {
        __weak typeof(self) weakSelf = self;
        _editView = [[ZMeasureEditView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        _editView.sureBlock = ^(NSString *earTag) {
            weakSelf.editView.singleData.earTag = earTag;
            [weakSelf.iTableView reloadData];
            [[ZHomeViewModel shareInstance] updateTestHistory];
        };
    }
    _editView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    return _editView;
}

- (ZMeasureSaveView *)saveView {
    if (!_saveView) {
        __weak typeof(self) weakSelf = self;
        _saveView = [[ZMeasureSaveView alloc] init];
        _saveView.saveBlock = ^{
            if ([ZHomeViewModel shareInstance].testPigs && [ZHomeViewModel shareInstance].testPigs.count > 0) {
                [weakSelf saveTestPigsData];
            }else{
                [weakSelf showErrorWithMsg:@"没有测量的数据需要保存"];
            }
        };
    }
    return _saveView;
}

- (ZMeasureSaveAlertView *)saveAlertView {
    if (!_saveAlertView) {
        __weak typeof(self) weakSelf = self;
        _saveAlertView = [[ZMeasureSaveAlertView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        _saveAlertView.sureBlock = ^(NSInteger index) {
            if (index == 0) {
                if (weakSelf.isBackSave) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
            }else{
                [[ZHomeViewModel shareInstance] updateTestDataToAllHistoryData];
                [weakSelf.iTableView reloadData];
                [weakSelf showSuccessWithMsg:@"已保存到数据库"];
            }
        };
    }
    
    _saveAlertView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
    return _saveAlertView;
}

- (void)setGuideView {
    
    BOOL isLoaded = (BOOL)[[NSUserDefaults standardUserDefaults] objectForKey:@"isMeasureLoad"];
    
    if (!isLoaded ) {
        UIWindow *presentView = [[AppDelegate App] window];
        if (self.isHorizontal) {
            
            ZGuideView *guideV = [[ZGuideView alloc] initWithTestGuideView:presentView.bounds holeRect:CGRectMake(([ZPublicManager getIsIpad] ? 24:12) + kWindowW/2.0f, kSafeAreaTopHeight+10, kWindowW/2.0f-([ZPublicManager getIsIpad] ? 24:12)*2, [ZMeasureListCell z_getCellHeight:nil])];
            _guideV = guideV;
            [presentView addSubview:guideV];
            
        }else{
            
            ZGuideView *guideV = [[ZGuideView alloc] initWithTestGuideView:presentView.bounds holeRect:CGRectMake([ZPublicManager getIsIpad] ? 24:12 , kSafeAreaTopHeight + CGFloatIn750(434), kWindowW-([ZPublicManager getIsIpad] ? 24:12)*2, [ZMeasureListCell z_getCellHeight:nil])];
            _guideV = guideV;
            [presentView addSubview:guideV];
            
        }
    }
}

- (UITableView *)iTableView {
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
        _iTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 64)];
    }
    return _iTableView;
}

#pragma mark tableView -------datasource-----
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [ZHomeViewModel shareInstance].testPigs.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZMeasureListCell *cell = [ZMeasureListCell z_cellWithTableView:tableView];
    cell.singleData = [ZHomeViewModel shareInstance].testPigs[indexPath.row];
    cell.isSelectData = ([ZHomeViewModel shareInstance].testPigs[indexPath.row] == self.selectData);
    cell.editBlock = ^(ZSingleData *singleData) {
        weakSelf.editView.singleData = singleData;
        [weakSelf.view addSubview:weakSelf.editView];
        [weakSelf.editView.editTextField becomeFirstResponder];
    };
    return cell;
}

#pragma mark tableView ------delegate-----
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ZMeasureListCell z_getCellHeight:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.01f;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectData = [ZHomeViewModel shareInstance].testPigs[indexPath.row];
    self.topView.singleData = self.selectData;
    [self.iTableView reloadData];
}

#pragma mark 侧滑删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// 定义编辑样式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

// 进入编辑模式，按下出现的编辑按钮后,进行删除操作
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[ZHomeViewModel shareInstance].testPigs removeObjectAtIndex:indexPath.row];
        [self.iTableView reloadData];
        [[ZHomeViewModel shareInstance] updateTestHistory];
    }
}

// 修改编辑按钮文字
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

#pragma mark 翻转屏幕修改布局
-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    if (!_topView || !_iTableView) {
        return;
    }
    if (self.isHorizontal) {
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.bottom.equalTo(self.view.mas_bottom);
            make.width.mas_equalTo(kWindowW/2.0f);
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom).offset(10);
            make.left.equalTo(self.topView.mas_right);
        }];
        
        [self.topView resetUIWith:[ZPublicManager getIsIpad]];
        
        if (_guideV) {
            UIWindow *presentView = [[AppDelegate App] window];
            _guideV.frame = presentView.bounds;
            [_guideV setHoleFrame:CGRectMake(([ZPublicManager getIsIpad] ? 24:12) + kWindowW/2.0f, kSafeAreaTopHeight+2, kWindowW/2.0f-([ZPublicManager getIsIpad] ? 24:12)*2, [ZMeasureListCell z_getCellHeight:nil])];
            [_guideV resetFrame];
        }
    }else{
        [self.topView resetUIWith:NO];
        [self.topView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.view);
            make.top.equalTo(self.navView.mas_bottom);
            make.height.mas_equalTo(CGFloatIn750(434));
        }];
        
        [self.iTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.top.equalTo(self.topView.mas_bottom).offset(0);
        }];
        
        if (_guideV) {
            UIWindow *presentView = [[AppDelegate App] window];
            _guideV.frame = presentView.bounds;
            [_guideV setHoleFrame:CGRectMake([ZPublicManager getIsIpad] ? 24:12 , kSafeAreaTopHeight + CGFloatIn750(434), kWindowW-([ZPublicManager getIsIpad] ? 24:12)*2, [ZMeasureListCell z_getCellHeight:nil])];
            [_guideV resetFrame];
        }
    }
}

#pragma mark test data
- (ZSingleData *)addTestData:(ZSingleData *)tempPigData {
    
    if ([tempPigData.firstNum integerValue] == 0 && [tempPigData.secondNum integerValue] == 0 && [tempPigData.thirdNum integerValue] == 0) {
        return nil;
    }
    
    self.selectData = tempPigData;
    if (!tempPigData.earTag || tempPigData.earTag.length == 0) {
        NSString *zeroStr = @"00000000";
        NSInteger tempCount = [ZHomeViewModel shareInstance].singPigDatas.count;
        tempPigData.earTag = [@"R" stringByAppendingString:[zeroStr substringWithRange:NSMakeRange(0, zeroStr.length - [[NSString stringWithFormat:@"%ld",tempCount] length])]];
        tempPigData.earTag = [tempPigData.earTag stringByAppendingString:[NSString stringWithFormat:@"%ld",tempCount]];
        tempPigData.earTag = [tempPigData.earTag stringByAppendingString:@"E"];
    }
    [[ZHomeViewModel shareInstance].testPigs insertObject:tempPigData atIndex:0];
    [self.iTableView reloadData];
    self.topView.singleData = self.selectData;
    
    [[ZHomeViewModel shareInstance] updateTestHistory];
    
    [self setGuideView];
    
    return tempPigData;
}


#pragma mark 保存数据---------------------------
- (void)saveTestPigsData {
    self.isBackSave = NO;
    if ([[ZHomeViewModel shareInstance] checkTestDataIsHadSameData]) {
        self.saveAlertView.alertLabel.text = @"数据列表中有相同耳标的测量数据，同一耳标只会取最新一条测量数据保存，确定保存吗？";
        self.saveAlertView.titleLabel.text = @"提示";
        [self.view addSubview:self.saveAlertView];
    }else{
//        self.saveAlertView.alertLabel.text = @"确定保存测量数据列表数据到数据库吗？";
//        self.saveAlertView.titleLabel.text = @"提示";
//        [self.view addSubview:self.saveAlertView];
        [[ZHomeViewModel shareInstance] updateTestDataToAllHistoryData];
        [self.iTableView reloadData];
        [self showSuccessWithMsg:@"已保存到数据库"];
    }
}

- (void)backSaveTestPigsData {
    self.isBackSave = YES;
    self.saveAlertView.titleLabel.text = @"测量数据还未保存";
    if ([[ZHomeViewModel shareInstance] checkTestDataIsHadSameData]) {
        self.saveAlertView.alertLabel.text = @"数据列表中有相同耳标的测量数据，同一耳标只会取一条数据保存，确定保存吗？";
        [self.view addSubview:self.saveAlertView];
    }else{
        self.saveAlertView.alertLabel.text = @"确定保存测量数据列表数据到数据库吗？";
        [self.view addSubview:self.saveAlertView];
    }
}
@end
