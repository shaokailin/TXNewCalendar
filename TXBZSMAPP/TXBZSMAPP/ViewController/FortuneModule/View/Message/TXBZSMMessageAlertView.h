//
//  TXBZSMMessageAlertView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^AlertBlock)(NSInteger type);
@interface TXBZSMMessageAlertView : UIView
@property (nonatomic, copy) AlertBlock block;
@property (nonatomic, assign) CGFloat tabHeight;
@end
