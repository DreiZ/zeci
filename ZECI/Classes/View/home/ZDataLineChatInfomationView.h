//
//  ZDataLineChatInfomationView.h
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseView.h"

@interface ZDataLineChatInfomationView : ZBaseView
@property (nonatomic,strong) UILabel *titleLabel;

@property (nonatomic,strong) void (^saveBlock)(void);

@end
