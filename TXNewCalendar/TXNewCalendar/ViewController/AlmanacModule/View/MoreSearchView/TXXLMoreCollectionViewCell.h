//
//  TXXLMoreCollectionViewCell.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLMoreCollectionViewCell = @"TXXLMoreCollectionViewCell";
@interface TXXLMoreCollectionViewCell : UICollectionViewCell
- (void)setupContentWithTitle:(NSString *)title;
- (NSString *)returnTitleString;
- (void)changeSelectState:(BOOL)isSelect;
@end
