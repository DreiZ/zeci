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
@property (nonatomic,strong) ZHistoryAllList *historyList;
@property (nonatomic,strong) ZTestPigs *testList;
@property (nonatomic,strong) NSMutableArray <ZSingleData *>*testPigs;

+ (ZHomeViewModel *)shareInstance;

- (ZHistoryAllList *)getHistory;
- (void)updateHistory;
- (void)cleanAllHistory;

- (ZTestPigs *)getTestHistory;
- (void)updateTestHistory;
- (void)cleanTestHistory;

- (void)removeTheSameDataForTestData;
- (BOOL)checkTestDataIsHadSameData;
@end
