//
//  TXSMMessageMoreImgCell.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMMessageMoreImgCell = @"TXSMMessageMoreImgCell";
@interface TXSMMessageMoreImgCell : UITableViewCell
- (void)setupCellContent:(NSString *)img img2:(NSString *)img2 img3:(NSString *)img3 title:(NSString *)title where:(NSString *)where count:(NSString *)count;
@end
