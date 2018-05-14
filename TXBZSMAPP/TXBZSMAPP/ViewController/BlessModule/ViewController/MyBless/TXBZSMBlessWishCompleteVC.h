//
//  TXBZSMBlessWishCompleteVC.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"

@interface TXBZSMBlessWishCompleteVC : LSKBaseViewController
@property (nonatomic, weak) TXBZSMGodMessageModel *model;
@property (nonatomic, copy) WishCompleteBlock block;
@property (nonatomic, assign) NSInteger index;
@end
