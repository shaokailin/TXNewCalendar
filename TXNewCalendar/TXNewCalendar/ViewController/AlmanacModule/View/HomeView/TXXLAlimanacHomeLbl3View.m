//
//  TXXLAlimanacHomeLbl3View.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlimanacHomeLbl3View.h"

@implementation TXXLAlimanacHomeLbl3View
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
- (void)setupLblType3Content:(NSString *)top middle:(NSString *)middle bottom:(NSString *)bottom {
    _topLbl.text = top;
    _bottomLbl.text = bottom;
    _middleLbl.text = middle;
}
- (void)_layoutMainView {
    _topLbl = [TXXLViewManager customAppLbl:nil font:14];
    [self addSubview:_topLbl];
    WS(ws)
    _middleLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self addSubview:_middleLbl];
    [_middleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(ws.mas_centerY).with.offset(-2);
    }];
    [_topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(12);
        make.centerX.equalTo(ws);
    }];
    _bottomLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self addSubview:_bottomLbl];
    [_bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).with.offset(-10);
        make.centerX.equalTo(ws);
    }];
}

@end
