//
//  TXXLAlmanacDetailVM.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLAlmanacDetailModel.h"
@interface TXXLAlmanacDetailVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *dateString;
- (void)getAlmanacDetailData:(BOOL)isPull;
@end
