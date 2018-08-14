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
        publicDataManager.testPigs = @[].mutableCopy;
    });
    return publicDataManager;
}


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
    [[ZPublicDataManager shareInstance] clearAllData];
    self.historyList = [ZHistoryAllList new];
}
@end
