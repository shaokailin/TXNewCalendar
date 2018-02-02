//
//  TXXLSearchDetailVM.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLSearchDetailListModel.h"
@interface TXXLSearchDetailVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *text;
@property (nonatomic, assign) BOOL isShowWeenken;
@property (nonatomic, assign) BOOL isAvoid;
@property (nonatomic, copy) NSString *startTime;
@property (nonatomic, copy) NSString *endTime;
- (void)getSearchDetail:(BOOL)isPull;

@property (nonatomic, strong) TXXLSearchDetailListModel *detailModel;
@end
