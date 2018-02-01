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
             @"nongli" : @"data.nongli",
             @"nongliNum" : @"data._nongli",
             @"jinian" : @"data.jinian",
             @"shengxiao" : @"data.shengxiao",
             @"jie_ri" : @"data.jie_ri",
             @"gongli" : @"data.gongli",
             @"week" : @"data.week",
             @"jieqi" : @"data.jieqi",
             @"position" : @"data.position",
             @"bamen" : @"data.bamen",
             @"peng_zu" : @"data.peng_zu",
             @"jianchu" : @"data.jianchu",
             @"hehai" : @"data.hehai",
             @"na_yin" : @"data.na_yin",
             @"xing_su" : @"data.xing_su",
             @"kong_wang" : @"data.kong_wang",
             @"zhi_ri" : @"data.zhi_ri",
             @"tai_shen" : @"data.tai_shen",
             @"san_sha" : @"data.san_sha",
             @"xing_zuo" : @"data.xing_zuo",
             @"h_detail" : @"data.h_detail",
             @"yi_ji" : @"data.yi_ji"
             };
}
@end
