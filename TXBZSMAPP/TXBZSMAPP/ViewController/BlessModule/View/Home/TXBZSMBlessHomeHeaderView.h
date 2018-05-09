//
//  TXBZSMBlessHomeHeaderView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderBlock)(NSInteger type,NSInteger index);
@interface TXBZSMBlessHomeHeaderView : UIView
@property (nonatomic, copy) HeaderBlock block;
- (void)setupContent:(NSArray *)array;
@end
