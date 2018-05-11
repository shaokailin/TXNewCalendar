//
//  TXBZSMMyBlessWishView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXBZSMMyBlessWishView : UIView
@property (nonatomic, copy, readonly) NSString *contentString;
@property (nonatomic, copy, readonly) NSString *userString;
- (void)setupGodImage:(NSString *)image;
@end
