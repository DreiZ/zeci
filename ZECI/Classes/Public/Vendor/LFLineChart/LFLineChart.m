//
//  LFLineChart.m
//  LFLineChart
//
//  Created by 王力丰 on 2018/2/7.
//  Copyright © 2018年 LiFeng Wang. All rights reserved.
//

#import "LFLineChart.h"

#import "LFChartLineView.h"
#import "LFAxisView.h"

@interface LFLineChart() {
    
    NSMutableArray *xMarkTitles;
    NSMutableArray *valueArray;
    NSMutableArray *value1Array;
    NSMutableArray *value2Array;
}

/**
 *  表名标签
 */
@property (nonatomic, strong) UILabel *titleLab;



/**
 *  折线图
 */
@property (nonatomic, strong) LFChartLineView *chartLineView;

/**
 *  X轴刻度标签 和 对应的折线图点的值
 */
@property (nonatomic, strong) NSArray *xMarkTitlesAndValues;

@end

@implementation LFLineChart

- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {
    _xScaleMarkLEN = xScaleMarkLEN;
}

- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
    
}

- (void)setTitle:(NSString *)title {
    _title = title;
    
}

- (void)setXMarkTitlesAndValues:(NSArray *)xMarkTitlesAndValues titleKey:(NSString *)titleKey valueKey:(NSString *)valueKey value1Key:(NSString *)value1Key value2Key:(NSString *)value2Key{
    
    _xMarkTitlesAndValues = xMarkTitlesAndValues;
    
    if (xMarkTitles) {
        [xMarkTitles removeAllObjects];
    }
    else {
        xMarkTitles = [NSMutableArray arrayWithCapacity:0];
        
    }
    
    if (valueArray) {
        [valueArray removeAllObjects];
    }
    else {
        valueArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    if (value1Array) {
        [value1Array removeAllObjects];
    }
    else {
        value1Array = [NSMutableArray arrayWithCapacity:0];
    }
    
    if (value2Array) {
        [value2Array removeAllObjects];
    }
    else {
        value2Array = [NSMutableArray arrayWithCapacity:0];
    }
    
    for (NSDictionary *dic in xMarkTitlesAndValues) {
        
        [xMarkTitles addObject:[dic objectForKey:titleKey]];
        [valueArray addObject:[dic objectForKey:valueKey]];
        [value1Array addObject:[dic objectForKey:value1Key]];
        [value2Array addObject:[dic objectForKey:value2Key]];
    }
}

#pragma mark 绘图
- (void)mapping {
    static CGFloat topToContainView = 0.f;
    
    if (self.title) {
        
        self.titleLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, CGRectGetWidth(self.frame), 20)];
        self.titleLab.text = self.title;
        self.titleLab.font = [UIFont systemFontOfSize:15];
        self.titleLab.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.titleLab];
        topToContainView = 25;
    }
    
    if (!self.xMarkTitlesAndValues) {
        
        xMarkTitles = @[@1,@2,@3,@4,@5].mutableCopy;
        valueArray = @[@2,@2,@2,@2,@2].mutableCopy;
        value1Array = @[@3,@3,@3,@3,@3].mutableCopy;
        value1Array = @[@4,@4,@4,@4,@4].mutableCopy;
        NSLog(@"折线图需要一个显示X轴刻度标签的数组xMarkTitles");
        NSLog(@"折线图需要一个转折点值的数组valueArray");
    }
    
    
    if (!self.yMarkTitles) {
        self.yMarkTitles = @[@0,@1,@2,@3,@4,@5];
        NSLog(@"折线图需要一个显示Y轴刻度标签的数组yMarkTitles");
    }
    
    
    if (self.maxValue == 0) {
        self.maxValue = 5;
        NSLog(@"折线图需要一个最大值maxValue");
        
    }
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, topToContainView, self.frame.size.width,self.frame.size.height - topToContainView)];
    [self.scrollView setShowsHorizontalScrollIndicator:NO];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.scrollView];
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.mas_right);
        make.top.equalTo(self.mas_top).offset(topToContainView);
        make.bottom.equalTo(self.mas_bottom);
    }];
    
    
    self.chartLineView = [[LFChartLineView alloc] initWithFrame:self.scrollView.bounds];
    
    self.chartLineView.yMarkTitles = self.yMarkTitles;
    self.chartLineView.xMarkTitles = xMarkTitles;
    self.chartLineView.xScaleMarkLEN = self.xScaleMarkLEN;
    self.chartLineView.valueArray = valueArray;
    self.chartLineView.value1Array = value1Array;
    self.chartLineView.value2Array = value2Array;
    self.chartLineView.maxValue = self.maxValue;
    self.chartLineView.firstX = self.firstX;
    self.chartLineView.secondX = self.secondX;
    
    [self.scrollView addSubview:self.chartLineView];
//    [self.chartLineView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.scrollView);
//    }];
    __block NSUInteger i = 0;
    [valueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"-1"]) {
            i = idx;
            *stop = YES;
        }
    }];
    if (i >6) {
        self.scrollView.contentOffset = CGPointMake(self.xScaleMarkLEN *(i - 6) ,0);
    }
    
    
    [self.chartLineView mapping];
    
    self.scrollView.contentSize = self.chartLineView.bounds.size;
    self.scrollView.contentSize = CGSizeMake(self.chartLineView.bounds.size.width, 1);
    
    UITapGestureRecognizer *sigleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTapGesture:)];
    sigleTapRecognizer.numberOfTapsRequired = 1;
    [self.scrollView addGestureRecognizer:sigleTapRecognizer];
}

-(void)handleTapGesture:( UITapGestureRecognizer *)tapRecognizer {
    NSInteger tapCount = tapRecognizer.numberOfTapsRequired;
    // 先取消任何操作
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    switch (tapCount){
        case 1:
            if (_tapBlock) {
                _tapBlock();
            }
            break;
            //        case 2:
            //           [self handleDoubleTap:tapRecognizer];
            break;
    }
}

#pragma mark 更新数据
- (void)reloadDatas {
    static CGFloat topToContainView = 0.f;
    if (self.title) {
        topToContainView = 25;
    }
  
    self.scrollView.frame = CGRectMake(0, topToContainView, self.frame.size.width,self.frame.size.height - topToContainView);
    
    self.chartLineView.frame = self.scrollView.bounds;
    
    __block NSUInteger i = 0;
    [valueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isEqualToString:@"-1"]) {
            i = idx;
            *stop = YES;
        }
    }];
    if (i >6) {
        self.scrollView.contentOffset = CGPointMake(self.xScaleMarkLEN *(i - 6) ,0);
    }
    
    [self.chartLineView reloadDatas];
    self.scrollView.contentSize = CGSizeMake(self.chartLineView.bounds.size.width, 1);
}

- (void)dealloc {
    NSMutableArray *newges = [NSMutableArray arrayWithArray:self.scrollView.gestureRecognizers];
    for (int i =0; i < [newges count]; i++) {
        [self.scrollView removeGestureRecognizer:[newges objectAtIndex:i]];
    }
}
@end
