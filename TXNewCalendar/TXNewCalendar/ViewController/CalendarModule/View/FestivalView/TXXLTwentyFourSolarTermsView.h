//
//  TXXLTwentyFourSolarTermsView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXXLFestivalsProtocol.h"
@interface TXXLTwentyFourSolarTermsView : UIView<TXXLFestivalsProtocol>
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, copy) LoadFestivalsBlock loadBlock;
@end
