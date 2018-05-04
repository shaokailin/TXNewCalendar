//
//  TXBZSMFortuneModuleAPI.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXBZSMFortuneModuleAPI : NSObject
+ (LSKParamterEntity *)getFortuneHomeAdData:(NSString *)contactId limit:(NSString *)limit;
+ (LSKParamterEntity *)getForuneHomeMessage:(NSString *)xingzuo;
@end
