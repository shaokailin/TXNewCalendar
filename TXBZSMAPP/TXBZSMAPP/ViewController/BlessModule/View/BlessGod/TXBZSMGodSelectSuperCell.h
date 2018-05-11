//
//  TXBZSMGodSelectSuperCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^GodSelectBlock)(NSInteger flag,id clickCell);
@interface TXBZSMGodSelectSuperCell : UITableViewCell
@property (nonatomic, copy) GodSelectBlock block;
- (void)setupContentWithFirst:(NSDictionary *)first second:(NSDictionary *)second third:(NSDictionary *)third;
@end
