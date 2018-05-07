//
//  TXBZSMTodayAdView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTodayAdView.h"
#import "UIButton+WebCache.h"
@implementation TXBZSMTodayAdView
{
    CGFloat _width;
    CGFloat _height;
    CGFloat _between;
}
- (instancetype)init {
    if (self = [super init]) {
//        [self _layoutMainView];
        _height = WIDTH_RACE_6S(81);
        _width = WIDTH_RACE_6S(123);
        _between = (SCREEN_WIDTH - _width * 3) / 2.0;
    }
    return self;
}
- (void)setupAdMessage:(NSArray *)array {
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict = [array objectAtIndex:i];
        NSString *image = [dict objectForKey:@"image"];
        UIButton *btn = [self viewWithTag:300 + i];
        if (!btn) {
            btn = [self customButtonView:i];
            btn.frame = CGRectMake(0 + (_width + _between) * i, 0, _width, _height);
            [self addSubview:btn];
        }
        if (KJudgeIsNullData(image)) {
            [btn sd_setBackgroundImageWithURL:[NSURL URLWithString:image] forState:UIControlStateNormal];
        }
    }
}
- (UIButton *)customButtonView:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.tag = 300 + flag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)btnClick:(UIButton *)btn {
    if (self.adBlock) {
        self.adBlock(btn.tag - 300);
    }
}
@end
