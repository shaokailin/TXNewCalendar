//
//  TXSMFortuneHomeVM.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface TXSMFortuneHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, copy) NSString *xingzuo;
@property (nonatomic, copy) NSString *cXingzuo;
- (void)getHomeData:(BOOL)isPull;
@end
