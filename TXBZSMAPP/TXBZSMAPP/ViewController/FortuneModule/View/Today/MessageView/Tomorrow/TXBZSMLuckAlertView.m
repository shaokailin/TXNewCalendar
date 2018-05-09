//
//  TXBZSMLuckAlertView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMLuckAlertView.h"

@implementation TXBZSMLuckAlertView
{
    NSInteger _type;
    UILabel *_titleLbl;
    UILabel *_detailLbl;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithTitle:(NSString *)title detail:(NSString *)detail {
    _titleLbl.text = [self returnTitle:title];
    _detailLbl.text = detail;
    CGRect frame = self.frame;
    CGFloat contentHeight = 50 + 15;
    CGFloat textHeight = [detail calculateTextHeight:12 width:CGRectGetWidth(frame) - 121 - 15 - 10];
    contentHeight += textHeight;
    if (contentHeight < 95) {
        contentHeight = 95;
    }
    frame.size.height = contentHeight;
    self.frame = frame;
}
- (CGFloat)returnContentHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImage = [[UIImageView alloc]initWithImage:ImageNameInit([self returnImage])];
    iconImage.contentMode = UIViewContentModeCenter;
    [self addSubview:iconImage];
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).with.offset(5);
        make.bottom.equalTo(self).with.offset(-5);
        make.width.mas_equalTo(116);
    }];
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:15 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right);
        make.top.equalTo(self).with.offset(14);
    }];
    _detailLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _detailLbl.numberOfLines = 0;
    [self addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right);
        make.top.equalTo(self->_titleLbl.mas_bottom).with.offset(16);
        make.bottom.equalTo(self).with.offset(-15);
        make.right.equalTo(self).with.offset(-15);
    }];
}
- (NSString *)returnImage {
    NSString *image = nil;
    switch (_type) {
        case 0:
            image = @"luckycolor_icon";
            break;
        case 1:
            image = @"luckymoney_icon";
            break;
        case 2:
            image = @"luckylove_icon";
            break;
            
        default:
            break;
    }
    return image;
}
- (NSString *)returnTitle:(NSString *)title {
    NSString *image = nil;
    switch (_type) {
        case 0:
            image = NSStringFormat(@"吉祥色：%@",title);
            break;
        case 1:
            image = NSStringFormat(@"转运财位：%@",title);
            break;
        case 2:
            image = NSStringFormat(@"桃花位：%@",title);
            break;
            
        default:
            break;
    }
    return image;
}
@end
