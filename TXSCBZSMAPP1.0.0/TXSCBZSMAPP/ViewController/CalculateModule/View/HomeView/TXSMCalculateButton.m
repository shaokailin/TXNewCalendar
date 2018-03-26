//
//  TXSMCalculateButton.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/6.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCalculateButton.h"
#import "UIImageView+WebCache.h"
@implementation TXSMCalculateButton
{
    UIImageView *_bgImageView;
    UILabel *_titleLbl;
    UIImageView *_titleBgImage;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithImage:(NSString *)image title:(NSString *)title {
    if (KJudgeIsNullData(image)) {
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        _bgImageView.image = nil;
    }
    if (KJudgeIsNullData(title)) {
        _titleLbl.text = title;
        _titleBgImage.hidden = NO;
    }else {
        _titleLbl.text = nil;
        _titleBgImage.hidden = YES;
    }
    
}
- (void)_layoutMainView {
    KViewBoundsRadius(self, 4.0);
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);;
    [self addSubview:_bgImageView];
    WS(ws)
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    _titleBgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"titlebgimage")];
    [self addSubview:_titleBgImage];
    [_titleBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(ws);
        make.height.mas_equalTo(WIDTH_RACE_6S(30));
    }];
    
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws);
        make.right.equalTo(ws).with.offset(-5);
        make.left.equalTo(ws).with.offset(5);
        make.height.mas_equalTo(WIDTH_RACE_6S(30));
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
