//
//  TXBZSMNameInputCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXBZSMNameInputCell = @"TXBZSMNameInputCell";
typedef void (^NameChangeBlock) (NSString *name);
@interface TXBZSMNameInputCell : UITableViewCell
@property (nonatomic, copy) NameChangeBlock nameBlock;
- (void)setupCellContentWithName:(NSString *)name;
@end
