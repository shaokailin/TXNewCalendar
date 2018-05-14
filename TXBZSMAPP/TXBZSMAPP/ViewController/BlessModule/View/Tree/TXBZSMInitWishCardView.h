//
//  TXBZSMInitWishCardView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^InitWishCardBlock)(NSInteger type);
@interface TXBZSMInitWishCardView : UIView
@property (nonatomic, copy) InitWishCardBlock block;
- (void)setupContent:(TXBZSMWishTreeModel *)model;
@end
