//
//  TXBZSMTodayNavigationView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTodayNavigationView.h"

@implementation TXBZSMTodayNavigationView
{
    UIButton *_backBtn;
    UIButton *_shareBtn;
    UILabel *_titleLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _backBtn = [LSKViewFactory initializeButtonNornalImage:@"whiteback_icon" selectedImage:nil target:self action:@selector(backClick)];
    _backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _backBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    [self addSubview:_backBtn];
    [_backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:kNavigationTitle_Font textColor:KColorUtilsString(kNavigationTitle_Color) textAlignment:0 backgroundColor:nil];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self);
    }];
    
    _shareBtn = [LSKViewFactory initializeButtonNornalImage:@"shareicon" selectedImage:nil target:self action:@selector(shareClick)];
    _shareBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    _shareBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
    [self addSubview:_shareBtn];
    [_shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self);
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(60, 30));
    }];
    
}
- (void)setTitle:(NSString *)title {
    _titleLbl.text = title;
}
- (void)setIsBack:(BOOL)isBack {
    _backBtn.hidden = !isBack;
}
- (void)setIsShare:(BOOL)isShare {
    _shareBtn.hidden = !isShare;
}
- (void)shareClick {
    if (self.navigationBlock) {
        self.navigationBlock(2);
    }
}
- (void)backClick {
    if (self.navigationBlock) {
        self.navigationBlock(1);
    }
}
@end
