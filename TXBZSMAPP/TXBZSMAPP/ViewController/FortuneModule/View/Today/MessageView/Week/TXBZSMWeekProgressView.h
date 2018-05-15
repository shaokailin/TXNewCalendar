//
//  TXBZSMWeekProgressView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXBZSMWeekProgressView : UIView
- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type;
- (void)setupScore:(NSDictionary *)dict;
@end
