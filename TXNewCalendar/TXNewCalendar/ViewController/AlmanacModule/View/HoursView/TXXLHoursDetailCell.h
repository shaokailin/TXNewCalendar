//
//  TXXLHoursDetailCell.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLHoursDetailCell = @"TXXLHoursDetailCell";
@interface TXXLHoursDetailCell : UITableViewCell
- (void)setupCellContent:(NSString *)chinessHour state:(NSInteger)state timeBetween:(NSString *)timeBetween timeDetail:(NSString *)timeDetail orientation:(NSString *)orientation suit:(NSString *)suit avoid:(NSString *)avoid;
@end
