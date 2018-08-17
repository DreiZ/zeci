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
        //所有测试数据 数据库
        [publicDataManager getHistory];
        if (publicDataManager.historyList && publicDataManager.historyList.allHisoryLists) {
            publicDataManager.singPigDatas = [[NSMutableArray alloc] initWithArray:publicDataManager.historyList.allHisoryLists];
        }else{
            publicDataManager.singPigDatas = @[].mutableCopy;
        }
        
        
        //测量未保存数据
        [publicDataManager getTestHistory];
        
        if (publicDataManager.testList && publicDataManager.testList.singleList) {
            publicDataManager.testPigs = [[NSMutableArray alloc] initWithArray:publicDataManager.testList.singleList];
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
    [ZHomeViewModel shareInstance].historyList.allHisoryLists = [ZHomeViewModel shareInstance].singPigDatas;
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
    [ZHomeViewModel shareInstance].testList.singleList = [ZHomeViewModel shareInstance].testPigs;
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
        for (ZSingleData *saveSingleData in listAry) {
            if ([saveSingleData.earTag isEqualToString:singleData.earTag]) {
                hadSame = YES;
                return YES;
            }
        }
        if (!hadSame) {
            [listAry addObject:singleData];
        }
    }
    return hadSame;
}


- (NSMutableArray *)removeTheSameDataForTestData {
    NSMutableArray *listAry = [[NSMutableArray alloc]init];
    for (ZSingleData *singleData in self.testPigs) {
        BOOL isHad = NO;
        for (ZSingleData *aSingleData in listAry) {
            if ([aSingleData.earTag isEqualToString:singleData.earTag]) {
                isHad = YES;
            }
        }
        if (!isHad) {
            [listAry addObject:singleData];
        }
    }
    NSLog(@"%@",listAry);
    return listAry;
}


- (void)updateTestDataToAllHistoryData {
    NSMutableArray *listAry = [self removeTheSameDataForTestData];
    for (ZSingleData *singleData in listAry) {
        BOOL isHad = NO;
        for (ZSinglePig *aSingleData in self.singPigDatas) {
            if ([aSingleData.earTag isEqualToString:singleData.earTag]) {
                NSMutableArray *singPigList;
                
                
                if (aSingleData.singleList) {
                    singPigList = [[NSMutableArray alloc] initWithArray:aSingleData.singleList];
                }else {
                    singPigList = @[].mutableCopy;
                }
                
                [self insertData:singleData singleList:singPigList];
                aSingleData.singleList = singPigList;
                isHad = YES;
                
                break;
            }
        }
        
        
        if (!isHad) {
            ZSinglePig *aSingleData = [[ZSinglePig alloc] init];
            NSMutableArray *singPigList = [[NSMutableArray alloc] initWithArray:aSingleData.singleList];
            
            [singPigList addObject:singleData];
            aSingleData.singleList = singPigList;
            aSingleData.earTag = singleData.earTag;
            [self.singPigDatas addObject:aSingleData];
        }
    }
    
    
    [self updateHistory];
    [self.testPigs removeAllObjects];
    [self updateTestHistory];
}

//相同日期数据替换
- (void)insertData:(ZSingleData *)singleData singleList:(NSMutableArray *)singleList {
    BOOL isHad = NO;
    NSInteger index = 0;
    for (ZSingleData *lSingData in singleList) {
        if ([[ZPublicManager timeWithStr:lSingData.testTime format:@"YYYYMMdd"]  isEqualToString:[ZPublicManager timeWithStr:singleData.testTime format:@"YYYYMMdd"] ]) {
            isHad = YES;
            [singleList replaceObjectAtIndex:index withObject:singleData];
            break;
        }
        index++;
    }
    if (!isHad) {
        [singleList addObject:singleData];
    }
}
@end
