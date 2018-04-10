//
//  TXSMDetailBottonView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMDetailBottonView.h"

@implementation TXSMDetailBottonView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)leftClick:(UIButton *)btn {
    if (self.loadBlock) {
        self.loadBlock(btn.tag - 100);
    }
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [LSKViewFactory initializeButtonNornalImage:@"left_icon" selectedImage:nil target:self action:@selector(leftClick:)];
    leftBtn.tag = 100;
    [self addSubview:leftBtn];
    WS(ws)
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(50);
        make.top.bottom.equalTo(ws);
        make.width.mas_equalTo(50);
    }];
    
    UIButton *rightBtn = [LSKViewFactory initializeButtonNornalImage:@"right_icon" selectedImage:nil target:self action:@selector(leftClick:)];
    rightBtn.tag = 101;
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-50);
        make.top.bottom.equalTo(ws);
        make.width.mas_equalTo(50);
    }];
}
@end
