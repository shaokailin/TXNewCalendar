//
//  TXXLHolidaysHeaderView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHolidaysHeaderView.h"

@implementation TXXLHolidaysHeaderView
{
    UILabel *_titleLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupTitle:(NSString *)title {
    _titleLbl.text = title;
}
- (void)_layoutMainView {
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:12];
    [self addSubview:_titleLbl];
    WS(ws)
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.centerY.equalTo(ws);
    }];
}
@end
