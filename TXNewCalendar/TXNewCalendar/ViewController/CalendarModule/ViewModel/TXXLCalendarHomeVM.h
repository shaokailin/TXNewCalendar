//
//  TXXLCalendarHomeVM.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLFestivalsListModel.h"
@interface TXXLCalendarHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *time;
@property (nonatomic, strong) NSArray *festivalsList;
- (void)getFestivalsList;
@end
