//
//  TXBZSMNavigationView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMNavigationView.h"

@implementation TXBZSMNavigationView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)jumpMeVC {
    if (self.block) {
        self.block(0);
    }
}
- (void)_layoutMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"navigationbg")];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UIButton *meBtn = [LSKViewFactory initializeButtonWithTitle:@"我的" target:self action:@selector(jumpMeVC) textfont:15 textColor:[UIColor whiteColor]];
    [self addSubview:meBtn];
    [meBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"运势" font:kNavigationTitle_Font textColor:KColorUtilsString(kNavigationTitle_Color) textAlignment:1 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}
@end
