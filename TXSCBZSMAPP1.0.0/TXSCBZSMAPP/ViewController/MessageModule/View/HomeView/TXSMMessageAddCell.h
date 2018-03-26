//
//  TXSMMessageAddCell.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMMessageAddCell = @"TXSMMessageAddCell";
@interface TXSMMessageAddCell : UITableViewCell
- (void)setupCellContent:(NSString *)img title:(NSString *)title where:(NSString *)where;
@end
