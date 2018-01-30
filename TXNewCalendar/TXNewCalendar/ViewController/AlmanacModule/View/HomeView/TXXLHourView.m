//
//  TXXLHourView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHourView.h"

@implementation TXXLHourView
{
    UILabel *_timeLbl;
    UILabel *_stateLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithHour:(NSString *)hour state:(NSString *)state {
    _timeLbl.text = hour;
    _stateLbl.text = state;
}
- (void)setIsCurrent:(BOOL)isCurrent {
    if (_isCurrent != isCurrent) {
        _isCurrent = isCurrent;
        [self changeTextColor:KColorHexadecimal((isCurrent ? kAPP_Main_Color:kText_Title_Color), 1.0)];
    }
}
- (void)changeTextColor:(UIColor *)color {
    _timeLbl.textColor = color;
    _stateLbl.textColor = color;
}
- (void)_layoutMainView {
    _timeLbl = [TXXLViewManager customTitleLbl:nil font:11];
    _timeLbl.numberOfLines = 2;
    [self addSubview:_timeLbl];
    WS(ws)
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(ws).with.offset(14);
    }];
    
    _stateLbl = [TXXLViewManager customTitleLbl:nil font:11];
    [self addSubview:_stateLbl];
    [_stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.bottom.equalTo(ws).with.offset(-12);
    }];
    
}
@end
