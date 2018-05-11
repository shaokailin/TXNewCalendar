//
//  TXBZSMPlatformNaviView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NavigationBlock)(NSInteger type);
@interface TXBZSMPlatformNaviView : UIView
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBetween;

@property (nonatomic, copy) NavigationBlock block;
@end
