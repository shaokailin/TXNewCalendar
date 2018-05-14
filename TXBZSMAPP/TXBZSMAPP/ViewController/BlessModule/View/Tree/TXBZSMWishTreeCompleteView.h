//
//  TXBZSMWishTreeCompleteView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WishTreeCompleteBlock)(NSInteger type);
@interface TXBZSMWishTreeCompleteView : UIView
@property (nonatomic, copy) WishTreeCompleteBlock block;
- (void)setupContent:(NSString *)name;
@end
