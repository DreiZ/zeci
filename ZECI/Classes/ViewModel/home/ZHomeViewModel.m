//
//  ZHomeViewModel.m
//  ZECI
//
//  Created by zzz on 2018/8/14.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeViewModel.h"

@implementation ZHomeViewModel

+ (ZHomeViewModel *)shareInstance {
    static ZHomeViewModel *publicDataManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        publicDataManager = [[ZHomeViewModel alloc] init];
        [publicDataManager getTestHistory];
        
        if (publicDataManager.testList && publicDataManager.testList.singList) {
            publicDataManager.testPigs = [[NSMutableArray alloc] initWithArray:publicDataManager.testList.singList];
        }else{
            publicDataManager.testPigs = @[].mutableCopy;
        }
    });
    return publicDataManager;
}

#pragma mark 测量数据
- (ZHistoryAllList *)getHistory {
    self.historyList = [[ZPublicDataManager shareInstance] getDBModelData:[ZHistoryAllList class]];
    if (!self.historyList) {
        self.historyList = [ZHistoryAllList new];
    }
    return self.historyList;
}

- (void)updateHistory {
    [[ZPublicDataManager shareInstance] addOrUpdateModel:self.historyList];
}

- (void)cleanAllHistory {
    [[ZPublicDataManager shareInstance] clearModel:[ZHistoryAllList class]];
    self.historyList = [ZHistoryAllList new];
}

#pragma mark 测量数据
- (ZTestPigs *)getTestHistory {
    self.testList = [[ZPublicDataManager shareInstance] getDBModelData:[ZTestPigs class]];
    if (!self.testList) {
        self.testList = [ZTestPigs new];
    }
    return self.testList;
}

- (void)updateTestHistory {
    [ZHomeViewModel shareInstance].testList.singList = [ZHomeViewModel shareInstance].testPigs;
    [[ZPublicDataManager shareInstance] addOrUpdateModel:self.testList];
}

- (void)cleanTestHistory {
    [[ZPublicDataManager shareInstance] clearModel:[ZTestPigs class]];
    self.testList = [ZTestPigs new];
}

#pragma mark 测试数据处理
- (BOOL)checkTestDataIsHadSameData {
    BOOL hadSame = NO;
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (ZSingleData *singleData in self.testPigs) {
        if (![listAry containsObject:singleData]) {
            [listAry addObject:singleData];
        }else{
            hadSame = YES;
        }
    }
    return hadSame;
}

- (void)removeTheSameDataForTestData {
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (ZSingleData *singleData in self.testPigs) {
        if (![listAry containsObject:singleData]) {
            [listAry addObject:singleData];
        }
    }
    NSLog(@"%@",listAry);
}
@end
