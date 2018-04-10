//
//  TXSMWeekMessageView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekMessageView.h"

@implementation TXSMWeekMessageView
{
    NSInteger _type;
    UILabel *_contentLbl;
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
    
}
- (CGFloat)returnMessageHeight {
    CGFloat height = 16 + 3 + 38;
    LSKLog(@"%@",_contentLbl.text);
    CGFloat contentHeight = [_contentLbl.text calculateTextHeight:14 width:CGRectGetWidth(self.frame) - 20];
    height += contentHeight;
    return height;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 10.0);
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:[self returnText] font:17];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(38);
    }];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:14 textColor:KColorHexadecimal(0x7f7f7f, 1.0) textAlignment:1 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(3);
    }];
}
- (NSString *)returnText {
    NSString *titleString = nil;
    switch (_type) {
        case 0:
            titleString = @"爱情";
            break;
        case 1:
            titleString = @"工作";
            break;
        case 2:
            titleString = @"学习";
            break;
        case 3:
            titleString = @"财运";
            break;
        case 4:
            titleString = @"健康";
            break;
        case 5:
            titleString = @"指南";
            break;
        default:
            break;
    }
    return titleString;
}
@end
