//
//  TXBZSMContentMainView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeFrameBlock)(CGFloat height);
@interface TXBZSMContentMainView : UIView
@property (nonatomic, copy) ChangeFrameBlock frameBlock;
- (void)refreshData;
@end
