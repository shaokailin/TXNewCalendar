//
//  TXBZSMMyBlessCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TXBZSMMyBlessCell;
typedef void (^BlessBlock)(NSInteger type,id clickCell);
static NSString * const kTXBZSMMyBlessCell = @"TXBZSMMyBlessCell";
@interface TXBZSMMyBlessCell : UITableViewCell
@property (nonatomic, copy) BlessBlock block;
@end
