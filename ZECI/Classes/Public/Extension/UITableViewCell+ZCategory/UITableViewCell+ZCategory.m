//
//  UITableViewCell+ZCategory.m
//  zcfBase
//
//  Created by zzz on 2018/5/9.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import "UITableViewCell+ZCategory.h"

@implementation UITableViewCell (ZCategory)
+(instancetype)z_cellWithTableView:(UITableView *)tableView
{
    NSString *cellName = [self className];
    id cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        NSString *nibPath = [[NSBundle mainBundle] pathForResource:cellName ofType:@"nib"];
        if (nibPath) {
            [tableView registerNib:[UINib nibWithNibName:cellName bundle:nil] forCellReuseIdentifier:cellName];
        }else{
            [tableView registerClass:self forCellReuseIdentifier:cellName];
        }
        cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    }
    
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
@end
