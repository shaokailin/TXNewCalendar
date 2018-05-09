//
//  TXBZSMBlessHomeBgView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeBgView.h"

@implementation TXBZSMBlessHomeBgView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"blessbg")];
    bgImage.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UIImageView *bgImage1 = [[UIImageView alloc]initWithImage:ImageNameInit(@"blessbg1")];
    bgImage1.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImage1];
    [bgImage1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(224);
    }];
}

@end
