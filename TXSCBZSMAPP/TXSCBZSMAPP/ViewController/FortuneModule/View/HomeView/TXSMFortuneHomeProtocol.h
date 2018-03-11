//
//  TXSMFortuneHomeProtocol.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TXSMFortuneHomeProtocol <NSObject>
- (CGFloat)returnViewHeight;
- (void)setupContent:(NSString *)name dict:(NSDictionary *)dict;
@end
