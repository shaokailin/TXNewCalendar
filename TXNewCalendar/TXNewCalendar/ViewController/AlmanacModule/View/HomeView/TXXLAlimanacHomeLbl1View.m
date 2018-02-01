//
//  TXXLAlimanacHomeLbl1View.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlimanacHomeLbl1View.h"

@implementation TXXLAlimanacHomeLbl1View
{
    UILabel *_topLbl;
    UILabel *_bottomLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupLblType1Content:(NSString *)title {
    _topLbl.text = title;
    
}
- (void)setupMessage:(NSString *)message {
    _bottomLbl.text = message;
}
- (void)_layoutMainView {
    _topLbl = [TXXLViewManager customAppLbl:nil font:14];
    [self addSubview:_topLbl];
    WS(ws)
    [_topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(8);
        make.centerX.equalTo(ws);
    }];
    _bottomLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self addSubview:_bottomLbl];
    [_bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
       make.bottom.equalTo(ws).with.offset(-4);
        make.centerX.equalTo(ws);
    }];
    
}

@end
