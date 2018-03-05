//
//  TXXLAlimanacHoursView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HoursBlock)(NSInteger type);
@interface TXXLAlmanacHoursView : UIView
@property (nonatomic, copy) HoursBlock clickBlock;
- (void)setupContentWithHours;
- (void)currentHourChange:(NSInteger)hour;
@end
