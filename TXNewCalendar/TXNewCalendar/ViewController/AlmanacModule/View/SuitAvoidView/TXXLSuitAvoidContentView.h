//
//  TXXLSuitAvoidContentView.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLSuitAvoidContentView : UIView
@property (nonatomic, assign) CGFloat contentHeight;
- (instancetype)initWithHeaderType:(NSInteger)type;
- (void)setupContentWithDic:(NSDictionary *)contentDict;
- (void)setupContentArr:(NSArray *)array;
@end
