//
//  LFChartLineView.m
//  LFLineChart
//
//  Created by 王力丰 on 2018/2/7.
//  Copyright © 2018年 LiFeng Wang. All rights reserved.
//

#import "LFChartLineView.h"
#import "LFCircleView.h"

@interface LFChartLineView() {
    NSMutableArray *pointArray;
    NSMutableArray *point1Array;
    NSMutableArray *point2Array;
    NSArray <UIColor *>*colors;
}

@end

@implementation LFChartLineView



- (void)setValueArray:(NSArray *)valueArray {
    _valueArray = valueArray;
}

- (void)setValue1Array:(NSArray *)value1Array {
    _value1Array = value1Array;
}

- (void)setValue2Array:(NSArray *)value2Array {
    _value2Array = value2Array;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.yAxis_L = frame.size.height;
        self.xAxis_L = frame.size.width;
        
    }
    return  self;
}

- (void)mapping {
    
    [super mapping];
    colors = @[[UIColor colorWithHexString:@"fe5151"],
               [UIColor colorWithHexString:@"00cc42"],
               [UIColor colorWithHexString:@"0091ff"]];
    [self drawChartLine];
    [self drawChartLine1];
    [self drawChartLine2];
    [self drawGradient];
    
    [self setupCircleViews];
    [self setupCircleViews1];
    [self setupCircleViews2];
}

- (void)reloadDatas {
    
    [self clearView];
    
    [self mapping];
}

#pragma mark 画折线图
- (void)drawChartLine {
    
    if (pointArray) {
        [pointArray removeAllObjects];
    }
    else {
        pointArray = [NSMutableArray arrayWithCapacity:0];
    }
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
    NSInteger tempIndex = -1;
    for (int i = 0; i < self.valueArray.count; i ++) {
        if ([self.valueArray[i] floatValue]!=-1) {
            if ([self.valueArray[i] length] == 0) {
                continue;
            }
            if (tempIndex == -1) {
                tempIndex = 0;
            }else{
                tempIndex = i;
            }
            
            CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
            //         CGFloat point_X = self.xScaleMarkLEN * i;
            CGFloat value = [self.valueArray[i] floatValue];
            CGFloat percent = value / self.maxValue;
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [pointArray addObject:[NSValue valueWithCGPoint:point]];
            
            if (tempIndex == 0) {
                [pAxisPath moveToPoint:point];
            }
            else {
                [pAxisPath addLineToPoint:point];
            }
            CGSize size=[[NSString stringWithFormat:@"%.2f",value] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9.f]}];
            
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 10)];
            textLabel.font = [UIFont systemFontOfSize:9.f];
            textLabel.text = [NSString stringWithFormat:@"%.2f",value];
            textLabel.center = CGPointMake(point_X, point_Y - 12);
            [self addSubview:textLabel];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 1;
    pAxisLayer.strokeColor = colors[0].CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
}

- (void)drawChartLine1 {
    
    if (point1Array) {
        [point1Array removeAllObjects];
    }
    else {
        point1Array = [NSMutableArray arrayWithCapacity:0];
    }
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
    NSInteger tempIndex = -1;
    for (int i = 0; i < self.value1Array.count; i ++) {
        if ([self.value1Array[i] floatValue]!=-1) {
            if ([self.valueArray[i] length] == 0) {
                continue;
            }
            if (tempIndex == -1) {
                tempIndex = 0;
            }else{
                tempIndex = i;
            }
            CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
            //         CGFloat point_X = self.xScaleMarkLEN * i;
            CGFloat value = [self.value1Array[i] floatValue];
            CGFloat percent = value / self.maxValue;
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [point1Array addObject:[NSValue valueWithCGPoint:point]];
            
            if (tempIndex == 0) {
                [pAxisPath moveToPoint:point];
            }
            else {
                [pAxisPath addLineToPoint:point];
            }
            CGSize size=[[NSString stringWithFormat:@"%.2f",value] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9.f]}];
            
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 10)];
            textLabel.font = [UIFont systemFontOfSize:9.f];
            textLabel.text = [NSString stringWithFormat:@"%.2f",value];
            textLabel.center = CGPointMake(point_X, point_Y - 12);
            [self addSubview:textLabel];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 1;
    pAxisLayer.strokeColor = colors[1].CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
}


- (void)drawChartLine2 {
    
    if (point2Array) {
        [point2Array removeAllObjects];
    }
    else {
        point2Array = [NSMutableArray arrayWithCapacity:0];
    }
    
    UIBezierPath *pAxisPath = [[UIBezierPath alloc] init];
    NSInteger tempIndex = -1;
    for (int i = 0; i < self.value2Array.count; i ++) {
        if ([self.value2Array[i] floatValue]!=-1) {
            if ([self.valueArray[i] length] == 0) {
                continue;
            }
            if (tempIndex == -1) {
                tempIndex = 0;
            }else{
                tempIndex = i;
            }
            CGFloat point_X = self.xScaleMarkLEN * i + self.startPoint.x;
            //         CGFloat point_X = self.xScaleMarkLEN * i;
            CGFloat value = [self.value2Array[i] floatValue];
            CGFloat percent = value / self.maxValue;
            CGFloat point_Y = self.yAxis_L * (1 - percent) + self.startPoint.y;
            
            CGPoint point = CGPointMake(point_X, point_Y);
            
            // 记录各点的坐标方便后边添加渐变阴影 和 点击层视图 等
            [point2Array addObject:[NSValue valueWithCGPoint:point]];
            
            if (tempIndex == 0) {
                [pAxisPath moveToPoint:point];
            }
            else {
                [pAxisPath addLineToPoint:point];
            }
            CGSize size=[[NSString stringWithFormat:@"%.2f",value] sizeWithAttributes:@{NSFontAttributeName: [UIFont systemFontOfSize:9.f]}];
            
            UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, size.width, 10)];
            textLabel.font = [UIFont systemFontOfSize:9.f];
            textLabel.text = [NSString stringWithFormat:@"%.2f",value];
            textLabel.center = CGPointMake(point_X, point_Y - 12);
            [self addSubview:textLabel];
        }
    }
    
    CAShapeLayer *pAxisLayer = [CAShapeLayer layer];
    pAxisLayer.lineWidth = 1;
    pAxisLayer.strokeColor = colors[2].CGColor;
    pAxisLayer.fillColor = [UIColor clearColor].CGColor;
    pAxisLayer.path = pAxisPath.CGPath;
    [self.layer addSublayer:pAxisLayer];
}


#pragma mark 渐变阴影
- (void)drawGradient {
//    
//    CAGradientLayer *gradientLayer = [CAGradientLayer layer];
//    gradientLayer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
//    gradientLayer.colors = @[(__bridge id)[UIColor colorWithRed:54/255.0 green:221/255.0 blue:235/255.0 alpha:0.8].CGColor,(__bridge id)[UIColor colorWithWhite:1 alpha:0.1].CGColor];
//    
//    gradientLayer.locations=@[@0.0,@1.0];
//    gradientLayer.startPoint = CGPointMake(0.0,0.0);
//    gradientLayer.endPoint = CGPointMake(0.0,1);
//    
//    UIBezierPath *gradientPath = [[UIBezierPath alloc] init];
//    [gradientPath moveToPoint:CGPointMake(self.startPoint.x, self.yAxis_L + self.startPoint.y)];
//    
//    for (int i = 0; i < pointArray.count; i ++) {
//        [gradientPath addLineToPoint:[pointArray[i] CGPointValue]];
//    }
//    
//    CGPoint endPoint = [[pointArray lastObject] CGPointValue];
//    endPoint = CGPointMake(endPoint.x, self.yAxis_L + self.startPoint.y);
//    [gradientPath addLineToPoint:endPoint];
//    CAShapeLayer *arc = [CAShapeLayer layer];
//    arc.path = gradientPath.CGPath;
//    gradientLayer.mask = arc;
//    [self.layer addSublayer:gradientLayer];
    
}

#pragma mark 折线上的圆环
- (void)setupCircleViews {
    
    for (int i = 0; i < pointArray.count; i ++) {
        
        LFCircleView *circleView = [[LFCircleView alloc] initWithCenter:[pointArray[i] CGPointValue] radius:4];
        circleView.borderColor = colors[0];
        circleView.borderWidth = 5.0;
        [self addSubview:circleView];
    }
}

- (void)setupCircleViews1 {
    
    for (int i = 0; i < point1Array.count; i ++) {
        
        LFCircleView *circleView = [[LFCircleView alloc] initWithCenter:[point1Array[i] CGPointValue] radius:4];
        circleView.borderColor = colors[1];
        circleView.borderWidth = 5.0;
        [self addSubview:circleView];
    }
}

- (void)setupCircleViews2 {
    
    for (int i = 0; i < point2Array.count; i ++) {
        
        LFCircleView *circleView = [[LFCircleView alloc] initWithCenter:[point2Array[i] CGPointValue] radius:4];
        circleView.borderColor = colors[2];
        circleView.borderWidth = 5.0;
        [self addSubview:circleView];
    }
}

#pragma mark- 清空视图
- (void)clearView {
    [self removeSubviews];
    [self removeSublayers];
}

#pragma mark 移除 点击图层 、圆环 、数值标签
- (void)removeSubviews {
    
    NSArray *subViews = [NSArray arrayWithArray:self.subviews];
    
    for (UIView *view in subViews) {
        [view removeFromSuperview];
    }
    
}

#pragma mark 移除折线
- (void)removeSublayers {
    NSArray * subLayers = [NSArray arrayWithArray:self.layer.sublayers];
    for (CALayer * layer in subLayers) {
        [layer removeFromSuperlayer];
    }
}

@end
