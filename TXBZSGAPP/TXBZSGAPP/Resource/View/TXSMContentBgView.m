//
//  TXSMContentBgView.m
//  TXBZSGAPP
//
//  Created by shaokai lin on 2018/4/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMContentBgView.h"

@implementation TXSMContentBgView

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        [self _latoutMainView:type];
    }
    return self;
}
- (void)_latoutMainView:(NSInteger)type {
    NSString *imageString = @"bgtop";
    CGFloat height = 227.0;
    if (type == 0) {
        imageString = @"yellowtopBg";
        height = 228.0;
    }
    UIImageView *topView = [[UIImageView alloc]initWithImage:ImageNameInit(imageString)];
    [self addSubview:topView];
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(topView.mas_width).multipliedBy(height / 750);
    }];
    UIImageView *bottonView = [[UIImageView alloc]initWithImage:ImageNameInit(@"bgbotton")];
    [self addSubview:bottonView];
    [bottonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(topView.mas_bottom);
    }];
}
@end
