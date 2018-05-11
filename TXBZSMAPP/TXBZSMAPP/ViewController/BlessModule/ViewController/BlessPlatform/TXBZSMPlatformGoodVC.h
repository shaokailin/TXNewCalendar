//
//  TXBZSMPlatformGoodView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/11.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
typedef void (^GoodsSelectBlock)(PlatformGoodsType type, NSString *image);
@interface TXBZSMPlatformGoodVC : LSKBaseViewController
@property (nonatomic, copy) GoodsSelectBlock selectBlock;
@property (nonatomic, assign) PlatformGoodsType goodsType;
@property (nonatomic, strong) UIImage *bgImageView;
@end
