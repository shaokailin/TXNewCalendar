//
//  TXSMFortuneHomeAPI.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXSMFortuneHomeAPI : NSObject
+ (LSKParamterEntity *)getForuneHomeMessage:(NSString *)xingzuo;
+ (LSKParamterEntity *)getForuneHomeData:(NSString *)contactId limit:(NSString *)limit;
@end
