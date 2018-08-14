//
//  ZMeasureListCell.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCell.h"
#import "ZHomeModel.h"
@interface ZMeasureListCell : ZBaseCell
@property (nonatomic,strong) ZSingeData *singeData;

@property (nonatomic,strong) void (^editBlock)(NSInteger);
@end
