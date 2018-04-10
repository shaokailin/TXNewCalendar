//
//  TXSMWeekMessageView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSMWeekMessageView : UIView
- (instancetype)initWithType:(NSInteger)type;
- (void)setupContent:(NSString *)content;
- (CGFloat)returnMessageHeight;
@end
