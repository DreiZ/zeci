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
#import "ZMeasureSaveImageToPhotoView.h"

#import "ZLineChatBrowseVC.h"

//#import <UMShare/UMShare.h>
////微信好友和朋友圈
//#import "WXApi.h"

#define firstLevel 12
#define secondLevel 24

@interface ZDataLineChatVC ()
@property (nonatomic,strong) ZDataLineChatInfomationView *infomationView;
@property (nonatomic,strong) LFLineChart *lineChart;
//@property (nonatomic,strong) ZShareView *shareView;
@property (nonatomic,strong) ZMeasureSaveImageToPhotoView *saveView;

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
//    [self.customNavBar wr_setRightButtonWithImage:[UIImage imageNamed:@"fenxiang"]];
//    __weak typeof(self) weakSelf = self;
//    self.customNavBar.onClickRightButton = ^{
//        [weakSelf.view addSubview:weakSelf.shareView];
//    };
}

- (void)setMainView {
    [self.view addSubview:self.infomationView];
    
    [self.view addSubview:self.saveView];
    
    if (self.isHorizontal) {
        [self.infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+10);
            make.width.mas_equalTo([ZPublicManager getIsIpad] ? 230:180);
        }];
        
        [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 120:80);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -10 : -5);
            make.right.equalTo(self.view.mas_right).offset([ZPublicManager getIsIpad] ? -10:-7);
        }];
        
    }else{
        [self.infomationView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo([ZPublicManager getIsIpad] ? 150:130);
        }];
        
        [self.saveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 120:80);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -10 : -5);
            make.left.equalTo(self.view.mas_left).offset([ZPublicManager getIsIpad] ? 10:7);
        }];
    }
    self.infomationView.titleLabel.text = [NSString stringWithFormat:@"耳标编号：%@",self.singlePigData.earTag];
}


#pragma mark lazy loading
-(ZDataLineChatInfomationView *)infomationView {
    if (!_infomationView) {
        _infomationView = [[ZDataLineChatInfomationView alloc] init];
    }
    
    return _infomationView;
}

- (ZMeasureSaveImageToPhotoView *)saveView {
    if (!_saveView) {
        __weak typeof(self) weakSelf = self;
        _saveView = [[ZMeasureSaveImageToPhotoView alloc] init];
        _saveView.saveBlock = ^{
            [weakSelf savePictureToPhotoAlbum];
        };
    }
    return _saveView;
}
//
//- (ZShareView *)shareView {
//    if (!_shareView) {
//        __weak typeof(self) weakSelf = self;
//        _shareView = [[ZShareView alloc] initWithFrame:CGRectMake(0, 0, kWindowW, kWindowH)];
//        _shareView.sureBlock = ^(NSInteger tag) {
//            if(tag == 0){
//                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatSession image:[weakSelf screenShot]];
//            }else {
//                [weakSelf shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine image:[weakSelf screenShot]];
//            }
//        };
//    }
//    _shareView.frame = CGRectMake(0, 0, kWindowW, kWindowH);
//    return _shareView;
//}


- (void)setLineChat {
    self.lineChart = [[LFLineChart alloc] initWithFrame:CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - 160 - kSafeAreaTopHeight)];
    self.lineChart.clipsToBounds = YES;
    __weak typeof(self) weakSelf = self;
    self.lineChart.tapBlock = ^{
        UIImage* image = [weakSelf screenShot];
        ZLineChatBrowseVC* controller = [[ZLineChatBrowseVC alloc] initWithImage:image lastPageFrame:weakSelf.lineChart.frame];
        controller.modalPresentationStyle = UIModalPresentationOverFullScreen;
        controller.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [weakSelf presentViewController:controller animated:true completion:nil];
    };

    NSMutableArray *orderedArray = [[NSMutableArray alloc] init];
    //第一条数据
    NSMutableArray *firstDataArr = @[].mutableCopy;
    //第二条数据
    NSMutableArray *secondDataArr = @[].mutableCopy;
    //第三条数据
    NSMutableArray *thridDataArr = @[].mutableCopy;
    //日期坐标
    NSMutableArray *xValueArr = @[].mutableCopy;
    if (_singlePigData.singleList && _singlePigData.singleList.count > 0) {
        ZSingleData *firstData = _singlePigData.singleList[0];
        
        //第一条数据未前一天，空数据
        [firstDataArr addObject:@""];
        [secondDataArr addObject:@""];
        [thridDataArr addObject:@""];
        
        [xValueArr addObject:[ZPublicManager timeWithStr:[NSString stringWithFormat:@"%ld",[firstData.testTime integerValue] - 60 * 60 * 24] format:@"MM月dd日"]];
        
        ZSingleData *lastSingleData = nil;
        
        for (ZSingleData *singleData in _singlePigData.singleList) {

            NSString *lastTime = nil;
//            if (lastSingleData) {
//
//                lastTime = lastSingleData.testTime;
//
//                NSInteger tempSpaceCount = 0;
                
//                while (![[ZPublicManager timeWithStr:[NSString stringWithFormat:@"%ld",[lastTime integerValue] + 24 * 50 * 60] format:@"MMdd"] isEqualToString:[ZPublicManager timeWithStr:singleData.testTime format:@"MMdd"]]) {
//
//                    //防止中间空数据占太长时间
//                    if (tempSpaceCount > 30) {
//                        break;
//                    }
//
//                    [firstDataArr addObject:@""];
//                    [secondDataArr addObject:@""];
//                    [thridDataArr addObject:@""];
//
//                    [xValueArr addObject:[ZPublicManager timeWithStr:[NSString stringWithFormat:@"%ld",[lastTime integerValue] + 60 * 60 * 24] format:@"MM月dd日"]];
//                    lastTime = [NSString stringWithFormat:@"%ld",[lastTime integerValue] + 60 * 60 * 24];
//                    tempSpaceCount++;
//                }
//            }
            

            [firstDataArr addObject:singleData.firstNum];
            [secondDataArr addObject:singleData.secondNum];
            [thridDataArr addObject:singleData.thirdNum];
            
            [xValueArr addObject:[ZPublicManager timeWithStr:singleData.testTime format:@"MM月dd日"]];
            lastTime = singleData.testTime;
            lastSingleData = singleData;
            
        }
    }
    
    CGFloat chatLineWidth = self.isHorizontal ? (kWindowW-180-12):(kWindowH-180-12);
    
    if (xValueArr.count * ([ZPublicManager getIsIpad] ? 70:55) < chatLineWidth) {
        NSInteger addCount = (NSInteger)((chatLineWidth - (xValueArr.count * ([ZPublicManager getIsIpad] ? 70:55)))/([ZPublicManager getIsIpad] ? 70:55));
        for (NSInteger i = 0; i < addCount; i++) {
            [firstDataArr addObject:@""];
            [secondDataArr addObject:@""];
            [thridDataArr addObject:@""];
            ZSingleData *lastData = [_singlePigData.singleList lastObject];
            
            [xValueArr addObject:[ZPublicManager timeWithStr:[NSString stringWithFormat:@"%ld",[lastData.testTime integerValue] + (i+1) * 60 * 60 * 24] format:@"MM月dd日"]];
        }
    }

    float max = 0;
    float min = 0;
    
    for(int i = 0; i < firstDataArr.count; i++){
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        NSString *xValue;
        NSString *yValue;
        NSString *y1Value;
        NSString *y2Value;
        xValue = xValueArr[i];
        yValue = firstDataArr[i];
        y1Value = secondDataArr[i];
        y2Value = thridDataArr[i];
        
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
        dict = [@{@"item" : xValue, @"count":yValue,@"count1":y1Value,@"count2":y2Value} mutableCopy];
        [orderedArray addObject:dict];
    }
    
    self.lineChart.maxValue = max + (max - min)*0.08;
    self.lineChart.minValue = min - (max - min)*0.08;
    if (max < secondLevel*1.5) {
        self.lineChart.maxValue = secondLevel*1.5;
    }
    if (min <= 0) {
        self.lineChart.minValue = 0;
    }
    self.lineChart.minValue = 0;
    
    self.lineChart.firstX = firstLevel;
    self.lineChart.secondX = secondLevel;
    
    self.lineChart.xScaleMarkLEN = [ZPublicManager getIsIpad] ? 70:55;
    
    
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
    ZDataLineChatInfomationView *infomationView = [[ZDataLineChatInfomationView alloc] init];
    [self.lineChart.scrollView addSubview:infomationView];
    infomationView.titleLabel.text = [NSString stringWithFormat:@"耳标编号：%@",self.singlePigData.earTag];

    UIImage* image = nil;
    if (self.isHorizontal) {
        infomationView.frame = CGRectMake(self.lineChart.scrollView.contentSize.width, 10, [ZPublicManager getIsIpad] ? 230:180, self.lineChart.scrollView.height-10);
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.lineChart.scrollView.contentSize.width+([ZPublicManager getIsIpad] ? 230:180), self.lineChart.scrollView.height), YES, 0.0);
    }else{
        infomationView.frame = CGRectMake(0,self.lineChart.scrollView.height, self.lineChart.scrollView.contentSize.width, [ZPublicManager getIsIpad] ? 150:130);
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(self.lineChart.scrollView.contentSize.width, self.lineChart.scrollView.height+([ZPublicManager getIsIpad] ? 150:130)), YES, 0.0);
    }
    
    
    
    //保存collectionView当前的偏移量
    CGPoint savedContentOffset = self.lineChart.scrollView.contentOffset;
    CGRect saveFrame = self.lineChart.scrollView.frame;
    
    //将collectionView的偏移量设置为(0,0)
    self.lineChart.scrollView.contentOffset = CGPointZero;
    if (self.isHorizontal) {
        self.lineChart.scrollView.frame = CGRectMake(0, 0, self.lineChart.scrollView.contentSize.width+([ZPublicManager getIsIpad] ? 230:180), self.lineChart.scrollView.height);
    }else{
        self.lineChart.scrollView.frame = CGRectMake(0, 0, self.lineChart.scrollView.contentSize.width, self.lineChart.scrollView.height+([ZPublicManager getIsIpad] ? 150:130));
    }
    
    
    //在当前上下文中渲染出collectionView
    [self.lineChart.scrollView.layer renderInContext: UIGraphicsGetCurrentContext()];
    //截取当前上下文生成Image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    //恢复collectionView的偏移量
    self.lineChart.scrollView.contentOffset = savedContentOffset;
    self.lineChart.scrollView.frame = saveFrame;
    [infomationView removeFromSuperview];
    
    UIGraphicsEndImageContext();
    
    if (image != nil) {
        return image;
    }else {
        return nil;
    }
}

- (void)savePictureToPhotoAlbum {
    UIImage * img = [self screenShot];
    UIImageWriteToSavedPhotosAlbum(img, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error == nil) {
        [self showSuccessWithMsg:@"截图已保存到系统相册"];
    } else {
        [self showErrorWithMsg:@"截图失败"];
    }
}

//
//
//- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType image:(UIImage *)image
//{
//    //创建分享消息对象
//    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
//
//    //创建图片内容对象
//    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
//    //如果有缩略图，则设置缩略图
//    shareObject.thumbImage = [UIImage imageNamed:@"biceicon"];
//    [shareObject setShareImage:image];
//
//    //分享消息对象设置分享内容对象
//    messageObject.shareObject = shareObject;
//
//    //调用分享接口
//    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
//        if (error) {
//            NSLog(@"************Share fail with error %@*********",error);
//        }else{
//            NSLog(@"response data is %@",data);
//        }
//    }];
//}



-(void)reLayoutSubViewsWithIsHorizontal:(BOOL)isHorizontal {
    [super reLayoutSubViewsWithIsHorizontal:isHorizontal];
    if (!_infomationView || !_lineChart) {
        return;
    }
    if (self.isHorizontal) {
        [self.infomationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.bottom.right.equalTo(self.view);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+10);
            make.width.mas_equalTo([ZPublicManager getIsIpad] ? 230:180);
        }];
    }else{
        [self.infomationView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.equalTo(self.view);
            make.height.mas_equalTo([ZPublicManager getIsIpad] ? 150:130);
        }];
    }
    
    if (self.isHorizontal) {
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-([ZPublicManager getIsIpad] ? 230:180)-12, kWindowH - 30 - kSafeAreaTopHeight);
        [self.lineChart mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.infomationView.mas_left).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.view.mas_bottom).offset(-10);
        }];
        
        [self.saveView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 120:80);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -10 : -5);
            make.right.equalTo(self.view.mas_right).offset([ZPublicManager getIsIpad] ? -10:-7);
        }];
        
    }else{
        
        self.lineChart.frame = CGRectMake(0, kSafeAreaTopHeight+20, kWindowW-12, kWindowH - ([ZPublicManager getIsIpad] ? 150:130) - 20 - kSafeAreaTopHeight);
        
        [self.lineChart mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left).offset(0);
            make.right.equalTo(self.view.mas_right).offset(-12);
            make.top.equalTo(self.view).offset(kSafeAreaTopHeight+20);
            make.bottom.equalTo(self.infomationView.mas_top).offset(0);
        }];
        
        
        [self.saveView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo([ZPublicManager getIsIpad] ? 120:80);
            make.bottom.equalTo(self.view.mas_bottom).offset([ZPublicManager getIsIpad] ? -10 : -5);
            make.left.equalTo(self.view.mas_left).offset([ZPublicManager getIsIpad] ? 10:7);
        }];
    }
    
    //设置完数据等属性后绘图折线图
    [self.lineChart reloadDatas];
}
@end
