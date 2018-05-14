//
//  TXBZSMBlessWishCompleteView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ActionBlock)(NSInteger type);
@interface TXBZSMBlessWishCompleteView : UIView
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, copy) ActionBlock block;
- (void)setupContent:(NSString *)img name:(NSString *)name;
@end
