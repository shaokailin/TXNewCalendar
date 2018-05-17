//
//  TXBZSMUserMessageView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^UserMessageBlock)(NSInteger type);
@interface TXBZSMUserMessageView : UIView
@property (nonatomic, copy) UserMessageBlock block;
@end
