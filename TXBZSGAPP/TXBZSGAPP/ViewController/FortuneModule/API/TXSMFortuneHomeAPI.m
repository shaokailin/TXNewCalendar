//
//  TXSMFortuneHomeAPI.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeAPI.h"
#import "TXXLCalculateHomeModel.h"
#import "TXSMFortuneHomeModel.h"
@implementation TXSMFortuneHomeAPI
+ (LSKParamterEntity *)getForuneHomeData:(NSString *)contactId limit:(NSString *)limit {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXSMFortuneHomeModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.datablock/getlist.html";
    [params.params setObject:contactId forKey:@"bid"];
     [params.params setObject:@(300) forKey:@"cache"];
    [params.params setObject:limit forKey:@"limit"];
    return params;
}
+ (LSKParamterEntity *)getForuneHomeMessage:(NSString *)xingzuo {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLCalculateHomeModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.scbz/yunshi.html";
    [params.params setObject:xingzuo forKey:@"xingzuo"];
    [params.params setObject:@(300) forKey:@"cache"];
    return params;
}
@end
