//
//  TXBZSMBlessHomeNaviButton.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeNaviButton.h"
#import "UIImageView+WebCache.h"
@implementation TXBZSMBlessHomeNaviButton
{
    UIImageView *_iconImgView;
    UILabel *_titleLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _iconImgView = [[UIImageView alloc]init];
//    _iconImgView.contentMode = UIViewContentModeScaleAspectFill;
//    _iconImgView.image =
    [self addSubview:_iconImgView];
    [_iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(14);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(44, 53));
    }];
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    [self  addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-12);
        make.centerX.equalTo(self);
    }];
}
- (void)setupTitle:(NSString *)title image:(NSString *)image {
    if ([image isEqualToString:@"tree"]) {
        _iconImgView.image = ImageNameInit(image);
    }else {
        if (image) {
            [_iconImgView sd_setImageWithURL:[NSURL URLWithString:image]];
        }
    }
    _titleLbl.text = title;
}
@end
