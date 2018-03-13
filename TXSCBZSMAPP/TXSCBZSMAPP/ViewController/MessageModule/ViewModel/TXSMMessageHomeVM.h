//
//  TXSMMessageHomeVM.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"
#import "TXSMMessageListModel.h"
@interface TXSMMessageHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, strong) NSDictionary *adDict;
- (void)getHomeData:(BOOL)isPull;
@end
