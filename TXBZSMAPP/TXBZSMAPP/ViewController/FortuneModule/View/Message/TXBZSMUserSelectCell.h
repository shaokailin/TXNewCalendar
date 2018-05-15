//
//  TXBZSMUserSelectCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXBZSMUserSelectCell = @"TXBZSMUserSelectCell";
@interface TXBZSMUserSelectCell : UITableViewCell
- (void)setupCellContentWithTitle:(NSString *)title detail:(NSString *)detail;
@end
