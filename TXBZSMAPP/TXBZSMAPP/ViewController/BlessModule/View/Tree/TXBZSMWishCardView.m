//
//  TXBZSMWishCardView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishCardView.h"

@implementation TXBZSMWishCardView
{
    UILabel *_contentLbl;
    UILabel *_nameLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)content name:(NSString *)name {
    _contentLbl.text = content;
    _nameLbl.text = name;
}
- (void)_layoutMainView {
    UIImageView *bgView = [[UIImageView alloc]initWithImage:ImageNameInit(@"wishmessagebg")];
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:11 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    _contentLbl.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(40);
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.bottom.greaterThanOrEqualTo(self).with.offset(-30);
    }];
    _nameLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _nameLbl.adjustsFontSizeToFitWidth = YES;
    [self addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_contentLbl);
        make.bottom.equalTo(self).with.offset(-8);
    }];
}
@end
