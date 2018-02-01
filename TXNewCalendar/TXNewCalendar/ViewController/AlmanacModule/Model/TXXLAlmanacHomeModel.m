//
//  TXXLAlmanacHomeModel.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacHomeModel.h"

@implementation TXXLAlmanacHomeModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"jian_chu" : @"data.jian_chu",
             @"chong_sha" : @"data.chong_sha",
             @"na_yin" : @"data.na_yin",
             @"tai_shen" : @"data.tai_shen",
             @"peng_zu" : @"data.peng_zu",
             @"xing_su" : @"data.xing_su",
             @"zhi_shen" : @"data.zhi_shen",
             @"lucky" : @"data.lucky",
             @"jishen" : @"data.jishen",
             @"xiong" : @"data.xiong",
             @"yi" : @"data.yi",
             @"ji" : @"data.ji",
             };
}
@end
