//
//  TXXLAlimanacHomeLbl4View.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlimanacHomeLbl4View.h"

@implementation TXXLAlimanacHomeLbl4View
{
    UILabel *_contentLbl;
}
- (instancetype)initWithType:(ContentType)type {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView:type];
    }
    return self;
}
- (void)setupLblType4Content:(NSString *)content {
    if (KJudgeIsNullData(content)) {
        @autoreleasepool {
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:content];
            NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
            [paragraphStyle setLineSpacing:3];
            [paragraphStyle setAlignment:NSTextAlignmentCenter];//设置对齐方式
            [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
            [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [content length])];
            _contentLbl.attributedText = attributedString;
        }
    }
}
- (void)_layoutMainView:(ContentType)type {
    UILabel *iconLbl = [LSKViewFactory initializeLableWithText:type == ContentType_Fit?@"宜":@"忌" font:WIDTH_RACE_6S(16) textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:type == ContentType_Fit ? KColorHexadecimal(kText_LightGreen_Color, 1.0):KColorHexadecimal(kAPP_Main_Color, 1.0)];
    KViewBoundsRadius(iconLbl, WIDTH_RACE_6S(15));
    [self addSubview:iconLbl];
    WS(ws)
    [iconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(30), WIDTH_RACE_6S(30)));
        make.left.equalTo(ws).with.offset(10);
    }];
    
    _contentLbl = [TXXLViewManager customTitleLbl:nil font:10];
    _contentLbl.numberOfLines = 2;
//    _contentLbl.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconLbl.mas_right).with.offset(5);
        make.centerY.equalTo(iconLbl).with.offset(1);
        make.right.lessThanOrEqualTo(ws).with.offset(-5);
    }];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetail)];
    [self addGestureRecognizer:tap];
}
- (void)showDetail {
    if (self.detailBlock) {
        self.detailBlock(YES);
    }
}
@end
