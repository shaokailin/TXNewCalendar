//
//  TXSMMessageHomeNaviCell.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/6.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMMessageHomeNaviCell = @"TXSMMessageHomeNaviCell";
@interface TXSMMessageHomeNaviCell : UITableViewCell
-(void)setupContentWithTitle:(NSString *)title isSeleted:(BOOL)isSeleted;
-(void)changeTitleAttribute:(CGFloat)rate;
-(CGRect)getCellTitleFrame;
@end
