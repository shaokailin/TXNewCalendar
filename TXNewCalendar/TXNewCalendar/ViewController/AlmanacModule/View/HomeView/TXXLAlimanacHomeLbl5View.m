//
//  TXXLAlimanacHomeLbl5View.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlimanacHomeLbl5View.h"

@implementation TXXLAlimanacHomeLbl5View
{
    UILabel *_topLbl;
    UILabel *_messageLbl;
    UILabel *_bottomLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupLblType5Content:(NSString *)title  {
    _topLbl.text = title;
}
- (void)setupMessage:(NSString *)message {
    if (KJudgeIsNullData(message)) {
        @autoreleasepool {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:2];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
            _messageLbl.attributedText = attributedString;
            _messageLbl.textAlignment = 1;
        }
    }
}
- (void)_layoutMainView {
    UILabel *topLbl = [TXXLViewManager customAppLbl:nil font:14];
    _topLbl = topLbl;
    [self addSubview:topLbl];
    WS(ws)
    [topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_top).with.offset(8);
        make.centerX.equalTo(ws);
    }];
    _messageLbl = [TXXLViewManager customDetailLbl:nil font:12];
    _messageLbl.numberOfLines = 2;
    _messageLbl.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_messageLbl];
    [_messageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(5);
        make.right.equalTo(ws).with.offset(-5);
        make.top.equalTo(topLbl.mas_bottom).with.offset(3);
        make.bottom.equalTo(ws).with.offset(-3);
    }];
}

@end
