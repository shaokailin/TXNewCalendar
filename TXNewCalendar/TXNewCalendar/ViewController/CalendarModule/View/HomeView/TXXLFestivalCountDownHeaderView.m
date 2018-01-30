//
//  TXXLFestivalCountDownHeaderView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLFestivalCountDownHeaderView.h"

@implementation TXXLFestivalCountDownHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    WS(ws)
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(kLineView_Height);
    }];
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"节日倒数" font:17];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(15);
        make.top.equalTo(ws);
        make.bottom.equalTo(lineView.mas_top);
    }];
    
    UIButton *moreBtn = [LSKViewFactory initializeButtonWithTitle:@"更多" nornalImage:@"calendar_more" selectedImage:nil target:self action:@selector(moreClick) textfont:13 textColor:KColorHexadecimal(kText_Title_Color, 1.0) backgroundColor:nil backgroundImage:nil];
    moreBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 48, 0, 0);
    moreBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -15, 0, 0);
    moreBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self addSubview:moreBtn];
    [moreBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-10);
        make.top.bottom.equalTo(titleLbl);
        make.width.mas_equalTo(70);
    }];
    
}
- (void)moreClick {
    
}
@end
