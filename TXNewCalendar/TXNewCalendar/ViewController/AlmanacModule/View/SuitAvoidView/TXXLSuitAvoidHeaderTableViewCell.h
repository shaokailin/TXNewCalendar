//
//  TXXLSuitAvoidHeaderTableViewCell.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLSuitAvoidHeaderTableViewCell = @"TXXLSuitAvoidHeaderTableViewCell";
@interface TXXLSuitAvoidHeaderTableViewCell : UITableViewCell
- (void)setupContentWithType:(NSInteger)type setupContent:(NSArray *)content;
@end
