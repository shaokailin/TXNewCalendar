//
//  TXBZSMFortuneHomeVM.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface TXBZSMFortuneHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy) NSString *limit;
@property (nonatomic, assign) BOOL isLoadingAd;
@property (nonatomic, copy) NSString *xingzuo;
- (void)getHomeData:(BOOL)isPull;
- (void)getAdData:(BOOL)isPull;
@end
