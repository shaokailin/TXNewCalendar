//
//  TXBZSMWeekDetailView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXBZSMWeekDetailView : UIView
- (instancetype)initWithType:(NSInteger)type;
- (void)setupContent:(NSString *)content;
- (CGFloat)returnContentHeight;
@end
