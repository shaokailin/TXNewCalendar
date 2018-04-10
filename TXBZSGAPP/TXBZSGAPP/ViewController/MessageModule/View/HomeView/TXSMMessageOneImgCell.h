//
//  TXSMMessageOneImgCell.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMMessageOneImgCell = @"TXSMMessageOneImgCell";
@interface TXSMMessageOneImgCell : UITableViewCell
- (void)setupCellContent:(NSString *)img title:(NSString *)title where:(NSString *)where count:(NSString *)count;
@end
