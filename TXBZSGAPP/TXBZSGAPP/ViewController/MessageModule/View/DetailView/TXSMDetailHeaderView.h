//
//  TXSMDetailHeaderView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSMDetailHeaderView : UIView
@property (nonatomic, assign, readonly) CGFloat contentHeight;
- (void)setupArticleTitle:(NSString *)title from:(NSString *)from date:(NSString *)date;
@end
