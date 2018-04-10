//
//  TXSMDetailBottonView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^WebViewLoadEvent)(NSInteger type);
@interface TXSMDetailBottonView : UIView
@property (nonatomic, copy) WebViewLoadEvent loadBlock;
@end
