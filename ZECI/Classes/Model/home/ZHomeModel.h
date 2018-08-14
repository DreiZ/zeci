//
//  ZHomeModel.h
//  ZECI
//
//  Created by zzz on 2018/8/14.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"

@interface ZSingeData : ZBaseModel
//单次数据
@property(nonatomic, strong) NSString *earTag;
@property(nonatomic, strong) NSString *testTime;
@property(nonatomic, strong) NSString *firstNum;
@property(nonatomic, strong) NSString *secondNum;
@property(nonatomic, strong) NSString *thirdNum;
@end

@interface ZSingePig : ZBaseModel
//单头猪数据
@property(nonatomic, strong) NSString *earTag;
@property(nonatomic, strong) NSArray <ZSingeData *> *singList;
@end

@interface ZHistoryAllList : ZBaseModel
@property(nonatomic, strong) NSArray <ZSingePig *> *allHisoryLists;
@end

@interface ZHomeModel : ZBaseModel

@end