//
//  TXXLSearchDetailListModel.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchDetailListModel.h"
@implementation TXXLSearchDetailModel
//+ (NSDictionary *)modelCustomPropertyMapper {
//    return @{
//             @"nongliNum" : @"_nongli",
//             };
//}
@end
@implementation TXXLSearchDetailListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"detail" : [TXXLSearchDetailModel class],
             };
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
             @"title" : @"data.title",
             @"num" : @"data.num",
             @"detail" : @"data.detail",
             };
}
@end
