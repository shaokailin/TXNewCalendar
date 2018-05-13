//
//  TXBZSMWishCardDetailView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXBZSMWishCardDetailView : UIView
@property (nonatomic, copy) WishHomeBlock homeBlock;
- (void)setupContentWithData:(NSDictionary *)dict;
@end
