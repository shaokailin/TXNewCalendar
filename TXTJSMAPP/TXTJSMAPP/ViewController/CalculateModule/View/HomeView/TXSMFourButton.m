//
//  TXSMFourButton.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFourButton.h"
#import "UIImageView+WebCache.h"
@implementation TXSMFourButton
{
    UILabel *_titleLbl;
    UILabel *_detailLbl;
    UIImageView *_iconImageView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _iconImageView = [[UIImageView alloc]init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-12);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(60);
        make.centerY.equalTo(self);
    }];
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:13];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(25);
        make.top.equalTo(self).with.offset(22);
        make.right.equalTo(self->_iconImageView.mas_left).with.offset(-12);
    }];
    _detailLbl = [TXXLViewManager customDetailLbl:nil font:11];
    _detailLbl.numberOfLines = 3;
    [self addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_titleLbl);
        make.top.equalTo(self->_titleLbl.mas_bottom).with.offset(9);
    }];
    
}
- (void)setupTitle:(NSString *)title detail:(NSString *)detail img:(NSString *)img {
    _titleLbl.text = title;
    _detailLbl.text = detail;
    if (KJudgeIsNullData(img)) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:img] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (image) {
                self->_iconImageView.backgroundColor = nil;
            }else {
                self->_iconImageView.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
            }
        }];
    }
}
@end
