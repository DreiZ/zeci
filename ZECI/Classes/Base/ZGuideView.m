//
//  ZGuideView.m
//  ZECI
//
//  Created by zzz on 2018/8/16.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZGuideView.h"

@interface ZGuideView ()<JMHoledViewDelegate>
{
    BOOL isConsult;
    NSInteger stepindex;
    CGRect _holeFrame;
}
@property (nonatomic, strong) UILabel *introLabel;
@property (nonatomic, strong) UIButton *sureBtn;
@end

@implementation ZGuideView

-(void)holedView:(JMHoledView *)holedView didSelectHoleAtIndex:(NSUInteger)index {
    
}

-(void)setHoleFrame:(CGRect)holeFrame {
    _holeFrame = holeFrame;
}

-(instancetype)initWithListGuideView:(CGRect)frame holeRect:(CGRect)holeFrame {
    
    if (self = [super initWithFrame:frame]) {
        isConsult = YES;
        stepindex = 1;
        self.holeViewDelegate = self;
        
        _holeFrame = holeFrame;
        [self addHoleRectOnRect:holeFrame];
        [self addHCustomView:[self viewForGuideWithY:holeFrame.origin.y+10+holeFrame.size.height] onRect:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - 100), holeFrame.origin.y+10+holeFrame.size.height, 200.0f, 50.0f)];
        
        self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - getValueWithoutLimit(140)/2.0f),self.introLabel.bottom+20 , getValueWithoutLimit(140), getValueWithoutLimit(40))];
        self.sureBtn.layer.masksToBounds = YES;
        self.sureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.sureBtn.layer.borderWidth = 1;
        self.sureBtn.layer.cornerRadius = 4;
        [self.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureBtn];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isDataListLoaded"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}



-(instancetype)initWithTestGuideView:(CGRect)frame holeRect:(CGRect)holeFrame {
    
    if (self = [super initWithFrame:frame]) {
        isConsult = YES;
        stepindex = 1;
        self.holeViewDelegate = self;
        
        _holeFrame = holeFrame;
        [self addHoleRectOnRect:holeFrame];
        [self addHCustomView:[self viewForGuideWithY:holeFrame.origin.y+10+holeFrame.size.height] onRect:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - 100), holeFrame.origin.y+10+holeFrame.size.height, 200.0f, 50.0f)];
        
        self.sureBtn = [[UIButton alloc] initWithFrame:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - getValueWithoutLimit(140)/2.0f),self.introLabel.bottom+20 , getValueWithoutLimit(140), getValueWithoutLimit(40))];
        self.sureBtn.layer.masksToBounds = YES;
        self.sureBtn.layer.borderColor = [UIColor whiteColor].CGColor;
        self.sureBtn.layer.borderWidth = 1;
        self.sureBtn.layer.cornerRadius = 4;
        [self.sureBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [self.sureBtn addTarget:self action:@selector(surePress:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.sureBtn];
        
        [[NSUserDefaults standardUserDefaults] setObject:@(YES) forKey:@"isMeasureLoad"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return self;
}


- (UIView *)viewForGuideWithY:(CGFloat)tempY
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - 100), tempY, 200.0f, 50.0f)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.borderWidth = 1.0f;
    label.layer.cornerRadius = 10.0f;
    [label setTextColor:[UIColor whiteColor]];
    label.text = @"左滑可删除数据";
    label.numberOfLines = 0;
    label.font = [UIFont boldSystemFontOfSize:[ZPublicManager getIsIpad] ? 18:16.0f];
    label.textAlignment = NSTextAlignmentCenter;
    _introLabel = label;
    return label;
}



- (void)resetFrame {
    [self removeHoles];
    [self addHoleRectOnRect:_holeFrame];
    [self addHCustomView:[self viewForGuideWithY:_holeFrame.origin.y+10+_holeFrame.size.height] onRect:CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - 100), _holeFrame.origin.y+10+_holeFrame.size.height, 200.0f, 50.0f)];
    
    self.sureBtn.frame = CGRectMake((_holeFrame.origin.x + _holeFrame.size.width/2.0 - getValueWithoutLimit(140)/2.0f),self.introLabel.bottom+20 , getValueWithoutLimit(140), getValueWithoutLimit(40));
}

-(void)surePress:(UIButton *)btn
{
    [self removeFromSuperview];
}
@end
