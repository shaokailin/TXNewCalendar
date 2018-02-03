//
//  TXXLBottonAdView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLBottonAdView.h"
#import "TXXLCalculateMaxButton.h"
#import "TXXLCalculateMinButton.h"
@implementation TXXLBottonAdView
{
    UILabel *_titleLbl;
    UILabel *_englishLbl;
    TXXLCalculateMaxButton *_maxBtn;
    TXXLCalculateMinButton *_topMinBtn;
    TXXLCalculateMinButton *_bottonMinBtn;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _latoutMainView];
    }
    return self;
}
- (void)setupContentWithTitle:(NSString *)title english:(NSString *)english dataDict:(NSDictionary *)dict {
    _titleLbl.text = title;
    _englishLbl.text = english;
    [_maxBtn setupContentWithImage:nil title:@"测试测试测试测试"];
    [_topMinBtn setupContentWithImage:nil title:@"测试测试测试测试"];
    [_bottonMinBtn setupContentWithImage:nil title:@"测试测试测试测试"];
}
- (void)maxBtnClick {
    if (self.clickBlock) {
        self.clickBlock(self.tag - 600, 0);
    }
}
- (void)minBtnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(self.tag - 600, btn == _topMinBtn? 1:2);
    }
}
- (void)_latoutMainView {
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:15];
    _titleLbl.frame = CGRectMake(WIDTH_RACE_6S(25), 0, SCREEN_WIDTH - WIDTH_RACE_6S(45), 16);
    [self addSubview:_titleLbl];
    
    _englishLbl = [TXXLViewManager customDetailLbl:nil font:12];
    _englishLbl.frame = CGRectMake(WIDTH_RACE_6S(25), 23, SCREEN_WIDTH - WIDTH_RACE_6S(45), 13);
    [self addSubview:_englishLbl];
//    324 222 298 106
    _maxBtn = [[TXXLCalculateMaxButton alloc]init];
    _maxBtn.frame = CGRectMake(WIDTH_RACE_6S(25), 46, WIDTH_RACE_6S(162), WIDTH_RACE_6S(111));
    [_maxBtn addTarget:self action:@selector(maxBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_maxBtn];
    
    _topMinBtn = [[TXXLCalculateMinButton alloc]init];
    _topMinBtn.frame = CGRectMake(SCREEN_WIDTH - WIDTH_RACE_6S(25) - WIDTH_RACE_6S(149), 46, WIDTH_RACE_6S(149), WIDTH_RACE_6S(53));
    [_topMinBtn addTarget:self action:@selector(minBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_topMinBtn];
    
    _bottonMinBtn = [[TXXLCalculateMinButton alloc]init];
    _bottonMinBtn.frame = CGRectMake(SCREEN_WIDTH - WIDTH_RACE_6S(25) - WIDTH_RACE_6S(149), 46 + WIDTH_RACE_6S(53) + WIDTH_RACE_6S(5), WIDTH_RACE_6S(149), WIDTH_RACE_6S(53));
    [_bottonMinBtn addTarget:self action:@selector(minBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_bottonMinBtn];
}
@end
