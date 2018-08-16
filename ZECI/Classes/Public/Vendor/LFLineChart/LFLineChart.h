//
//  LFLineChart.h
//  LFLineChart
//
//  Created by 王力丰 on 2018/2/7.
//  Copyright © 2018年 LiFeng Wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LFLineChart : UIView
@property (nonatomic,strong) void (^tapBlock)(void);

/**
 *  显示折线图的可滑动视图
 */
@property (nonatomic, strong) UIScrollView *scrollView;
/**
 *  表名
 */
@property (nonatomic, strong) NSString *title;

/**
 *  Y轴刻度标签title
 */
@property (nonatomic, strong) NSArray *yMarkTitles;

/**
 *  Y轴最大值
 */
@property (nonatomic, assign) CGFloat maxValue;
/**
 *  Y轴最小值
 */
@property (nonatomic, assign) CGFloat minValue;

/**
 *  X轴刻度标签的长度（单位长度）
 */
@property (nonatomic, assign) CGFloat xScaleMarkLEN;

//第一层膘建议值
@property (nonatomic, assign) CGFloat firstX;
//第二层膘建议值
@property (nonatomic, assign) CGFloat secondX;
/**
 *  设置折线图显示的数据和对应X坐标轴刻度标签
 *
 *  @param xMarkTitlesAndValues 折线图显示的数据和X坐标轴刻度标签
 *  @param titleKey             标签（如:9月1日）
 *  @param valueKey             数据 (如:80)
 */
- (void)setXMarkTitlesAndValues:(NSArray *)xMarkTitlesAndValues titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey value1Key:(NSString *)valueKey value2Key:(NSString *)valueKey;

- (void)mapping;

- (void)reloadDatas;

@end
