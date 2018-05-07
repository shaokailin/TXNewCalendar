//
//  TXBZSMTodayFortuneVC.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^DataRefreshBlock)(NSDictionary *data);
@interface TXBZSMTodayFortuneVC : LSKBaseViewController
@property (nonatomic, copy) DataRefreshBlock refreshBlock;
@property (nonatomic, copy) NSDictionary *dataDictionary;
@property (nonatomic, copy) NSString *xingzuo;
@end
