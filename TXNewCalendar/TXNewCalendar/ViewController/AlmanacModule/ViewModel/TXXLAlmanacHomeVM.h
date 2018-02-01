//
//  TXXLAlmanacHomeVM.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXXLAlmanacHomeModel.h"
@interface TXXLAlmanacHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *dateString;
@property (nonatomic, strong) TXXLAlmanacHomeModel *messageModel;
- (void)getAlmanacHomeData:(BOOL)isFirst;
@end
