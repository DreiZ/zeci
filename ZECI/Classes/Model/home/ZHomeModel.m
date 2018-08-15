//
//  ZHomeModel.m
//  ZECI
//
//  Created by zzz on 2018/8/14.
//  Copyright © 2018年 zzz. All rights reserved.
//

#import "ZHomeModel.h"
#import "NSString+pinyin.h"

@implementation ZSingleData

@end

@implementation ZSinglePig
- (void)setEarTag:(NSString *)earTag {
    _earTag = earTag;
    
    // 转拼音
    NSString * PinYin = [earTag transformToPinyin];
    // 首字母
    NSString * FirstLetter = [earTag transformToPinyinFirstLetter];
    
    _namePinYin = PinYin;
    _nameFirstLetter = FirstLetter;
}
@end

@implementation ZTestPigs

@end

@implementation ZHistoryAllList

@end

@implementation ZHomeModel

@end
