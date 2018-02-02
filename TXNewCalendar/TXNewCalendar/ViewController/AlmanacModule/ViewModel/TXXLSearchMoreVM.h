//
//  TXXLSearchMoreVM.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLSearchMoreListModel.h"
@interface TXXLSearchMoreVM : LSKBaseViewModel
@property (nonatomic, assign) BOOL isAvoid;
- (void)getSearchMoreList:(BOOL)isPull;
@end
