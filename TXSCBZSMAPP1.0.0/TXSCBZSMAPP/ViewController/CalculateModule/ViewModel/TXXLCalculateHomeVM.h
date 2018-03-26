//
//  TXXLCalculateHomeVM.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLCalculateHomeModel.h"
@interface TXXLCalculateHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy) NSString *limit;
- (void)getHomeData:(BOOL)isPull;
@end
