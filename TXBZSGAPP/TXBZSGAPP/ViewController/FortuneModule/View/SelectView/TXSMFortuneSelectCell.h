//
//  TXSMFortuneSelectCell.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMFortuneSelectCell = @"TXSMFortuneSelectCell";
@interface TXSMFortuneSelectCell : UICollectionViewCell
- (void)setupCellContent:(NSString *)name img:(NSString *)img time:(NSString *)time ;
@end
