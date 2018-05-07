//
//  TXBZSMTomorrowDetailView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTomorrowDetailView.h"

@implementation TXBZSMTomorrowDetailView
{
    UILabel *_contentLbl;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        [self _layoutMainView:type];
    }
    return self;
}
- (void)setupContent:(NSString *)content {
    _contentLbl.text = content;
    CGFloat height = 37 + kLineView_Height + 30;
    CGRect frame = self.frame;
    height += [content calculateTextHeight:14 width:CGRectGetWidth(frame) - 30];
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)returnContentHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView:(NSInteger)type {
    self.backgroundColor = [UIColor whiteColor];
    UILabel *_titleLbl = [LSKViewFactory initializeLableWithText:type == 0?@"今日详解":@"明日详解" font:15 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _titleLbl.font = FontBoldInit(15);
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self);
        make.height.mas_equalTo(37);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_titleLbl.mas_bottom);
        make.height.mas_equalTo(kLineView_Height);
    }];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:14 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(lineView.mas_bottom).with.offset(10);
        make.right.equalTo(self).with.offset(-15);
        make.bottom.equalTo(self).with.offset(-10);
    }];
}
@end
