//
//  TXBZSMTomorrowDetailView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXBZSMTomorrowDetailView : UIView
- (instancetype)initWithType:(NSInteger)type;
- (CGFloat)returnContentHeight;
- (void)setupContent:(NSString *)content;
@end
