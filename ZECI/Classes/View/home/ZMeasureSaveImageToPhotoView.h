//
//  ZMeasureSaveImageToPhotoView.h
//  ZECI
//
//  Created by zzz on 2018/8/21.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZMeasureSaveImageToPhotoView : ZBaseView
@property (nonatomic,strong) void (^saveBlock)(void);
@end
