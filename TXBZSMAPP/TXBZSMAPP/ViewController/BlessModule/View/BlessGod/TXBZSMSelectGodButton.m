//
//  TXBZSMSelectGodButton.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMSelectGodButton.h"

@implementation TXBZSMSelectGodButton
{
    UIImageView *_iconImage;
    UILabel *_detailLbl;
    UILabel *_nameLbl;
    UIImageView *_hasInviteImg;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self _layoutMainView];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}

- (void)setupContentWithName:(NSString *)name detail:(NSString *)detail img:(NSString *)img isHas:(BOOL)isHas {
    _nameLbl.text = name;
    _detailLbl.text = detail;
    _hasInviteImg.hidden = !isHas;
    _iconImage.image = ImageNameInit(img);
}
- (void)_layoutMainView {
    
    _nameLbl = [LSKViewFactory initializeLableWithText:@"哈哈" font:13 textColor:KColorHexadecimal(kText_Title_Color, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_nameLbl];
    [_nameLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-5);
        make.centerX.equalTo(self);
    }];
    _detailLbl = [LSKViewFactory initializeLableWithText:@"哈哈" font:13 textColor:KColorHexadecimal(kText_Title_Color, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self->_nameLbl.mas_top).with.offset(-4);
        make.centerX.equalTo(self);
    }];
    _iconImage = [[UIImageView alloc]init];
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self);
        make.bottom.equalTo(self).with.offset(-46);
    }];
    _hasInviteImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"hasInvite")];
    [self addSubview:_hasInviteImg];
    [_hasInviteImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.left.equalTo(self).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(42, 63));
    }];
}
@end
