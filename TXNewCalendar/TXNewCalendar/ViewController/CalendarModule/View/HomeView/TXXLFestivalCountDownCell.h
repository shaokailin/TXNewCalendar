//
//  TXXLFestivalCountDownCell.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const  kTXXLFestivalCountDownCell = @"TXXLFestivalCountDownCell";
@interface TXXLFestivalCountDownCell : UITableViewCell
- (void)setupCellContentWithLeft:(NSString *)left right:(NSString *)right;
@end
