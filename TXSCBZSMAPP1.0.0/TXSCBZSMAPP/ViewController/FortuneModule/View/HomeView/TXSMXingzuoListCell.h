//
//  TXSMXingzuoListCell.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/16.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMXingzuoListCell = @"TXSMXingzuoListCell";
@interface TXSMXingzuoListCell : UITableViewCell
- (void)setupCellContent:(NSString *)img title:(NSString *)title time:(NSString *)time;
@end
