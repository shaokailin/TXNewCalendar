//
//  TXSMFiveAdView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFiveAdView.h"
#import "UIButton+Extend.h"
#import "UIImageView+WebCache.h"
@implementation TXSMFiveAdView
{
    CGFloat _viewHeight;
}
@synthesize clickBlock;
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCategoryBtnArray:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        UIButton *btn = [self viewWithTag:300 + i];
        UILabel *titleLbl = [btn viewWithTag:500 + i];
        UIImageView *iconImage = [btn viewWithTag:400 + i];
        if (i < array.count) {
            NSDictionary *contentDict = [array objectAtIndex:i];
            NSString *title = [contentDict objectForKey:@"title"];
            NSString *image = [contentDict objectForKey:@"image"];
            titleLbl.text = title;
            if (KJudgeIsNullData(image)) {
                [iconImage sd_setImageWithURL:[NSURL URLWithString:image]];
            }
        }else {
            titleLbl.text = nil;
            iconImage.image = nil;
        }
    }
}
- (CGFloat)returnHeight {
    return _viewHeight;
}
- (void)_layoutMainView {
    _viewHeight = 191;
    UIButton *maxBtn = [self customMinBtn:0 top:-11 between:13];
    [self addSubview:maxBtn];
    [maxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH / 2.0 - 1);
    }];
    CGFloat btnWidth = (SCREEN_WIDTH / 2.0 - 1) / 2.0;
    CGFloat btnHeight = (_viewHeight - 1) / 2.0;
    CGFloat top = -10;
    CGFloat between = 9;
    UIButton *btn1 = [self customMinBtn:1 top:top between:between];
    [self addSubview:btn1];
    
    [btn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_centerX);
        make.top.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
    UIButton *btn2 = [self customMinBtn:2 top:top between:between];
    [self addSubview:btn2];
    [btn2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
    UIButton *btn3 = [self customMinBtn:3 top:top between:between];
    [self addSubview:btn3];
    [btn3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn1.mas_left);
        make.top.equalTo(btn1.mas_bottom).with.offset(1);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    UIButton *btn4 = [self customMinBtn:4 top:top between:between];
    [self addSubview:btn4];
    [btn4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(btn2);
        make.top.equalTo(btn3);
        make.size.mas_equalTo(CGSizeMake(btnWidth, btnHeight));
    }];
    
}
- (void)btnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn.tag - 300);
    }
}
- (UIButton *)customMinBtn:(NSInteger)flag top:(CGFloat)top between:(CGFloat)between {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.backgroundColor = [UIColor whiteColor];
    iconImageView.tag = 400 + flag;
    [btn addSubview:iconImageView];
    if (flag != 0) {
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn).with.offset(top);
            make.centerX.equalTo(btn);
            make.width.mas_equalTo(45);
            make.height.mas_equalTo(45);
        }];
    }else {
        [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(btn.mas_centerY).with.offset(top);
            make.centerX.equalTo(btn);
            make.width.mas_equalTo(129);
            make.height.mas_equalTo(79);
        }];
    }
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:11];
    if (flag == 0) {
        titleLbl.font = FontNornalInit(17);
    }
    titleLbl.textAlignment = 1;
    titleLbl.tag = 500 + flag;
    [btn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn).with.offset(5);
        make.right.equalTo(btn).with.offset(-5);
        make.top.equalTo(iconImageView.mas_bottom).with.offset(between);
    }];
    btn.backgroundColor = [UIColor whiteColor];
    btn.tag = 300 +flag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


@end
