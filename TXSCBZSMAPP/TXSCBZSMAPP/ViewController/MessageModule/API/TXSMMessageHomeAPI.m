//
//  TXSMMessageHomeAPI.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageHomeAPI.h"
#import "TXXLCalculateHomeModel.h"
#import "TXSMFortuneHomeModel.h"
@implementation TXSMMessageHomeAPI
+ (LSKParamterEntity *)getMessageHomeAd:(NSString *)contactId limit:(NSString *)limit {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXXLCalculateHomeModel class];
    params.isCallApi2 = YES;
    params.requestApi = @"app.datablock/getlist.html";
    [params.params setObject:contactId forKey:@"bid"];
    [params.params setObject:@(300) forKey:@"cache"];
    [params.params setObject:limit forKey:@"limit"];
    return params;
}
+ (LSKParamterEntity *)getMessageHomeData:(NSInteger)page type:(NSInteger)type {
    LSKParamterEntity *params = [[LSKParamterEntity alloc]init];
    params.requestType = HTTPRequestType_GET;
    params.responseObject = [TXSMFortuneHomeModel class];
    params.isCallApi2 = YES;
    if (type == 0) {
        params.requestApi = @"app.scbz/yunshilist.html";
    }else{
        params.requestApi = @"app.scbz/infobig.html";
        NSInteger bid = 8;
        if (type == 1) {
            bid = 88;
        }else if (type == 3){
            bid = 2;
        }else if (type == 4){
            bid = 1;
        }else if (type == 5){
            bid = 5;
        }
       [params.params setObject:@(bid) forKey:@"big"];
    }
    [params.params setObject:@(15) forKey:@"limit"];
    [params.params setObject:@(page + 1) forKey:@"pid"];
    [params.params setObject:@(300) forKey:@"cache"];
    return params;
}
@end
