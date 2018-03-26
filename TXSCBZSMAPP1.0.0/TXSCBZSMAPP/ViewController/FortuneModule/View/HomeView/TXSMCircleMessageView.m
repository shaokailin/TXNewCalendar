//
//  TXSMCircleMessageView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCircleMessageView.h"

@implementation TXSMCircleMessageView
{
    NSInteger _type;
    UILabel *_xingzuoNameLbl;
//    UILabel *_xingzuoTimeLbl;
}
- (instancetype)initWithType:(NSInteger)type{
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupMessageWithName:(NSString *)name time:(NSString *)time {
//    _xingzuoNameLbl.text = name;
//    _xingzuoTimeLbl.text = time;
}
- (void)_layoutMainView {
    self.backgroundColor = KColorHexadecimal(0xdfdfdf, 1.0);
    KViewRadius(self, 175 / 2.0);
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:_type == 0?@"今日运势":@"明日运势" font:18];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(35);
        make.centerX.equalTo(ws);
    }];
    UILabel *presentLbl = [LSKViewFactory initializeLableWithText:nil font:55 textColor:KColorHexadecimal(kNavi_Yellow_Color, 1.0) textAlignment:1 backgroundColor:nil];
    self.presentValueLbl = presentLbl;
    [self addSubview:presentLbl];
    [presentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(titleLbl.mas_bottom).with.offset(11);
        make.centerX.equalTo(ws);
        make.centerY.equalTo(ws).with.offset(10);
    }];
    
//    _xingzuoNameLbl = [TXXLViewManager customDetailLbl:nil font:12];
//    [self addSubview:_xingzuoNameLbl];
//    [_xingzuoNameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(presentLbl.mas_bottom).with.offset(15);
//        make.centerX.equalTo(ws);
//    }];
//    _xingzuoTimeLbl = [TXXLViewManager customDetailLbl:nil font:12];
//    [self addSubview:_xingzuoTimeLbl];
//    [_xingzuoTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(ws).with.offset(-24);
//        make.centerX.equalTo(ws);
//    }];
    
}

@end
