//
//  TXBZSMFortuneHomeCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXBZSMFortuneHomeCell = @"TXBZSMFortuneHomeCell";
@interface TXBZSMFortuneHomeCell : UITableViewCell
- (void)setupCellContent:(NSString *)title img:(NSString *)img;
@end
