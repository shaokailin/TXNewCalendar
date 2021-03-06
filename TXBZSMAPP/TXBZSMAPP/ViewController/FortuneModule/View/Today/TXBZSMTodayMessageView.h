//
//  TXBZSMTodayMessageView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeFrameBlock)(CGFloat height);
@interface TXBZSMTodayMessageView : UIView
@property (nonatomic, copy) ChangeFrameBlock frameBlock;
- (void)setupContentDate:(NSDictionary *)dict;
@end
