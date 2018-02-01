//
//  TXXLAlimanacHomeLbl2View.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLAlimanacHomeLbl2View : UIView
@property (nonatomic, copy) ShowTodayDetailBlock detailBlock;
- (void)setupLblType2Content:(NSString *)title ;
- (void)setupMessage:(NSString *)middle bottom:(NSString *)bottom;
@end
