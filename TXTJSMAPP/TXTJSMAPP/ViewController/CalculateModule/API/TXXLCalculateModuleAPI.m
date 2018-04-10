//
//  TXXLCalculateModuleAPI.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateModuleAPI.h"
#import "TXXLCalculateHomeModel.h"
@implementation TXXLCalculateModuleAPI
+ (LSKParamterEntity *)getCalculateHomeData:(NSString *)contactId limit:(NSString *)limit {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLCalculateHomeModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.datablock/getlist.html";
    [params.params setObject:contactId forKey:@"bid"];
//    [params.params setObject:@"list" forKey:@"type"];
    [params.params setObject:limit forKey:@"limit"];
    [params.params setObject:@(300) forKey:@"cache"];
    return params;
}
@end
