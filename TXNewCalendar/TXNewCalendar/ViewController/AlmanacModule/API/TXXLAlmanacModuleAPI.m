//
//  TXXLAlmanacModuleAPI.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacModuleAPI.h"
#import "TXXLAlmanacHomeModel.h"
//获取黄历首页的数据
static NSString * const kAlmanacHomeApi = @"detail.html";
@implementation TXXLAlmanacModuleAPI
+ (LSKParamterEntity *)getAlmanacHomeData:(NSString *)dateString {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestApi = kAlmanacHomeApi;
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLAlmanacHomeModel class];
    [params.params setValue:dateString forKeyPath:@"time"];
    return params;
}
@end
