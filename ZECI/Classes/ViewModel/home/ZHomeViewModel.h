//
//  ZHomeViewModel.h
//  ZECI
//
//  Created by zzz on 2018/8/14.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"
#import "ZHomeModel.h"

@interface ZHomeViewModel : ZBaseModel
//数据库中所有数据
@property (nonatomic,strong) ZHistoryAllList *historyList;
//数据库中没有保存的测量数据
@property (nonatomic,strong) ZTestPigs *testList;


//编辑的 数据库中所有数据
@property (nonatomic,strong) NSMutableArray <ZSinglePig *>*singPigDatas;
//编辑的 数据库中没有保存的测量数据
@property (nonatomic,strong) NSMutableArray <ZSingleData *>*testPigs;


+ (ZHomeViewModel *)shareInstance;

- (ZHistoryAllList *)getHistory;
- (void)updateHistory;
- (void)cleanAllHistory;

- (ZTestPigs *)getTestHistory;
- (void)updateTestHistory;
- (void)cleanTestHistory;

//去除测量数据中相同耳标数据
- (NSMutableArray *)removeTheSameDataForTestData;

//测量数据中是否有相同耳标
- (BOOL)checkTestDataIsHadSameData;

//更新测量数据到数据库
- (void)updateTestDataToAllHistoryData;
@end
