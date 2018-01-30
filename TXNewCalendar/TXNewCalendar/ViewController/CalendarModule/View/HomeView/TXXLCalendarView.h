//
//  TXXLCalendarView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CalendarFrameBlock)(CGFloat oldHeight,CGFloat currentHeight);
typedef void (^CalendarDateBlock)(NSDate *selectDate);
@interface TXXLCalendarView : UIView
@property (nonatomic, copy) CalendarDateBlock dateBlock;
@property (nonatomic, copy) CalendarFrameBlock frameBlock;
- (void)selectDate:(NSDate *)date;
@end
