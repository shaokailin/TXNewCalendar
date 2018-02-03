//
//  TXXLHolidaysTableViewCell.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLHolidaysTableViewCell = @"TXXLHolidaysTableViewCell";
@interface TXXLHolidaysTableViewCell : UITableViewCell
- (void)setupCellContent:(NSString *)title monthDay:(NSString *)monthDay date:(NSString *)chinessDate week:(NSString *)week hasCount:(NSString *)hasCount;
@end
