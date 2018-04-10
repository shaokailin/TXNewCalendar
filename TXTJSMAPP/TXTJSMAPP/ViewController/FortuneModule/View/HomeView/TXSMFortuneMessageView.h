//
//  TXSMFortuneMessageView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface TXSMFortuneMessageView : UIView
- (void)setupContentWithDetail:(NSDictionary *)dict;
- (CGFloat)returnCurrentHeight;
- (void)setupLuckyColor:(NSString *)color number:(NSString *)number xingzuo:(NSString *)xingzuo;
- (void)exchangeIsHiden:(BOOL)isHiden;
@end
