//
//  TXXLBottonAdView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLBottonAdView.h"
#import "TXSMCalculateButton.h"
@implementation TXXLBottonAdView
{
    UILabel *_titleLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _latoutMainView];
    }
    return self;
}
- (void)setFlag:(NSInteger)flag {
    self.tag = flag;
    if (flag == 600) {
        [self setupContentWithTitle:@"感情姻缘"];
    }else if (flag == 601) {
        [self setupContentWithTitle:@"先天命运"];
    }else {
        [self setupContentWithTitle:@"解名占卜"];
    }
}
- (void)setupContentWithData:(NSArray *)array {
    for (int i = 0; i < 4; i++) {
        TXSMCalculateButton *btn = [self viewWithTag:200 + i];
        if (i < array.count) {
            NSDictionary *dict = [array objectAtIndex:i];
            NSString *title = [dict objectForKey:@"title"];
            NSString *image = [dict objectForKey:@"image"];
            btn.hidden = NO;
            [btn setupContentWithImage:image title:title];
        }else {
            btn.hidden = YES;
        }
    }
}
- (void)setupContentWithTitle:(NSString *)title {
    _titleLbl.text = title;
}
- (void)adClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(self.tag - 600, btn.tag - 200);
    }
}
- (void)_latoutMainView {
    KViewRadius(self, 5.0);
    self.backgroundColor = [UIColor whiteColor];
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:18];
    CGFloat leftMargin = WIDTH_RACE_6S(20);
    _titleLbl.frame = CGRectMake(leftMargin, 15, SCREEN_WIDTH - WIDTH_RACE_6S(leftMargin * 2), 18);
    [self addSubview:_titleLbl];
    CGFloat width = WIDTH_RACE_6S(160);
    CGFloat heigth = WIDTH_RACE_6S(105);
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 2; j++) {
            TXSMCalculateButton *btn = [[TXSMCalculateButton alloc]init];
            btn.tag = 200 + i * 2 + j;
            btn.frame = CGRectMake(leftMargin + (width + WIDTH_RACE_6S(5)) * j, 42 + (heigth + 5) * i, width, heigth);
            [btn addTarget:self action:@selector(adClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn];
        }
    }
}
@end
