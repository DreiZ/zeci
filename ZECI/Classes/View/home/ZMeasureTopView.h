//
//  ZMeasureTopView.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"
#import "ZHomeModel.h"

@interface ZMeasureTopView : ZBaseView
@property (nonatomic,strong) UILabel *firstLabel;
@property (nonatomic,strong) UILabel *secondLabel;
@property (nonatomic,strong) UILabel *thridLabel;

@property (nonatomic,strong) ZSingleData *singleData;


- (void)resetUIWith:(BOOL)isPad;
@end
