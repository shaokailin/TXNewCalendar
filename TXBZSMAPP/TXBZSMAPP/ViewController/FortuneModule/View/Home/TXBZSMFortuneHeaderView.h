//
//  TXBZSMFortuneHeaderView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
// type = 1: 命盘  2：运势  3：热门  4.祈福
typedef void (^HeaderEventBlock)(NSInteger type);
@interface TXBZSMFortuneHeaderView : UIView
@property (nonatomic, copy) HeaderEventBlock eventBlock;
- (void)setupTodayData:(NSDictionary *)dict;
- (void)setupHotData:(NSArray *)array;
@end
