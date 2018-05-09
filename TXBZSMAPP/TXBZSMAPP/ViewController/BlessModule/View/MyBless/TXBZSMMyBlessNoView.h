//
//  TXBZSMMyBlessNoView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NoDataBlock)(BOOL isClick);
@interface TXBZSMMyBlessNoView : UIView
@property (nonatomic, copy) NoDataBlock block;
@end
