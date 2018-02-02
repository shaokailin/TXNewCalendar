//
//  TXXLAlmanacModuleAPI.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLAlmanacModuleAPI : NSObject
+ (LSKParamterEntity *)getAlmanacHomeData:(NSString *)dateString;
+ (LSKParamterEntity *)getAlmanacDetailData:(NSString *)dateString;
//isShow 判断是否只显示周末 默认为0全部显示 ，1为只显示周末 isYj 宜忌判断要筛选是宜或忌，默认为0 宜， 1为忌
+ (LSKParamterEntity *)getSearchDetailWithStart:(NSString *)start endTime:(NSString *)endTime text:(NSString *)text isShowWeekend:(BOOL)isShow isYj:(BOOL)isYj;
+ (LSKParamterEntity *)getSearchMoreListWithIsYj:(BOOL)isYj;
@end
