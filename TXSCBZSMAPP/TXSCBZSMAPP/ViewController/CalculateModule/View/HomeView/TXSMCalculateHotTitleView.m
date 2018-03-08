//
//  TXSMCalculateHotTitleView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCalculateHotTitleView.h"

@implementation TXSMCalculateHotTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIButton *titleBtn = [LSKViewFactory initializeButtonWithTitle:@"热门资讯" target:nil action:nil textfont:14 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    KViewBorderLayer(titleBtn, KColorHexadecimal(kText_Title_Color, 1.0), 0.5);
    [self addSubview:titleBtn];
    WS(ws)
    [titleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(426 / 2.0, 35));
    }];
}
@end
