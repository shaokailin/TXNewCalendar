//
//  TXXLSearchDetailCell.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const  kTXXLSearchDetailCell = @"TXXLSearchDetailCell";
typedef void (^DetailAddTimeBlock)(id clickCell);
@interface TXXLSearchDetailCell : UITableViewCell
@property (nonatomic, copy) DetailAddTimeBlock timeBlock;
- (void)setupCellContentWithDay:(NSString *)day yearMonth:(NSString *)yearMonth nongli:(NSString *)nongli chinessYMD:(NSString *)chinessYMD week:(NSString *)week count:(NSString *)count god:(NSString *)god twelveGod:(NSString *)twelveGod constellation:(NSString *)constellation isHidenLine:(BOOL)isHiden;
@end
