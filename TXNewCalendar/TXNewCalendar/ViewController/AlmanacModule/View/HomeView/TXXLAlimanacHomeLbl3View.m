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
    UILabel *_contentLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupLblType3Content:(NSString *)title  {
    _topLbl.text = title;
}
- (void)setupMessage:(NSString *)message {
    if (KJudgeIsNullData(message)) {
        @autoreleasepool {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:message];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [message length])];
            _contentLbl.attributedText = attributedString;
            _contentLbl.textAlignment = 1;
        }
    }
}
- (void)_layoutMainView {
    UILabel *topLbl = [TXXLViewManager customAppLbl:nil font:14];
    _topLbl = topLbl;
    [self addSubview:topLbl];
    WS(ws)
    [topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(12);
        make.centerX.equalTo(ws);
    }];
    _contentLbl = [TXXLViewManager customDetailLbl:nil font:10];
    _contentLbl.textAlignment = 1;
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(8);
        make.right.equalTo(ws).with.offset(-8);
        make.top.equalTo(topLbl.mas_bottom).with.offset(2);
        make.bottom.lessThanOrEqualTo(ws).with.offset(-8);
    }];
}

@end
