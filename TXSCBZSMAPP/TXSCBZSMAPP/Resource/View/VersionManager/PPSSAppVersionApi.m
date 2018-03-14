//
//  PPSSAppVersionApi.m
//  PPSSBusiness
//
//  Created by hsPlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppVersionApi.h"
#import "PPSSAppVersionModel.h"
static NSString * const kAppVersionApi = @"app.datablock/getlist.html";
@implementation PPSSAppVersionApi
+ (LSKParamterEntity *)getAppVersionData {
    LSKParamterEntity *entity = [[LSKParamterEntity alloc]init];
    entity.requestApi = kAppVersionApi;
    entity.requestType = HTTPRequestType_GET;
    entity.isCallApi2 = YES;
    [entity.params setObject:@"30" forKey:@"bid"];
    [entity.params setObject:@"1" forKey:@"limit"];
    [entity.params setObject:@(300) forKey:@"cache"];
    entity.responseObject = [PPSSAppVersionModel class];
    return entity;
}
@end
