//
//  TXBZSMWeekDetailView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWeekDetailView.h"

@implementation TXBZSMWeekDetailView
{
    NSInteger _type;
    UILabel *_contentLbl;
    CGFloat _contentHeight;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)content {
    _contentLbl.text = content;
    CGFloat height = [content calculateTextHeight:12 width:SCREEN_WIDTH - 10 - 16] + 5;
    _contentHeight = 31 + kLineView_Height + height + 24;
}
- (CGFloat)returnContentHeight {
    return _contentHeight;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 5.0);
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:[self returnTitle] font:14 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    titleLbl.font = FontBoldInit(14);
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(5);
        make.left.equalTo(self).with.offset(25);
        make.height.mas_equalTo(26);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(8);
        make.top.equalTo(titleLbl.mas_bottom);
        make.right.equalTo(self).with.offset(-8);
        make.height.mas_equalTo(kLineView_Height);
    }];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(lineView);
        make.top.equalTo(lineView.mas_bottom).with.offset(12);
        make.bottom.equalTo(self).with.offset(-12);
    }];
}
- (NSString *)returnTitle {
    NSString *title = @"";
    switch (_type) {
        case 0:
            title = @"工作";
            break;
        case 1:
            title = @"爱情";
            break;
        case 2:
            title = @"财运";
            break;
        case 3:
            title = @"健康";
            break;
        default:
            break;
    }
    return title;
}
@end
