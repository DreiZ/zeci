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
@property (nonatomic,strong) NSMutableArray <ZSingleData *>*testPigs;

+ (ZHomeViewModel *)shareInstance;

- (ZHistoryAllList *)getHistory;
- (void)updateHistory;
- (void)cleanAllHistory;


- (void)removeTheSameDataForTestData;
- (BOOL)checkTestDataIsHadSameData;
@end
