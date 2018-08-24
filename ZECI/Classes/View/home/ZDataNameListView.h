//
//  ZDataNameListView.h
//  ZECI
//
//  Created by zzz on 2018/8/24.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZDataNameListView : ZBaseView

@property (nonatomic,strong) void (^selectBlock)(NSString *);

- (void)startSearch:(NSString *)string;
@end
