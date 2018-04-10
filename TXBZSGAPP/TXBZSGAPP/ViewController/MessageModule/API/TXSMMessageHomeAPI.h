//
//  TXSMMessageHomeAPI.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXSMMessageHomeAPI : NSObject
+ (LSKParamterEntity *)getMessageHomeData:(NSInteger)page type:(NSInteger)type;
+ (LSKParamterEntity *)getMessageHomeAd:(NSString *)contactId limit:(NSString *)limit;
+ (LSKParamterEntity *)getMessageDetail:(NSString *)article_id;
@end
