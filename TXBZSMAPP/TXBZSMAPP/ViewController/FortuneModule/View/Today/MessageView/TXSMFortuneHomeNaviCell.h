//
//  TXSMFortuneHomeNaviCell.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMFortuneHomeNaviCell = @"TXSMFortuneHomeNaviCell";
@interface TXSMFortuneHomeNaviCell : UITableViewCell
-(void)setupContentWithTitle:(NSString *)title isSeleted:(BOOL)isSeleted;
-(CGRect)getCellTitleFrame;
-(void)changeTitleAttribute:(CGFloat)rate;
@end
