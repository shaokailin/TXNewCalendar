//
//  TXBZSMHappyManager.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/4/28.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXBZSMHappyManager : NSObject
+ (TXBZSMHappyManager *)sharedInstance;
//喜用神
- (NSString *)getHappyGod:(NSDate *)date;
//获取喜用神的描述
- (NSString *)getXysDetail:(NSString *)xys;
//获取八卦
- (void)getGossipMessage:(NSDate *)date isBoy:(BOOL)isBoy;
//获取先天总运
- (NSDictionary *)getXtzyDgz:(NSString *)dgz;
//先天爱情
- (NSDictionary *)getXtLoveDgz:(NSString *)dgz;
//先天财运
- (NSDictionary *)getXtFortuneDgz:(NSString *)dgz;
//先天事业
- (NSDictionary *)getXtWorkDgz:(NSString *)dgz;
//获取财运和桃花位
- (NSDictionary *)getMoneyAndLovePosition:(NSDate *)date;
//获取吉祥色
- (NSDictionary *)getLuckColor:(NSDate *)date bitrhDay:(NSDate *)birthday;
@end
