//
//  ZSpaceCell.m
//  fixture365
//
//  Created by zzz on 2018/5/11.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZSpaceCell.h"

@implementation ZSpaceCell

- (void)setBackColor:(UIColor *)backColor {
    _backColor = backColor;
    self.contentView.backgroundColor = backColor;
}

+ (CGFloat)z_getCellHeight:(id)sender {
    return 0;
}
@end
