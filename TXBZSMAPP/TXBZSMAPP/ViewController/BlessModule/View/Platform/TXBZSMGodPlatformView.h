//
//  TXBZSMGodPlatformView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PlatformActionBlock)(PlatformGoodsType selectType);
@interface TXBZSMGodPlatformView : UIView
@property (nonatomic, assign, getter=isAllPull) BOOL isAll;
@property (nonatomic, copy) PlatformActionBlock block;
- (void)setupContent:(NSString *)img type:(PlatformGoodsType)type;
- (void)setupContentWithModel:(TXBZSMGodMessageModel *)model;
@end
