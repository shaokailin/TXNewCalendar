//
//  TXBZSMFortuneModuleAPI.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMFortuneModuleAPI.h"
#import "TXBZSMDictionaryModel.h"
@implementation TXBZSMFortuneModuleAPI
+ (LSKParamterEntity *)getFortuneHomeAdData:(NSString *)contactId limit:(NSString *)limit {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXBZSMDictionaryModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.datablock/getlist.html";
    [params.params setObject:contactId forKey:@"bid"];
    [params.params setObject:limit forKey:@"limit"];
    [params.params setObject:@(3000) forKey:@"cache"];
    return params;
}
+ (LSKParamterEntity *)getForuneHomeMessage:(NSString *)xingzuo {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXBZSMDictionaryModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.scbz/yunshi.html";
    [params.params setObject:xingzuo forKey:@"xingzuo"];
    [params.params setObject:@(300) forKey:@"cache"];
    return params;
}

@end
