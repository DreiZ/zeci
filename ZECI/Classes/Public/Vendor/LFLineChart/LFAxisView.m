//
//  LFAxisView.m
//  LFLineChart
//
//  Created by 王力丰 on 2018/2/7.
//  Copyright © 2018年 LiFeng Wang. All rights reserved.
//

#import "LFAxisView.h"
#import "LFChartLineView.h"

/**
 *  Y轴刻度标签 与 Y轴 之间 空隙
 */
#define HORIZON_YMARKLAB_YAXISLINE 10.f

/**
 *  Y轴刻度标签  宽度
 */
#define YMARKLAB_WIDTH ([ZPublicManager getIsIpad] ? 60:45.f)

/**
 *  Y轴刻度标签  高度
 */
#define YMARKLAB_HEIGHT ([ZPublicManager getIsIpad] ? 20:16)
/**
 *  X轴刻度标签  宽度
 */

#define XMARKLAB_WIDTH ([ZPublicManager getIsIpad] ? 70:55.f)

/**
 *  X轴刻度标签  高度
 */
#define XMARKLAB_HEIGHT ([ZPublicManager getIsIpad] ? 20:16)

/**
 *  最上边的Y轴刻度标签距离顶部的 距离
 */
#define YMARKLAB_TO_TOP ([ZPublicManager getIsIpad] ? 16:12)

@interface LFAxisView() {
    
    /**
     *  视图的宽度
     */
    CGFloat axisViewWidth;
    /**
     *  视图的高度
     */
    CGFloat axisViewHeight;
    
}

/**
 *  与x轴平行的网格线的间距(与坐标系视图的高度和y轴刻度标签的个数相关)
 */
@property (nonatomic, assign) CGFloat yScaleMarkLEN;

@end

@implementation LFAxisView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        axisViewHeight = frame.size.height;
        axisViewWidth = frame.size.width;
        
        CGFloat  start_X = HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH;
        CGFloat  start_Y = YMARKLAB_HEIGHT / 2.0 + YMARKLAB_TO_TOP;
        
        self.startPoint = CGPointMake(start_X, start_Y);
    }
    
    return self;
}

- (void)setMaxValue:(CGFloat)maxValue {
    _maxValue = maxValue;
}


- (void)setXScaleMarkLEN:(CGFloat)xScaleMarkLEN {
    _xScaleMarkLEN = xScaleMarkLEN;
}

- (void)setYMarkTitles:(NSArray *)yMarkTitles {
    _yMarkTitles = yMarkTitles;
}

- (void)setXMarkTitles:(NSArray *)xMarkTitles {
    _xMarkTitles = xMarkTitles;
}

#pragma mark 绘图
- (void)mapping {
    
    if(self.yMarkTitles.count == 1) {
        
        NSLog(@"y轴只有一条数据");
        
        return;
    }
    
    if(self.xMarkTitles.count == 1) {
        
        NSLog(@"x轴只有一条数据");
//        return;
    }

    self.yScaleMarkLEN = (self.frame.size.height - YMARKLAB_HEIGHT - XMARKLAB_HEIGHT - YMARKLAB_TO_TOP) / (self.yMarkTitles.count - 1);
    
    self.yAxis_L = self.yScaleMarkLEN * (self.yMarkTitles.count - 1);
    
    if (self.xScaleMarkLEN == 0) {
        self.xScaleMarkLEN = (axisViewWidth - HORIZON_YMARKLAB_YAXISLINE - YMARKLAB_WIDTH - XMARKLAB_WIDTH / 2.0) / (self.xMarkTitles.count - 1);
    }
    else {
        axisViewWidth = self.xScaleMarkLEN * (self.xMarkTitles.count - 1) + HORIZON_YMARKLAB_YAXISLINE + YMARKLAB_WIDTH + XMARKLAB_WIDTH / 2.0;
    }
    
    self.xAxis_L = self.xScaleMarkLEN * (self.xMarkTitles.count - 1);
    
    self.frame  = CGRectMake(0, 0, axisViewWidth, axisViewHeight);
    
    [self setupYMarkLabs];
    [self setupXMarkLabs];
    
    [self drawYAxsiLine];
    [self drawXAxsiLine];
    
    [self drawYGridline];
    
    [self drawXGridline];
    [self drawFirstXAxsiLine];
    [self drawSecondXAxsiLine];
}

#pragma mark 更新坐标轴数据
- (void)reloadDatas {
    [self clearView];
    [self mapping];
}

#pragma mark  Y轴上的刻度标签
- (void)setupYMarkLabs {
    
    for (int i = 0; i < self.yMarkTitles.count; i ++) {
        
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.startPoint.y - YMARKLAB_HEIGHT / 2 + i * self.yScaleMarkLEN, YMARKLAB_WIDTH, YMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentRight;
        markLab.font = [UIFont systemFontOfSize:([ZPublicManager getIsIpad] ? 16:12)];
        markLab.text = [NSString stringWithFormat:@"%@", self.yMarkTitles[self.yMarkTitles.count - 1 - i]];
//                隐去了y轴上的标签刻度
        [self addSubview:markLab];
    }
}

#pragma mark  X轴上的刻度标签
- (void)setupXMarkLabs {
    
    for (int i = 0;i < self.xMarkTitles.count; i ++) {
//        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x - XMARKLAB_WIDTH / 2 + i * self.xScaleMarkLEN, self.yAxis_L + self.startPoint.y + YMARKLAB_HEIGHT / 2, XMARKLAB_WIDTH, XMARKLAB_HEIGHT)];
        if (i == 0) {
            continue;
        }
        UILabel *markLab = [[UILabel alloc] initWithFrame:CGRectMake(self.startPoint.x - XMARKLAB_WIDTH / 2 + i * self.xScaleMarkLEN, 0, XMARKLAB_WIDTH, XMARKLAB_HEIGHT)];
        markLab.textAlignment = NSTextAlignmentCenter;
        markLab.font = [UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 13:11];
        markLab.text = self.xMarkTitles[i];
        markLab.textColor = kFont6Color;
        [self addSubview:markLab];
    }
    
}

#pragma mark  Y轴
- (void)drawYAxsiLine {
    UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
    [yAxisPath moveToPoint:CGPointMake(self.startPoint.x, self.startPoint.y + self.yAxis_L)];
    [yAxisPath addLineToPoint:CGPointMake(self.startPoint.x, self.startPoint.y)];
    
    CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
//    [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];    // 设置线为虚线
    yAxisLayer.lineWidth = 0.5;
    yAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    yAxisLayer.path = yAxisPath.CGPath;
    [self.layer addSublayer:yAxisLayer];
}

#pragma mark  X轴
- (void)drawXAxsiLine {
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    [xAxisPath addLineToPoint:CGPointMake(self.xAxis_L + self.startPoint.x, self.yAxis_L + self.startPoint.y)];
    
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
//    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.lineWidth = 0.5;
    xAxisLayer.strokeColor = [UIColor blackColor].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
}

- (void)drawFirstXAxsiLine {
    CGFloat percent = self.firstX / self.maxValue;
    CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
    
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, point_Y)];
    [xAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, point_Y)];
    
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.lineWidth = 0.5;
    xAxisLayer.strokeColor = [UIColor colorWithHexString:@"ffc761"].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
    
    
    UILabel *hintLable = [[UILabel alloc] initWithFrame:CGRectMake(110, point_Y-18, [ZPublicManager getIsIpad] ? 180:140, 15)];
    hintLable.textColor = kFont3Color;
    hintLable.text = [NSString stringWithFormat:@"第一层膘厚建议值：%.0f",self.firstX];
    hintLable.numberOfLines = 0;
    hintLable.textAlignment = NSTextAlignmentLeft;
    [hintLable setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 16:12]];
    [self addSubview:hintLable];
}

- (void)drawSecondXAxsiLine {
    CGFloat percent = self.secondX / self.maxValue;
    CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
    
    UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
    [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, point_Y)];
    [xAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, point_Y)];
    
    CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
    [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:5], [NSNumber numberWithInt:1.5], nil]];
    xAxisLayer.lineWidth = 0.5;
    xAxisLayer.strokeColor = [UIColor colorWithHexString:@"ffc761"].CGColor;
    xAxisLayer.path = xAxisPath.CGPath;
    [self.layer addSublayer:xAxisLayer];
    
    
    UILabel *hintLable = [[UILabel alloc] initWithFrame:CGRectMake(110, point_Y-18, [ZPublicManager getIsIpad] ? 180:140, 15)];
    hintLable.textColor = kFont3Color;
    hintLable.text = [NSString stringWithFormat:@"第二层膘厚建议值：%.0f",self.secondX];
    hintLable.numberOfLines = 0;
    hintLable.textAlignment = NSTextAlignmentLeft;
    [hintLable setFont:[UIFont systemFontOfSize:[ZPublicManager getIsIpad] ? 16:12]];
    [self addSubview:hintLable];
}

#pragma mark  与 Y轴 平行的网格线
- (void)drawYGridline {
    for (int i = 0; i < self.xMarkTitles.count - 1; i ++) {
        
        CGFloat curMark_X = self.startPoint.x + self.xScaleMarkLEN * (i + 1);
        
        UIBezierPath *yAxisPath = [[UIBezierPath alloc] init];
        [yAxisPath moveToPoint:CGPointMake(curMark_X, self.yAxis_L + self.startPoint.y)];
        [yAxisPath addLineToPoint:CGPointMake(curMark_X, self.startPoint.y)];
        
        CAShapeLayer *yAxisLayer = [CAShapeLayer layer];
        [yAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]]; // 设置线为虚线
        yAxisLayer.lineWidth = 0.5;
        yAxisLayer.strokeColor = [UIColor blackColor].CGColor;
        yAxisLayer.path = yAxisPath.CGPath;
//        [self.layer addSublayer:yAxisLayer];
    }
}

#pragma mark  与 X轴 平行的网格线
- (void)drawXGridline {
    for (int i = 0; i < self.yMarkTitles.count - 1; i ++) {
        
        CGFloat curMark_Y = self.yScaleMarkLEN * i;
        
        UIBezierPath *xAxisPath = [[UIBezierPath alloc] init];
        [xAxisPath moveToPoint:CGPointMake(self.startPoint.x, curMark_Y + self.startPoint.y)];
        [xAxisPath addLineToPoint:CGPointMake(self.startPoint.x + self.xAxis_L, curMark_Y + self.startPoint.y)];
        
        CAShapeLayer *xAxisLayer = [CAShapeLayer layer];
//        [xAxisLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:1], [NSNumber numberWithInt:1.5], nil]];
        xAxisLayer.lineWidth = 0.5;
        xAxisLayer.strokeColor = kFont6Color.CGColor;
        xAxisLayer.path = xAxisPath.CGPath;
        [self.layer addSublayer:xAxisLayer];
    }
}

#pragma mark- 清空视图
- (void)clearView {
    
    [self removeAllSubLabs];
    [self removeAllSubLayers];
}

#pragma mark 清空标签
- (void)removeAllSubLabs {
    
    NSArray *subviews = [NSArray arrayWithArray:self.subviews];
    
    for (UIView *view in subviews) {
        [view removeFromSuperview];
    }
}

#pragma mark 清空网格线
- (void)removeAllSubLayers{
    
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeAllAnimations];
        [layer removeFromSuperlayer];
    }
}

@end
