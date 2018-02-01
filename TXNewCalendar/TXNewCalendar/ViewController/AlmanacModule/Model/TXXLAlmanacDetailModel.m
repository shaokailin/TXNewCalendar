//
//  TXXLAlmanacDetailModel.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacDetailModel.h"

@implementation TXXLAlmanacDetailModel
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"jian_chu" : @"data.jian_chu",
             @"na_yin" : @"data.na_yin",
             @"tai_shen" : @"data.tai_shen",
             @"peng_zu" : @"data.peng_zu",
             @"xing_su" : @"data.xing_su",
             @"chong_sha" : @"data.chong_sha",
             @"zhi_shen" : @"data.zhi_shen",
             @"lucky" : @"data.lucky",
             @"jishen" : @"data.jishen",
             @"xiong" : @"data.xiong",
             @"yi" : @"data.yi",
             @"ji" : @"data.ji"
             };
}
@end
