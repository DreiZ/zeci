//
//  ZDataLineChatVC.m
//  ZECI
//
//  Created by zzz on 2018/8/13.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZDataLineChatVC.h"
#import "ZDataLineChatInfomationView.h"
#import "LFLineChart.h"

@interface ZDataLineChatVC ()
@property (nonatomic,strong) ZDataLineChatInfomationView *infomationView;
@property (nonatomic, strong) LFLineChart *lineChart;
@end

@implementation ZDataLineChatVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgation];
    [self setMainView];
    [self setLineChat];
}

- (void)setNavgation {
    self.customNavBar.hidden = NO;
    self.customNavBar.title = @"背膘详情";
    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"fenxiang"]];
}

- (void)setMainView {
    [self.view addSubview:self.infomationView];
    [self.infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self.view);
        make.height.mas_equalTo(130.0f);
    }];
}


#pragma mark lazy loading
-(ZDataLineChatInfomationView *)infomationView {
    if (!_infomationView) {
        _infomationView = [[ZDataLineChatInfomationView alloc] init];
    }
    
    return _infomationView;
}

- (void)setLineChat {
    self.lineChart = [[LFLineChart alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - 160 - kSafeAreaTopHeight)];
    self.lineChart.backgroundColor = [UIColor whiteColor];
    NSMutableArray *orderedArray = [[NSMutableArray alloc]init];
//    NSArray *temp = @[@"23",@"33",@"27",@"37",@"48",@"23",@"58"];
//    NSArray *temp1 = @[@"30",@"46",@"32",@"44",@"52",@"31",@"62"];
//    NSArray *temp2 = @[@"48",@"55",@"45",@"52",@"61",@"43",@"78"];
    NSArray *temp = @[@"",@"23",@"33",@"",@"23",@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *temp1 = @[@"",@"30",@"46",@"",@"45",@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *temp2 = @[@"",@"48",@"55",@"",@"55",@"",@"",@"",@"",@"",@"",@"",@""];
    NSArray *tempy = @[@"3月3日",@"3月4日",@"3月5日",@"3月6日",@"3月7日",@"3月8日",@"3月9日",@"3月10日",@"3月11日",@"3月12日",@"3月13日",@"3月14日",@"3月15日",@"3月16日",@"3月17日"];
    float max = 0;
    float min = 0;
    for(int i = 0; i < temp.count; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSString *xValue;
        NSString *yValue;
        NSString *y1Value;
        NSString *y2Value;
        
//        NSString *formatter = @"MM月dd日";
        
        xValue = tempy[i];
        yValue = temp[i];
        y1Value = temp1[i];
        y2Value = temp2[i];
        
        if ([yValue floatValue]>max) {
            max = [yValue floatValue];
        }
        if ([y1Value floatValue]>max) {
            max = [y1Value floatValue];
        }
        if ([y2Value floatValue]>max) {
            max = [y2Value floatValue];
        }
        
        
        if ([yValue floatValue]<min) {
            min = [yValue floatValue];
        }else if (i == 0){
            min = [yValue floatValue];
        }
        dict = [@{
                  @"item" : xValue, @"count":yValue,@"count1":y1Value,@"count2":y2Value
                  } mutableCopy];
        [orderedArray addObject:dict];
    }
    
    self.lineChart.maxValue = max + (max - min)*0.08;
    self.lineChart.minValue = min - (max - min)*0.08;
    if (max == 0) {
        self.lineChart.maxValue = 5;
    }
    if (min <= 0) {
        self.lineChart.minValue = 0;
    }
    self.lineChart.minValue = 0;
    
    self.lineChart.firstX = 12;
    self.lineChart.secondX = 24;
    
    self.lineChart.xScaleMarkLEN = 45;
    self.lineChart.yMarkTitles = @[[NSString stringWithFormat:@"%.0f",self.lineChart.minValue],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.minValue + (self.lineChart.maxValue - self.lineChart.minValue)/6],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*2/6],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*3/6],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*4/6],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*5/6],
                                   [NSString stringWithFormat:@"%.0f",self.lineChart.maxValue]]; // Y轴刻度标签
    
    [self.lineChart setXMarkTitlesAndValues:orderedArray titleKey:@"item" valueKey:@"count" value1Key:@"count1" value2Key:@"count2"]; // X轴刻度标签及相应的值
    
    //设置完数据等属性后绘图折线图
    [self.lineChart mapping];
    
    [self.view addSubview:self.lineChart];
}
@end
