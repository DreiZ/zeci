//
//  ZGuideView.h
//  ZECI
//
//  Created by zzz on 2018/8/16.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "JMHoledView.h"

@interface ZGuideView : JMHoledView
-(instancetype)initWithListGuideView:(CGRect)frame holeRect:(CGRect)holeFrame;
-(instancetype)initWithTestGuideView:(CGRect)frame holeRect:(CGRect)holeFrame;
-(void)setHoleFrame:(CGRect)holeFrame;
- (void)resetFrame;
@end
