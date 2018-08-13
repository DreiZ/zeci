//
//  ZDataListSearchView.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZDataListSearchView : ZBaseView
@property (strong, nonatomic) void (^valueChange)(NSString *value);
@property (strong, nonatomic) void (^searchBlock)(NSString *value);

@end
