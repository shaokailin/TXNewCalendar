//
//  TXXLCalendarModuleAPI.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLCalendarModuleAPI : NSObject
//节日列表
+ (LSKParamterEntity *)getFestivalsList:(NSString *)time type:(NSInteger)type;

@end
