//
//  TXXLCalendarModuleAPI.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalendarModuleAPI.h"
#import "TXXLFestivalsListModel.h"
#import "TXXLHolidaysListModel.h"
#import "TXXLSolarTermsListModel.h"
static NSString * const kFestivalsListApi = @"jieri.html";
static NSString * const kHolidaysListApi = @"jiejiari.html";
static NSString * const kSolarTermsListApi = @"jieqi.html";
@implementation TXXLCalendarModuleAPI
+ (LSKParamterEntity *)getHolidaysList {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kHolidaysListApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLHolidaysListModel class];
    return params;
}
+ (LSKParamterEntity *)getFestivalsList:(NSString *)time {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kFestivalsListApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLFestivalsListModel class];
    [params.params setValue:time forKeyPath:@"time"];
    return params;
}
+ (LSKParamterEntity *)getSolarTermsList:(NSString *)time {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kSolarTermsListApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLSolarTermsListModel class];
    [params.params setValue:time forKeyPath:@"time"];
    return params;
}
@end
