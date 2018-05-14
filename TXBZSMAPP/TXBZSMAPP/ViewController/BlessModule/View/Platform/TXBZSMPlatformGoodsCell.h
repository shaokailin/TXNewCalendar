//
//  TXBZSMPlatformGoodsCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PlatformSelectBlock)(NSInteger index, id clickCell);
static NSString * const kTXBZSMPlatformGoodsCell = @"TXBZSMPlatformGoodsCell";
@interface TXBZSMPlatformGoodsCell : UITableViewCell
@property (nonatomic, copy) PlatformSelectBlock selectBlock;
- (void)setupCellType:(NSInteger)type;
- (void)setupContentWithFirst:(NSDictionary *)first second:(NSDictionary *)second third:(NSDictionary *)third;
@end
