//
//  TXSMFortuneNumberButton.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSMFortuneNumberButton : UIButton
- (void)setupContent:(NSString *)value;
- (instancetype)initWithType:(NSInteger)type;
@end
