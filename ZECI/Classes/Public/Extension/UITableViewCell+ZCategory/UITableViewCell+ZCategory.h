//
//  UITableViewCell+ZCategory.h
//  zcfBase
//
//  Created by zzz on 2018/5/9.
//  Copyright © 2018年 zcf. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZTabelViewCellPrototol <NSObject>
@optional
+(CGFloat)z_getCellHeight:(id)sender;
@end

@interface UITableViewCell (ZCategory)<ZTabelViewCellPrototol>
+(instancetype)z_cellWithTableView:(UITableView *)tableView;
@end
