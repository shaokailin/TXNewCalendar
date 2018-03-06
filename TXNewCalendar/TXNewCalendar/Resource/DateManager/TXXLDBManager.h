//
//  TXXLDBManager.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/3/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLDBManager : NSObject
- (NSDictionary *)selectYiJiXiongJi:(NSString *)tg month:(NSInteger)month;
- (NSDictionary *)selectSearch:(NSString *)key isAvoid:(BOOL)isAvoid;
@end
