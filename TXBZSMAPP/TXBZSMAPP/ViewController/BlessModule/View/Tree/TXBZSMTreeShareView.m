//
//  TXBZSMTreeShareView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTreeShareView.h"

@implementation TXBZSMTreeShareView
{
    UIImageView *_cardImage;
    UILabel *_contentLbl;
    UILabel *_titleLbl;
    UIView *_contentView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *bgView = [[UIImageView alloc]initWithImage:ImageNameInit(@"wishTreebg")];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _cardImage = [[UIImageView alloc]init];
    [self addSubview:_cardImage];
    [_cardImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(WIDTH_RACE_6S(126));
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(110, 193));
    }];
    _contentView = [[UIView alloc]init];
    _contentView.backgroundColor = [UIColor whiteColor];
    _contentLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _contentLbl.numberOfLines = 0;
    [_contentView addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->_contentView).with.offset(10);
        make.right.equalTo(self->_contentView).with.offset(-10);
    }];
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl.textAlignment = 2;
    [_contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_contentView).with.offset(10);
        make.right.bottom.equalTo(self->_contentView).with.offset(-10);
    }];
    KViewRadius(_contentView, 5.0);
    [self addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_cardImage.mas_bottom).with.offset(WIDTH_RACE_6S(60));
        make.left.equalTo(self).with.offset(12);
        make.right.equalTo(self).with.offset(-12);
        make.height.mas_equalTo(60);
    }];
    
}
- (void)setupContent:(NSString *)content name:(NSString *)name img:(NSString *)img {
    _contentLbl.text = content;
    _titleLbl.text = name;
    CGFloat height = [content calculateTextHeight:14 width:SCREEN_WIDTH - 24 - 20];
    height += 40 + 10;
    if (height < 60) {
        height = 60;
    }
    [_contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(height);
    }];
    _cardImage.image = ImageNameInit(img);
}
@end
