//
//  TXBZSMMyWishMainView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WishTreeCompleteBlock)(NSInteger type,TXBZSMWishTreeModel *model,NSInteger index);;
@interface TXBZSMMyWishMainView : UIView
@property (nonatomic, copy) WishTreeCompleteBlock homeBlock;
@property (nonatomic, assign) CGFloat topBetween;
@end
