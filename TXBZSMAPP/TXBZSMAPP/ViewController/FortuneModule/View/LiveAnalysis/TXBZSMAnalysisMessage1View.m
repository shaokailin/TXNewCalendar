//
//  TXBZSMAnalysisMessage1View.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMAnalysisMessage1View.h"

@implementation TXBZSMAnalysisMessage1View
{
    UILabel *_titleLbl;
    UILabel *_contentLbl;
    CGFloat _contentHeight;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTitle:(NSString *)title content:(NSString *)content {
    _titleLbl.text = NSStringFormat(@"喜用神·%@",title);
    _contentLbl.text = content;
    CGFloat height = [content calculateTextHeight:12 width:SCREEN_WIDTH - 20 - 10] + 3;
    _contentHeight = 31 + kLineView_Height + 15 + 10 + height;
}
- (CGFloat)returnMessageView {
    return _contentHeight;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 5.0);
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:14 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:1 backgroundColor:nil];
    _titleLbl.font = FontBoldInit(14);
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(31);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self->_titleLbl.mas_bottom);
        make.height.mas_equalTo(kLineView_Height);
    }];
    
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(lineView.mas_bottom).with.offset(15);
    }];
    
}
@end
