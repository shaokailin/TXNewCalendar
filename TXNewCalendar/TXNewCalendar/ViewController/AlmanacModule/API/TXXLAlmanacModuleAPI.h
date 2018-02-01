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
@end
