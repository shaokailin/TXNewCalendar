//
//  TXSMTodayFortuneDetailView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMTodayFortuneDetailView.h"

@implementation TXSMTodayFortuneDetailView
{
    NSInteger _type;
    UILabel *_contentLbl;
}
- (instancetype)initType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)content {
    _contentLbl.text = content;
    CGFloat height = 45 + 20;
    if (KJudgeIsNullData(content)) {
        CGFloat contentHeight = [content calculateTextHeight:12 width:SCREEN_WIDTH - 10 - 74];
        height += contentHeight;
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
    }
}
- (CGFloat)returnMessageHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 4.0);
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:_type == 0?@"今日详情":@"明日详情" font:12];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(16);
        make.centerX.equalTo(ws);
    }];
    UIView *leftLine  = [LSKViewFactory initializeLineView];
    [self addSubview:leftLine];
    [leftLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(titleLbl.mas_left).with.offset(-12);
        make.size.mas_equalTo(CGSizeMake(75, kLineView_Height));
        make.centerY.equalTo(titleLbl);
    }];
    
    UIView *rightLine  = [LSKViewFactory initializeLineView];
    [self addSubview:rightLine];
    [rightLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(75, kLineView_Height));
        make.centerY.equalTo(titleLbl);
    }];
    
    _contentLbl = [TXXLViewManager customTitleLbl:nil font:12];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(37);
        make.right.equalTo(ws).with.offset(-37);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(14);
    }];
}


@end
