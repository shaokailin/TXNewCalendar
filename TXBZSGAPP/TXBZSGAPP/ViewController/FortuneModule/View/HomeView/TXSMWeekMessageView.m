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
    CGFloat height = 28;
    CGFloat contentHeight = [_contentLbl.text calculateTextHeight:13 width:CGRectGetWidth(self.frame) - 110];
    height += contentHeight;
    if (height < 112) {
        height = 112;
    }
    return height;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *iconImg = [[UIImageView alloc]initWithImage:ImageNameInit([self returnImage])];
    iconImg.contentMode = UIViewContentModeBottom;
    [self addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(21);
        make.left.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(90, 32));
    }];
    
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:[self returnText] font:15];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).with.offset(8);
        make.centerX.equalTo(iconImg);
    }];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:13 textColor:KColorHexadecimal(0x7f7f7f, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImg.mas_right).with.offset(0);
        make.right.equalTo(self).with.offset(-20);
        make.top.equalTo(self).with.offset(14);
        make.bottom.equalTo(self).with.offset(-14);
    }];
}
- (NSString *)returnText {
    NSString *titleString = nil;
    switch (_type) {
        case 0:
            titleString = @"爱情";
            break;
        case 1:
            titleString = @"财运";
            break;
        case 2:
            titleString = @"工作";
            break;
        case 3:
            titleString = @"健康";
            break;
        default:
            break;
    }
    return titleString;
}
- (NSString *)returnImage {
    NSString *imageString = nil;
    switch (_type) {
        case 0:
            imageString = @"love_icon";
            break;
        case 1:
            imageString = @"fortune_icon";
            break;
        case 2:
            imageString = @"work_icon";
            break;
        case 3:
            imageString = @"health_icon";
            break;
        default:
            break;
    }
    return imageString;
}
@end
