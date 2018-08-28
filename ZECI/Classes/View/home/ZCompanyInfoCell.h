//
//  ZCompanyInfoCell.h
//  ZECI
//
//  Created by zzz on 2018/8/27.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseCell.h"

@interface ZCompanyInfoCell : ZBaseCell
@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *rightLabel;
@property (nonatomic,strong) UIImageView *arrowImageView;

@property (nonatomic,assign) BOOL hiddenArrowImageView;
@end
