//
//  ZMeasureEditView.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"
#import "ZHomeModel.h"

@interface ZMeasureEditView : ZBaseView
@property (nonatomic,strong) ZSingleData *singleData;

@property (nonatomic,strong) void (^sureBlock)(NSString *);
@end
