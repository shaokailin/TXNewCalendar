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
static NSString * const kFestivalsListApi = @"jieri.html";
static NSString * const kHolidaysListApi = @"jiejiari.html";
static NSString * const kSolarTermsListApi = @"jieqi.html";
@implementation TXXLCalendarModuleAPI
+ (LSKParamterEntity *)getFestivalsList:(NSString *)time type:(NSInteger)type  {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    if (type != 2) {
        params.requestApi = type == 0?kFestivalsListApi:kSolarTermsListApi;
        [params.params setValue:time forKeyPath:@"time"];
        params.responseObject = [TXXLFestivalsListModel class];
    }else {
        params.requestApi = kHolidaysListApi;
        params.responseObject = [TXXLHolidaysListModel class];
    }
    params.requestType = HTTPRequestType_GET;
    
    return params;
}
@end
