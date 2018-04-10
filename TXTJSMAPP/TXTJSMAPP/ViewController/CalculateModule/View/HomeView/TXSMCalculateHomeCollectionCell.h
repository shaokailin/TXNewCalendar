//
//  TXSMCalculateHomeCollectionCell.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXSMCalculateHomeCollectionCell = @"TXSMCalculateHomeCollectionCell";
@interface TXSMCalculateHomeCollectionCell : UICollectionViewCell
- (void)setupCellContentWithImg:(NSString *)img title:(NSString *)title;
@end
