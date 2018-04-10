//
//  TXSMFiveAdView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFiveAdView.h"
#import "UIButton+Extend.h"
@implementation TXSMFiveAdView
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
            NSString *image = [contentDict objectForKey:@"image"];
            if (KJudgeIsNullData(image)) {
                iconImage.image = ImageNameInit(image);
            }
        }else {
            titleLbl.text = nil;
            iconImage.image = nil;
        }
    }
}
- (CGFloat)returnHeight {
    return 40 + 5 + WIDTH_RACE_6S(95) + WIDTH_RACE_6S(160);
}
- (void)_layoutMainView {
    
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"热门测算" font:15];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(7);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(33);
    }];
    CGFloat maxWidth = WIDTH_RACE_6S(175);
    CGFloat minWidth = WIDTH_RACE_6S(116);
    CGFloat maxHeight = WIDTH_RACE_6S(160);
    CGFloat minHeight = WIDTH_RACE_6S(95);
//    CGFloat maxBetween = SCREEN_WIDTH - 20 - maxWidth * 2;
//    CGFloat minBetween = (SCREEN_WIDTH - 20 - minWidth * 3) / 2.0;
    
    UIButton *max1 = [self customMinBtn:0];
    [self addSubview:max1];
    
    [max1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(titleLbl.mas_bottom);
        make.size.mas_equalTo(CGSizeMake(maxWidth, maxHeight));
    }];
    
    UIButton *max2 = [self customMinBtn:1];
    [self addSubview:max2];
    [max2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(max1);
        make.size.mas_equalTo(CGSizeMake(maxWidth, maxHeight));
    }];
    
    UIButton *min1 = [self customMinBtn:2];
    [self addSubview:min1];
    [min1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(max1.mas_bottom).with.offset(5);
        make.size.mas_equalTo(CGSizeMake(minWidth, minHeight));
    }];
    
    UIButton *min2 = [self customMinBtn:3];
    [self addSubview:min2];
    [min2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(min1);
        make.size.mas_equalTo(CGSizeMake(minWidth, minHeight));
    }];
    
    UIButton *min3 = [self customMinBtn:4];
    [self addSubview:min3];
    [min3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(min1);
        make.size.mas_equalTo(CGSizeMake(minWidth, minHeight));
    }];
    
}
- (void)btnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(nil,btn.tag - 300);
    }
}
- (UIButton *)customMinBtn:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.backgroundColor = [UIColor whiteColor];
    iconImageView.tag = 400 + flag;
    [btn addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(btn);
    }];
    btn.backgroundColor = [UIColor whiteColor];
    btn.tag = 300 +flag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}


@end
