//
//  ZCellConfig.h
//  ZQingSongGuang
//
//  Created by zzz on 2018/7/22.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, HNCellType) {
    HNCellTypeClass,          // regular table view
    HNCellTypeNib         // preferences style table view
};
@interface ZCellConfig : NSObject

/// cell类名
@property (nonatomic, strong) NSString *className;

/// 标题 - 如“我的订单”，对不同种cell进行不同设置时，通过 其对应的 cellConfig.title 进行判断
@property (nonatomic, strong) NSString *title;

/// 显示数据模型的方法
@property (nonatomic, assign) SEL showInfoMethod;

/// cell高度
@property (nonatomic, assign) CGFloat heightOfCell;

/// 类型，nib还是class
@property (nonatomic) HNCellType cellType;
/// 预留属性detail
@property (nonatomic, strong) NSString *detail;

/// 预留属性remark
@property (nonatomic, strong) NSString *remark;

@property(nonatomic,strong) id dataModel;


/**
 便利构造器

 @param className 类名
 @param title 标题，可用做cell直观的区分
 @param showInfoMethod 此类cell用来显示数据模型的方法， 如@selector(showInfo:)
 @param heightOfCell 此类cell的高度
 @param cellType 类型  class or nib
 @return cell 描述
 */
+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(HNCellType)cellType;

/**
 *  可以传入数据
 *
 *  @param className      ;
 *  @param title          ;
 *  @param showInfoMethod ;
 *  @param heightOfCell   ;
 *  @param cellType       ;
 *  @param dataModel      ;
 *
 *  @return ;
 */
+ (instancetype)cellConfigWithClassName:(NSString *)className
                                  title:(NSString *)title
                         showInfoMethod:(SEL)showInfoMethod
                           heightOfCell:(CGFloat)heightOfCell
                               cellType:(HNCellType)cellType
                              dataModel:(id)dataModel;

/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellConfigWithTableView:(UITableView *)tableView
                                         dataModel:(id)dataModel;

/// 根据cellConfig生成cell，重用ID为cell类名
- (UITableViewCell *)cellOfCellHNConfigWithTableView:(UITableView *)tableView dataModel:(id)dataModel;
@end
