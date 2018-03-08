//
//  TXSMHomeHotNewsCell.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMHomeHotNewsCell = @"TXSMHomeHotNewsCell";
@interface TXSMHomeHotNewsCell : UITableViewCell
- (void)setupCellContent:(NSString *)image title:(NSString *)title detail:(NSString *)detail;
@end
