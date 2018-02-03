//
//  TXXLSolarTermAndFestivalVM.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface TXXLSolarTermAndFestivalVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *time;
@property (nonatomic, assign) NSInteger type;//0:大众节气 1.二十四节气 2.节假日
- (void)getSolarTermAndFestivalList:(BOOL)isPull;
@end
