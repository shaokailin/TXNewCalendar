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
- (void)_layoutMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"navigationbg")];
    [self addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"运势" font:kNavigationTitle_Font textColor:KColorUtilsString(kNavigationTitle_Color) textAlignment:1 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
}
@end
