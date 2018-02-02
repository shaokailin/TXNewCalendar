//
//  TXXLAlmanacModuleAPI.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacModuleAPI.h"
#import "TXXLAlmanacHomeModel.h"
#import "TXXLAlmanacDetailModel.h"
#import "TXXLSearchMoreListModel.h"
#import "TXXLSearchDetailListModel.h"
//获取黄历首页的数据
static NSString * const kAlmanacHomeApi = @"index.html";
static NSString * const kAlmanacDetailApi = @"detail.html";
static NSString * const kSearchMoreApi = @"category.html";
static NSString * const kSearchDetailApi = @"dayyi.html";
@implementation TXXLAlmanacModuleAPI
+ (LSKParamterEntity *)getAlmanacHomeData:(NSString *)dateString {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kAlmanacHomeApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLAlmanacHomeModel class];
    [params.params setValue:dateString forKeyPath:@"time"];
    return params;
}
+ (LSKParamterEntity *)getAlmanacDetailData:(NSString *)dateString {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kAlmanacDetailApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLAlmanacDetailModel class];
    [params.params setValue:dateString forKeyPath:@"time"];
    return params;
}
+ (LSKParamterEntity *)getSearchDetailWithStart:(NSString *)start endTime:(NSString *)endTime text:(NSString *)text isShowWeekend:(BOOL)isShow isYj:(BOOL)isYj {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kSearchDetailApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLSearchDetailListModel class];
    [params.params setValue:start forKeyPath:@"start"];
    [params.params setValue:endTime forKeyPath:@"end"];
    [params.params setValue:text forKeyPath:@"text"];
    [params.params setValue:@(isShow) forKeyPath:@"show"];
    [params.params setValue:@(isYj) forKeyPath:@"yj"];
    return params;
}
+ (LSKParamterEntity *)getSearchMoreListWithIsYj:(BOOL)isYj {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kSearchMoreApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLSearchMoreListModel class];
    [params.params setValue:@(isYj) forKeyPath:@"yj"];
    return params;
}
@end
