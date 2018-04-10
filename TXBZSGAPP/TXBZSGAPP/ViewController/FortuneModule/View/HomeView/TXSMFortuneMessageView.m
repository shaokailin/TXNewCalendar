//
//  TXSMFortuneMessageView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneMessageView.h"
#import "TXSMFortuneNumberButton.h"
@implementation TXSMFortuneMessageView
{
    UIImageView *_iconImgView;
    UILabel *_titleLbl;
    UILabel *_descriptorLbl;
    UILabel *_timeLbl;
    UILabel *_infoLbl;
    TXSMFortuneNumberButton *_colorBtn;
    TXSMFortuneNumberButton *_numberBtn;
    TXSMFortuneNumberButton *_xingzuoBtn;
    UIButton *_exchangeBtn;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithDetail:(NSDictionary *)dict {
    _iconImgView.image = ImageNameInit([dict objectForKey:@"image"]);
    _titleLbl.text = [dict objectForKey:@"title"];
    _descriptorLbl.text = [dict objectForKey:@"description"];
    _timeLbl.text = [dict objectForKey:@"time"];
//    _infoLbl.text = [dict objectForKey:@"info"];
    
}
- (void)exchangeIsHiden:(BOOL)isHiden {
    _exchangeBtn.hidden = isHiden;
}
- (CGFloat)returnCurrentHeight {
    CGFloat height = 163;
//    CGFloat contentHeight = [_infoLbl.text calculateTextHeight:11 width:SCREEN_WIDTH - 20 - 18 - 15];
//    height += contentHeight;
    return height;
}
- (void)setupLuckyColor:(NSString *)color number:(NSString *)number xingzuo:(NSString *)xingzuo {
    [_colorBtn setupContent:color];
    [_numberBtn setupContent:number];
    [_xingzuoBtn setupContent:xingzuo];
}
- (void)exchangeShowClick {
    [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kFortune_Show_Change_Notice object:nil userInfo:nil];
}
- (void)_layoutMainView {
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, 35, SCREEN_WIDTH - 20, 128)];
    KViewRadius(contentView, 10);
    contentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:contentView];
    
    _iconImgView = [[UIImageView alloc]init];
    KViewBorderLayer(_iconImgView, [UIColor whiteColor], 3.5);
    KViewBoundsRadius(_iconImgView, 41);
    [self addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.width.mas_equalTo(82);
        make.height.mas_equalTo(82);
        make.top.equalTo(self).with.offset(0);
    }];
    
    _exchangeBtn = [LSKViewFactory initializeButtonWithTitle:@"切换" target:self action:@selector(exchangeShowClick) textfont:13 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    [contentView addSubview:_exchangeBtn];
    [_exchangeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).with.offset(-5);
        make.top.equalTo(contentView).with.offset(3);
        make.size.mas_equalTo(CGSizeMake(44, 44));
    }];
    
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:18];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(22);
        make.top.equalTo(contentView).with.offset(52);
    }];
    
    _descriptorLbl = [TXXLViewManager customTitleLbl:nil font:12];
    [self addSubview:_descriptorLbl];
    [_descriptorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_titleLbl);
        make.top.equalTo(self->_titleLbl.mas_bottom).with.offset(6);
    }];
    
    _timeLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x5e5e5e, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_descriptorLbl);
        make.top.equalTo(self->_descriptorLbl.mas_bottom).with.offset(7);
    }];
    CGFloat btnWidth = WIDTH_RACE_6S(78);
    CGFloat btnHeight = WIDTH_RACE_6S(30);
    CGFloat between = WIDTH_RACE_6S(3);
    CGFloat left = 10;
    CGFloat botton = 16;
    if ([LSKPublicMethodUtil getiPhoneType] < 2) {
        left = 5;
        botton = 10;
    }
    _xingzuoBtn = [[TXSMFortuneNumberButton alloc]initWithType:2];
    [self addSubview:_xingzuoBtn];
    [_xingzuoBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(contentView).with.offset(-left);
        make.bottom.equalTo(contentView).with.offset(-botton);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    _numberBtn = [[TXSMFortuneNumberButton alloc]initWithType:1];
    [self addSubview:_numberBtn];
    [_numberBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_xingzuoBtn.mas_left).with.offset(-between);
        make.top.width.height.equalTo(self->_xingzuoBtn);
    }];
    _colorBtn = [[TXSMFortuneNumberButton alloc]initWithType:0];
    [self addSubview:_colorBtn];
    [_colorBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_numberBtn.mas_left).with.offset(-between);
        make.top.width.height.equalTo(self->_numberBtn);
    }];
    
//    _infoLbl = [TXXLViewManager customTitleLbl:nil font:11];
//    _infoLbl.numberOfLines = 0;
//    _infoLbl.textAlignment = 1;
//    [self addSubview:_infoLbl];
//    [_infoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self).with.offset(18);
//        make.right.equalTo(self).with.offset(-15);
//        make.top.equalTo(self->_colorBtn.mas_bottom).with.offset(11);
//
//    }];
}

@end
