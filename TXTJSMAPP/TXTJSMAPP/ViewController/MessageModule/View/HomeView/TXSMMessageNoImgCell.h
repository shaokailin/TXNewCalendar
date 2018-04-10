//
//  TXSMMessageNoImgCell.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * kTXSMMessageNoImgCell = @"TXSMMessageNoImgCell";
@interface TXSMMessageNoImgCell : UITableViewCell
- (void)setupCellContentTitle:(NSString *)title where:(NSString *)where count:(NSString *)count;
@end
