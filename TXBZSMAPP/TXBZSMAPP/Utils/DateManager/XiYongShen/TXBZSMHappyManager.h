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
//获取八卦
- (void)getGossipMessage:(NSDate *)date isBoy:(BOOL)isBoy;
//获取先天总运
- (NSDictionary *)getXtzyDate:(NSDate *)date;
@end
