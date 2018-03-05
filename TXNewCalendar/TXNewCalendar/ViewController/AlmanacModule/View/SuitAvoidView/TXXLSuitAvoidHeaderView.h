//
//  TXXLSuitAvoidHeaderView.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLSuitAvoidHeaderView : UIView
@property (nonatomic, assign) CGFloat contentHeight;
- (instancetype)initWithHeaderType:(NSInteger)type;
- (void)setupContent:(NSArray *)contentDict;
@end
