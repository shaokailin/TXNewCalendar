//
//  TXSMShareView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <WXApi.h>
typedef void (^ShareClickBlock)(NSInteger type);
@interface TXSMShareView : UIView
@property (nonatomic, copy) ShareClickBlock shareBlock;
- (instancetype)initWithTabbar:(CGFloat)height;
- (void)showInView;
@end
