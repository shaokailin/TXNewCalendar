//
//  TXSMDetailHeaderView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMDetailHeaderView.h"

@implementation TXSMDetailHeaderView
{
    UILabel *_titleLbl;
    UILabel *_dateAndFromLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupArticleTitle:(NSString *)title from:(NSString *)from date:(NSString *)date {
    _titleLbl.text = title;
    _dateAndFromLbl.text = NSStringFormat(@"%@        来源:  %@",date,from);
    CGFloat height = [title calculateTextHeight:19 width:SCREEN_WIDTH - 44];
    if (height > 45) {
        height = 45;
    }
    _contentHeight = height + 46;
}
- (void)_layoutMainView {
    self.backgroundColor = KColorHexadecimal(0xf5f5f5, 1.0);
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:19];
    _titleLbl.textAlignment = 1;
    _titleLbl.numberOfLines = 0;
    [self addSubview:_titleLbl];
    WS(ws)
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(22);
        make.right.equalTo(ws).with.offset(-22);
        make.top.equalTo(ws).with.offset(9);
    }];
    
    _dateAndFromLbl = [TXXLViewManager customDetailLbl:nil font:9];
    _dateAndFromLbl.textAlignment = 1;
    [self addSubview:_dateAndFromLbl];
    [_dateAndFromLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws).with.offset(-10);
        make.centerX.equalTo(ws);
    }];
    
    
}

@end
