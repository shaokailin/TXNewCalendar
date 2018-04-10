//
//  TXSMFortuneHeaderView.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/15.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HeaderFrameBlock)(CGFloat height);
typedef void (^HeaderJumpBlock)(BOOL isJump);
@interface TXSMFortuneHeaderView : UIView
@property (nonatomic, copy) HeaderFrameBlock frameBlock;
@property (nonatomic, copy) HeaderJumpBlock jumpBlock;
- (void)setupContent:(NSDictionary *)dict messageDict:(NSDictionary *)message;
- (UIImage *)getMessageViewImage;
@end
