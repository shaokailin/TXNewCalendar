//
//  TXBZSMTodayAdView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^adClickBlock)(NSInteger index);
@interface TXBZSMTodayAdView : UIView
@property (nonatomic, copy) adClickBlock adBlock;
- (void)setupAdMessage:(NSArray *)array;
@end
