//
//  TXSMMessageDetailVM.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/14.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewModel.h"

@interface TXSMMessageDetailVM : LSKBaseViewModel
@property (nonatomic, copy) NSString *article_id;
- (void)getDetailData:(BOOL)isPull;
@end
