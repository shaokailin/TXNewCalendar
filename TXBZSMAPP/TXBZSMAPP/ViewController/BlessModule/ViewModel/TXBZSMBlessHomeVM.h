//
//  TXBZSMBlessHomeVM.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface TXBZSMBlessHomeVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *contactId;
@property (nonatomic, copy) NSString *limit;
- (void)getHomeData:(BOOL)isPull;
@end
