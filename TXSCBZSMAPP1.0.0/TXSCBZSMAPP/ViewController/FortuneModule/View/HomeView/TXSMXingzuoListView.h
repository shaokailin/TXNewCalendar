//
//  TXSMXingzuoListView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/16.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^XingzuoChangeBlock)(NSString *xingzuo,NSString *english);
@interface TXSMXingzuoListView : UIView
@property (nonatomic, copy) XingzuoChangeBlock changeBlock;
- (void)show;
@end
