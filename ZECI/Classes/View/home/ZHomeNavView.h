//
//  ZHomeNavView.h
//  ZECI
//
//  Created by zzz on 2018/8/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZHomeNavView : ZBaseView
@property (nonatomic,assign) BOOL bluetoothState;
@property (nonatomic, strong) void (^topSelectBlock)(NSInteger);
@end
