//
//  TXXLNavigationRightView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CalendarTimeSelectBlock)(BOOL isSelect);
@interface TXXLNavigationRightView : UIView
@property (nonatomic, copy) CalendarTimeSelectBlock selectBlock;
- (void)changeTextWithDate:(NSDate *)date;
@end
