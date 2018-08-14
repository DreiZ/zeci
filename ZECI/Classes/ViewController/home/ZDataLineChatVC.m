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
#import "ZShareView.h"

#import <UMShare/UMShare.h>
//微信好友和朋友圈
#import "WXApi.h"

@interface ZDataLineChatVC ()
@property (nonatomic,strong) ZDataLineChatInfomationView *infomationView;
@property (nonatomic,strong) LFLineChart *lineChart;
@property (nonatomic,strong) ZShareView *shareView;

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
    __weak typeof(self) weakSelf = self;
    self.customNavBar.onClickRightButton = ^{
        [weakSelf.view addSubview:weakSelf.shareView];
    };
}

- (void)setMainView {
    [self.view addSubview:self.infomationView];
    if (self.isHorizontal) {
        [self.infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+10);
            make.width.mas_equalTo(180.0f);
        }];
    }else{
        [self.infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(130.0f);
        }];
    }
}


#pragma mark lazy loading
-(ZDataLineChatInfomationView *)infomationView {
    if (!_infomationView) {
        _infomationView = [[ZDataLineChatInfomationView alloc] init];
    }
    
    return _infomationView;
}

- (ZShareView *)shareView {
    if (!_shareView) {
        __weak typeof(self) weakSelf = self;
        _shareView = [[ZShareView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
        _shareView.sureBlock = ^(NSInteger tag) {
            if(tag == 0){
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatSession image:[weakSelf screenShot]];
            }else {
                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine image:[weakSelf screenShot]];
            }
        };
    }
    return _shareView;
}


- (void)setLineChat {
    self.lineChart = [[LFLineChart alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - 160 - kSafeAreaTopHeight)];
    self.lineChart.clipsToBounds = YES;
    NSMutableArray *orderedArray = [[NSMutableArray alloc] init];
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
    self.lineChart.yMarkTitles = @[[NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue + (self.lineChart.maxValue - self.lineChart.minValue)/6],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*2/6],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*3/6],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*4/6],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.minValue +(self.lineChart.maxValue - self.lineChart.minValue)*5/6],
                                   [NSString stringWithFormat:@"%.0fmm",self.lineChart.maxValue]]; // Y轴刻度标签
    
    [self.lineChart setXMarkTitlesAndValues:orderedArray titleKey:@"item" valueKey:@"count" value1Key:@"count1" value2Key:@"count2"]; // X轴刻度标签及相应的值
    
    
    
    [self.view addSubview:self.lineChart];
    if (self.isHorizontal) {
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-180-12, kWindowH - 30 - kSafeAreaTopHeight);
        [self.lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.infomationView.mas_left).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
    }else{
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - 130 - kSafeAreaTopHeight-20);
        [self.lineChart mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.infomationView.mas_top).offset(0);
        }];
    }
    //设置完数据等属性后绘图折线图
    [self.lineChart mapping];
}

#pragma mark 截图处理

- (UIImage *)screenShot {
    UIImage* image = nil;
    UIGraphicsBeginImageContextWithOptions(self.lineChart.scrollView.contentSize, YES, 0.0);
    
    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = self.lineChart.scrollView.contentOffset;
    CGRect saveFrame = self.lineChart.scrollView.frame;
    
    //将collectionView的偏移量设置为(0,0)
    self.lineChart.scrollView.contentOffset = CGPointZero;
    self.lineChart.scrollView.frame = CGRectMake(0, 0, self.lineChart.scrollView.contentSize.width, self.lineChart.scrollView.contentSize.height);
    
    //在当前上下文中渲染出collectionView
    [self.lineChart.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复collectionView的偏移量
    self.lineChart.scrollView.contentOffset = savedContentOffset;
    self.lineChart.scrollView.frame = saveFrame;
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}



- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType image:(UIImage *)image
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    shareObject.thumbImage = [UIImage imageNamed:@"biceicon"];
    [shareObject setShareImage:image];
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}



-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    if (!_infomationView || !_lineChart) {
        return;
    }
    if (self.isHorizontal) {
        [self.infomationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+10);
            make.width.mas_equalTo(180.0f);
        }];
    }else{
        [self.infomationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo(130.0f);
        }];
    }
    
    if (self.isHorizontal) {
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-180-12, kWindowH - 30 - kSafeAreaTopHeight);
        [self.lineChart mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.infomationView.mas_left).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
    }else{
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - 150 - kSafeAreaTopHeight);
        [self.lineChart mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.infomationView.mas_top).offset(0);
        }];
    }
    
    //设置完数据等属性后绘图折线图
    [self.lineChart reloadDatas];
}
@end
