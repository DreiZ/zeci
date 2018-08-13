//
//  ZLoginModel.h
//  ZECI
//
//  Created by zzz on 2018/6/25.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZBaseModel.h"
@class ZLoginResultModel;

@interface ZLoginModel : ZBaseModel
@property (nonatomic,strong) ZLoginResultModel *result;
@property (nonatomic,assign) NSInteger returncode;
@property (nonatomic,copy) NSString *message;
@end

@interface ZLoginResultModel : ZBaseModel
@property (nonatomic,copy) NSString *tel;
@property (nonatomic,copy) NSString *pwd;
@property (nonatomic,copy) NSString *winxinId;
@property (nonatomic,copy) NSString *winxinheadpic;
@property (nonatomic,copy) NSString *winxinnickname;
@property (nonatomic,copy) NSString *qqId;
@property (nonatomic,copy) NSString *qqheadpic;
@property (nonatomic,copy) NSString *qqnickname;
@end
