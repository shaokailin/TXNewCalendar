//
//  TXXLCalculateModuleAPI.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLCalculateModuleAPI : NSObject
+ (LSKParamterEntity *)getCalculateHomeData:(NSString *)contactId limit:(NSString *)limit;
@end
