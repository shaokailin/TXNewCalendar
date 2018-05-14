//
//  TXBZSMPlatformGoodsButtn.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMPlatformGoodsButtn.h"

@implementation TXBZSMPlatformGoodsButtn
{
    UIImageView *_iconImage;
    UILabel *_titleLbl;
}
- (void)setupType:(NSInteger)type {
    CGFloat width = 80;
    CGFloat height = 130;
    if (type == 0) {
        width = 45;
        height = 150;
    }else if (type == 1){
        width = 80;
        height = 80;
    }else if (type == 3){
        width = 86;
        height = 150;
    }
    [_iconImage mas_updateConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(width);
        make.height.mas_equalTo(height);
    }];
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    _iconImage = [[UIImageView alloc]init];
    _iconImage.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:_iconImage];
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-32);
        make.height.mas_equalTo(72);
        make.width.mas_equalTo(72);
        make.centerX.equalTo(self);
    }];
    
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:13 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self);
        make.left.equalTo(self).with.offset(-5);
        make.right.equalTo(self).with.offset(5);
        make.height.mas_equalTo(30);
    }];
}
- (void)setupContentWithName:(NSString *)name img:(NSString *)img {
    _titleLbl.text = name;
    _iconImage.image = ImageNameInit(img);
}
@end
