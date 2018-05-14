//
//  TXBZSMNavigationView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NavigaitionBlock)(NSInteger type);
@interface TXBZSMNavigationView : UIView
@property (nonatomic, copy) NavigaitionBlock block;
@end
