//
//  TXSMWeekFortuneMessageView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXSMWeekFortuneMessageView : UIView
- (instancetype)initWithType:(NSInteger)type;
- (void)setupContentWithImg:(NSString *)image name:(NSString *)name time:(NSString *)time;
@end
