//
//  TXXLSolarTermsCell.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLSolarTermsCell = @"TXXLSolarTermsCell";
@interface TXXLSolarTermsCell : UICollectionViewCell
- (void)setupCellContentWithIcon:(NSString *)icon title:(NSString *)title time:(NSString *)time;
@end
