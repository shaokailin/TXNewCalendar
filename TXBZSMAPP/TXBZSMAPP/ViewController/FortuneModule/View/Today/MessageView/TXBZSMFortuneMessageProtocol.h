//
//  TXBZSMFortuneMessageProtocol.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TXBZSMFortuneMessageProtocol <NSObject>
- (CGFloat)returnViewHeight;
- (void)setupContent:(NSDictionary *)dict;
@end
