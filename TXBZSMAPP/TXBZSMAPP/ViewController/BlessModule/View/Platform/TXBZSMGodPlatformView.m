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
    UIImageView *_lazhu_left_btn;
    UIImageView *_lazhu_right_btn;
    UIImageView *_huaping_left_btn;
    UIImageView *_huaping_right_btn;
    UIImageView *_gongguo_btn;
    UIImageView *_chashui_btn;
    UIImageView *_xiangyan_btn;
    BOOL _isHasGod;
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
- (void)jumpHuaPing {
    if (!_isHasGod) {
        [SKHUD showMessageInWindowWithMessage:@"请先选择神明"];
        return;
    }
    if (self.block) {
        self.block(2);
    }
}
- (void)jumpLazhu {
    if (!_isHasGod) {
        [SKHUD showMessageInWindowWithMessage:@"请先选择神明"];
        return;
    }
    if (self.block) {
        self.block(0);
    }
}
- (void)jumpChashui {
    if (!_isHasGod) {
        [SKHUD showMessageInWindowWithMessage:@"请先选择神明"];
        return;
    }
    if (self.block) {
        self.block(1);
    }
}
- (void)jumpXiang {
    if (!_isHasGod) {
        [SKHUD showMessageInWindowWithMessage:@"请先选择神明"];
        return;
    }
    if (self.block) {
        self.block(3);
    }
}
- (void)jumpGuo {
    if (!_isHasGod) {
        [SKHUD showMessageInWindowWithMessage:@"请先选择神明"];
        return;
    }
    if (self.block) {
        self.block(4);
    }
}
- (void)jumpGodSelect {
    if (_isHasGod) {
        return;
    }
    if (self.block) {
        self.block(5);
    }
}
- (void)setupContentWithModel:(TXBZSMGodMessageModel *)model {
    
    if (model) {
        _isHasGod = YES;
        _godImg.image = ImageNameInit(model.godImage);
        [self setupContent:model.lazhu type:0];
        [self setupContent:model.chashui type:1];
        [self setupContent:model.huaImage type:2];
        [self setupContent:model.xiangyan type:3];
        [self setupContent:model.gongguo type:4];
    }
}
- (void)setupContent:(NSString *)img type:(PlatformGoodsType)type {
    if (KJudgeIsNullData(img)) {
        UIImage *image = ImageNameInit(img);
        switch (type) {
            case 0:
                _isLazhu = YES;
                _lazhu_left_btn.image = image;
                _lazhu_right_btn.image = image;
                break;
            case 1:
                _isChashui = YES;
                _chashui_btn.image = image;
                break;
            case 2:
                _isHuaPing = YES;
                _huaping_left_btn.image = image;
                _huaping_right_btn.image = image;
                break;
            case 3:
                _isXiangyan = YES;
                _xiangyan_btn.image = image;
                break;
            case 4:
                _isGongpin = YES;
                _gongguo_btn.image = image;
                break;
            default:
                break;
        }
    }else {
        switch (type) {
            case 0:
                _isLazhu = NO;
                _lazhu_left_btn.image = ImageNameInit(@"lazhu");
                _lazhu_right_btn.image = ImageNameInit(@"lazhu");
                break;
            case 1:
                _isChashui = NO;
                _chashui_btn.image = ImageNameInit(@"chashui");
                break;
            case 2:
                _isHuaPing = NO;
                _huaping_left_btn.image = ImageNameInit(@"huaping");
                _huaping_right_btn.image = ImageNameInit(@"huaping");
                break;
            case 3:
                _isXiangyan = NO;
                _xiangyan_btn.image = ImageNameInit(@"xiangtai");;
                break;
            case 4:
                _isGongpin = NO;
                _gongguo_btn.image = ImageNameInit(@"gongpin");;
                break;
            default:
                break;
        }
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
    
    _godImg = [self customImageView:@"nogod" action:@selector(jumpGodSelect)];
    _godImg.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:_godImg];
    [_godImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(godPlatformImg.mas_top).with.offset(WIDTH_RACE_6S(50));
        make.centerX.equalTo(self);
        make.width.mas_equalTo(WIDTH_RACE_6S(180));
        make.height.mas_equalTo(WIDTH_RACE_6S(360));
    }];
    
    _huaping_left_btn = [self customImageView:@"huaping" action:@selector(jumpHuaPing)];
    [self addSubview:_huaping_left_btn];
    
    [_huaping_left_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(godPlatformImg.mas_left).with.offset(20 - WIDTH_RACE_6S(1));
        make.bottom.equalTo(godPlatformImg.mas_bottom).with.offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(130);
    }];
    _huaping_right_btn = [self customImageView:@"huaping" action:@selector(jumpHuaPing)];
    [self addSubview:_huaping_right_btn];
    [_huaping_right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(godPlatformImg.mas_right).with.offset(-20 + WIDTH_RACE_6S(1));
        make.centerY.equalTo(self->_huaping_left_btn);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(130);
    }];
    
    _lazhu_left_btn = [self customImageView:@"lazhu" action:@selector(jumpLazhu)];
    [self addSubview:_lazhu_left_btn];
    [_lazhu_left_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(isIphone5?0:WIDTH_RACE_6S(10));
        make.centerY.equalTo(self->_huaping_left_btn.mas_centerY).with.offset(30);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(150);
    }];
    
    _lazhu_right_btn = [self customImageView:@"lazhu" action:@selector(jumpLazhu)];
    [self addSubview:_lazhu_right_btn];
    [_lazhu_right_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-(isIphone5?0:WIDTH_RACE_6S(10)));
        make.centerY.equalTo(self->_lazhu_left_btn);
        make.width.mas_equalTo(45);
        make.height.mas_equalTo(150);
    }];
    _xiangyan_btn = [self customImageView:@"xiangtai" action:@selector(jumpXiang)];
    [self addSubview:_xiangyan_btn];
    [_xiangyan_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(godPlatformImg.mas_bottom).with.offset(60);
        make.centerX.equalTo(self);
        make.width.mas_equalTo(86);
        make.height.mas_equalTo(150);
    }];
    
    _gongguo_btn = [self customImageView:@"gongpin" action:@selector(jumpGuo)];
    [self addSubview:_gongguo_btn];
    [_gongguo_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_lazhu_left_btn.mas_bottom).with.offset((isIphone5? -5:-25));
        make.left.equalTo(self).with.offset(WIDTH_RACE_6S(50));
        make.width.height.mas_equalTo(72);
    }];
    
    _chashui_btn = [self customImageView:@"chashui" action:@selector(jumpChashui)];
    [self addSubview:_chashui_btn];
    [_chashui_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self->_gongguo_btn).with.offset(-5);
        make.right.equalTo(self).with.offset(-WIDTH_RACE_6S(50));
        make.width.height.mas_equalTo(80);
    }];
    
}
- (UIImageView *)customImageView:(NSString *)image action:(SEL)action {
    UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageNameInit(image)];
    imageView.contentMode = UIViewContentModeBottom;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:action];
    [imageView addGestureRecognizer:tap];
    return imageView;
}
@end
