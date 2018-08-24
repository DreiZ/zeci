//
//  ZDataListCell.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZHomeModel.h"

@interface ZDataListCell : ZBaseCell
@property (nonatomic,strong) ZSingleData *singleData;
@property (nonatomic,strong) ZSingleData *singlePigData;

@property (nonatomic,strong) void (^selectBlock)(void);
@end
