//
//  TXXLCalendarMessageView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLCalendarMessageView : UIView
- (void)setupContentWithDate:(NSDate *)date
                     xingzuo:(NSString *)xingzuo
                  suitAction:(NSString *)suitAction
                 avoidAction:(NSString *)avoidAction
                  dateDetail:(NSString *)dateDetail
                  alertFirst:(NSString *)alertFirst
                   alertLast:(NSString *)alertLast;
@end
