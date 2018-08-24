//
//  ZSingDataListVC.h
//  ZECI
//
//  Created by zzz on 2018/8/24.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCustomViewController.h"

@interface ZSingDataListVC : ZBaseCustomViewController
@property (nonatomic,assign) NSInteger index;

@property (nonatomic,strong) void (^refreshBlock)(void);
@end
