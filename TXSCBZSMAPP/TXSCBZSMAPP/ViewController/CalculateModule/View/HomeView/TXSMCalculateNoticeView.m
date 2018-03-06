//
//  TXSMCalculateNoticeView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/6.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCalculateNoticeView.h"

@implementation TXSMCalculateNoticeView
{
    UIButton *_newBtn;
    UIButton *_hotBtn;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _latoutMainView];
    }
    return self;
}
- (void)setupContentWithNew:(NSString *)topNew hot:(NSString *)hot {
    [_newBtn setTitle:topNew forState:UIControlStateNormal];
    [_hotBtn setTitle:hot forState:UIControlStateNormal];
}
- (void)topNewClick {
    if (self.noticeBlock) {
        self.noticeBlock(0);
    }
}
- (void)topHotClick {
    if (self.noticeBlock) {
        self.noticeBlock(1);
    }
}
- (void)_latoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"todaynotice")];
    [self addSubview:imageView];
    WS(ws)
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(64, 64));
        make.centerY.equalTo(ws);
        make.left.equalTo(ws).with.offset(35);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview: lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(imageView.mas_right).with.offset(17);
        make.size.mas_equalTo(CGSizeMake(1, 50));
        make.centerY.equalTo(ws);
    }];
    UIColor *glayColor = KColorHexadecimal(0x944643, 1.0);
    UILabel *topNewLbl = [LSKViewFactory initializeLableWithText:@"最新" font:12 textColor:glayColor textAlignment:1 backgroundColor:nil];
    KViewBorderLayer(topNewLbl, glayColor, kLineView_Height);
    [self addSubview:topNewLbl];
    [topNewLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).with.offset(15);
        make.top.equalTo(ws).with.offset(17);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    _newBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(topNewClick) textfont:12 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    _newBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    _newBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:_newBtn];
    [_newBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topNewLbl.mas_right).with.offset(5);
        make.centerY.equalTo(topNewLbl);
        make.right.equalTo(ws).with.offset(-5);
        make.height.mas_equalTo(30);
    }];
    
    
    UILabel *topHotLbl = [LSKViewFactory initializeLableWithText:@"热门" font:12 textColor:glayColor textAlignment:1 backgroundColor:nil];
    KViewBorderLayer(topHotLbl, glayColor, kLineView_Height);
    [self addSubview:topHotLbl];
    [topHotLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView.mas_right).with.offset(15);
        make.bottom.equalTo(ws).with.offset(-17);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    _hotBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(topHotClick) textfont:12 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    _hotBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    _hotBtn.titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    [self addSubview:_hotBtn];
    [_hotBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(topHotLbl.mas_right).with.offset(5);
        make.centerY.equalTo(topHotLbl);
        make.right.equalTo(ws).with.offset(-5);
        make.height.mas_equalTo(30);
    }];
}
@end
