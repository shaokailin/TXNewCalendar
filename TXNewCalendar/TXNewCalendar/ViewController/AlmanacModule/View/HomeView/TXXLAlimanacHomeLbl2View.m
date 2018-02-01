//
//  TXXLAlimanacHomeLbl2View.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlimanacHomeLbl2View.h"

@implementation TXXLAlimanacHomeLbl2View
{
    UILabel *_topLbl;
    UILabel *_middleLbl;
    UILabel *_bottomLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupLblType2Content:(NSString *)title  {
    _topLbl.text = title;
}
- (void)setupMessage:(NSString *)middle bottom:(NSString *)bottom {
    _bottomLbl.text = bottom;
    _middleLbl.text = middle;
}
- (void)_layoutMainView {
    _topLbl = [TXXLViewManager customAppLbl:nil font:14];
    [self addSubview:_topLbl];
    WS(ws)
    UILabel *middleLbl = [TXXLViewManager customDetailLbl:nil font:10];
    _middleLbl = middleLbl;
    [self addSubview:middleLbl];
    [middleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.centerY.equalTo(ws).with.offset(2);
    }];
    [_topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(middleLbl.mas_top).with.offset(-3);
        make.centerX.equalTo(ws);
    }];
    _bottomLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self addSubview:_bottomLbl];
    [_bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(middleLbl.mas_bottom).with.offset(3);
        make.centerX.equalTo(ws);
    }];
}

@end
