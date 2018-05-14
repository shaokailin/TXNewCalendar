//
//  TXBZSMGodPlatformView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodPlatformView.h"

@implementation TXBZSMGodPlatformView
{
    UIImageView *_godImg;
    UIButton *_lazhu_left_btn;
    UIButton *_lazhu_right_btn;
    UIButton *_huaping_left_btn;
    UIButton *_huaping_right_btn;
    UIButton *_gongguo_btn;
    UIButton *_chashui_btn;
    UIButton *_xiangyan_btn;
    BOOL _isLazhu,_isHuaPing,_isGongpin,_isChashui,_isXiangyan;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (BOOL)isAllPull {
    return _isLazhu + _isGongpin + _isXiangyan + _isHuaPing + _isChashui == 5?YES:NO;
}
- (void)clickAction:(UIButton *)btn {
    if (self.block) {
        NSInteger type = btn.tag - 200;
        PlatformGoodsType actionType = 0;
        if (type < 2) {
            actionType = 2;
        }else if (type < 4) {
            actionType = 0;
        }else if (type == 4){
            actionType = 3;
        }else if (type == 5){
            actionType = 4;
        }else {
            actionType = 1;
        }
        self.block(actionType);
    }
}
- (void)setupContent:(NSString *)img type:(PlatformGoodsType)type {
    switch (type) {
        case 0:
            _isLazhu = YES;
            [_lazhu_left_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            [_lazhu_right_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            break;
        case 1:
            _isChashui = YES;
            [_chashui_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            break;
        case 2:
            _isHuaPing = YES;
            [_huaping_left_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            [_huaping_right_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            break;
        case 3:
            _isXiangyan = YES;
            [_xiangyan_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            break;
        case 4:
            _isGongpin = YES;
            [_gongguo_btn setBackgroundImage:ImageNameInit(img) forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
}
- (void)_layoutMainView {
    BOOL isIphone5 = [LSKPublicMethodUtil getiPhoneType] < 2 ?YES:NO;
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"platformbg")];
    bgImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.top.equalTo(self).with.offset(WIDTH_RACE_6S(55));
    }];
    UIImageView *godPlatformImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"platformgod")];
    [self addSubview:godPlatformImg];
    [godPlatformImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(162), WIDTH_RACE_6S(80)));
        make.top.equalTo(self.mas_centerY).with.offset(2 + WIDTH_RACE_6S(55) / 2.0);
        make.centerX.equalTo(self);
    }];
    
    _godImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"nogod")];
    [self addSubview:_godImg];
    [_godImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(godPlatformImg.mas_top).with.offset(WIDTH_RACE_6S(50));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(WIDTH_RACE_6S(220));
        make.height.mas_equalTo(WIDTH_RACE_6S(360));
    }];
    
    _huaping_left_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"huaping"];
    _huaping_left_btn.tag = 200;
    [self addSubview:_huaping_left_btn];
    
    [_huaping_left_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(godPlatformImg.mas_left).with.offset(7 - WIDTH_RACE_6S(1));
        make.centerY.equalTo(godPlatformImg);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(130);
    }];
    _huaping_right_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"huaping"];
    _huaping_right_btn.tag = 201;
    [self addSubview:_huaping_right_btn];
    [_huaping_right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(godPlatformImg.mas_right).with.offset(-7 + WIDTH_RACE_6S(1));
        make.centerY.equalTo(self->_huaping_left_btn);
        make.height.mas_equalTo(80);
        make.width.mas_equalTo(130);
    }];
    
    _lazhu_left_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"lazhu"];
    _lazhu_left_btn.tag = 202;
    [self addSubview:_lazhu_left_btn];
    [_lazhu_left_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(isIphone5?0:WIDTH_RACE_6S(15));
        make.centerY.equalTo(self->_huaping_left_btn);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(150);
    }];
    
    _lazhu_right_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"lazhu"];
    _lazhu_right_btn.tag = 203;
    [self addSubview:_lazhu_right_btn];
    [_lazhu_right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-(isIphone5?0:WIDTH_RACE_6S(15)));
        make.centerY.equalTo(self->_huaping_right_btn);
        make.height.mas_equalTo(45);
        make.width.mas_equalTo(150);
    }];
    _xiangyan_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"xiangtai"];
    _xiangyan_btn.tag = 204;
    [self addSubview:_xiangyan_btn];
    [_xiangyan_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(godPlatformImg.mas_bottom);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(86);
        make.width.mas_equalTo(150);
    }];
    
    _gongguo_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"gongpin"];
    _gongguo_btn.tag = 205;
    [self addSubview:_gongguo_btn];
    [_gongguo_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_lazhu_left_btn.mas_bottom).with.offset((isIphone5? -5:0));
        make.left.equalTo(self).with.offset(WIDTH_RACE_6S(50));
        make.width.height.mas_equalTo(72);
    }];
    
    _chashui_btn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(clickAction:) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"chashui"];
    _chashui_btn.tag = 206;
    [self addSubview:_chashui_btn];
    [_chashui_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_gongguo_btn).with.offset(-5);
        make.right.equalTo(self).with.offset(-WIDTH_RACE_6S(50));
        make.width.height.mas_equalTo(80);
    }];
    
}
@end
