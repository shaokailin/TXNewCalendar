//
//  TXXLHourView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLHourView : UIView
@property (nonatomic, assign) BOOL isCurrent;
- (void)setupContentWithHour:(NSString *)hour state:(NSString *)state;
@end
