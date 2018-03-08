//
//  TXSMCircleFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCircleFortuneView.h"
#import "PPSSCircleProgress.h"
#import "TXSMCircleMessageView.h"
#import "TXSMFortuneNumberButton.h"
static const CGFloat kCircleWidth = 215;

@implementation TXSMCircleFortuneView
{
    PPSSCircleProgress *_progressView;
    TXSMCircleMessageView *_messageView;
    UILabel *_luckLbl;
    UILabel *_xingzuoLbl;
    UILabel *_colorLbl;
    NSInteger _type;
    TXSMFortuneNumberButton *_loveBtn;
    TXSMFortuneNumberButton *_careerBtn;
    TXSMFortuneNumberButton *_healthBtn;
    TXSMFortuneNumberButton *_moneyBtn;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent {
    [_messageView setupMessageWithName:@"双子座" time:@"5.21-6.20"];
    _messageView.presentValueLbl.text = @"50";
    _progressView.progress = 0.5;
    _xingzuoLbl.text = NSStringFormat(@"速配星座:  %@",@"处女");
    _luckLbl.text = NSStringFormat(@"幸运数字:  %@",@"10");
    _colorLbl.text = NSStringFormat(@"幸运颜色:  %@",@"红");
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 4.0);
    PPSSCircleProgress *progressView = [[PPSSCircleProgress alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 10 - kCircleWidth) / 2.0, 20, kCircleWidth, kCircleWidth)];
    progressView.strokeColor = KColorHexadecimal(0x1e9dff, 1.0);
    _progressView = progressView;
    [self addSubview:progressView];
   
    _messageView = [[TXSMCircleMessageView alloc]initWithType:_type];
    [self addSubview:_messageView];
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(progressView);
        make.size.mas_equalTo(CGSizeMake(175, 175));
    }];
    
     WS(ws)
    UILabel *luckNumLbl = [TXXLViewManager customDetailLbl:@"幸运数字:  " font:12];
    _luckLbl = luckNumLbl;
    [self addSubview:_luckLbl];
    [_luckLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(progressView.mas_bottom).with.offset(27);
    }];
    
    _colorLbl = [TXXLViewManager customDetailLbl:@"幸运颜色:  " font:12];
    [self addSubview:_colorLbl];
    [_colorLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(luckNumLbl);
        make.left.equalTo(luckNumLbl.mas_right).with.offset(15);
    }];
    
    _xingzuoLbl = [TXXLViewManager customDetailLbl:@"速配星座:  " font:12];
    [self addSubview:_xingzuoLbl];
    [_xingzuoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(luckNumLbl);
        make.right.equalTo(luckNumLbl.mas_left).with.offset(-15);
    }];
    
    CGFloat width = WIDTH_RACE_6S(82);
    CGFloat height = WIDTH_RACE_6S(55);
    CGFloat between = (SCREEN_WIDTH - width * 4 - 15 - 10) / 5.0;
    _loveBtn = [[TXSMFortuneNumberButton alloc]initWithType:0];
    [self addSubview:_loveBtn];
    [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    _careerBtn = [[TXSMFortuneNumberButton alloc]initWithType:1];
    [self addSubview:_careerBtn];
    [_careerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 2 + width);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    _healthBtn = [[TXSMFortuneNumberButton alloc]initWithType:2];
    [self addSubview:_healthBtn];
    [_healthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 3 + width * 2);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    _moneyBtn = [[TXSMFortuneNumberButton alloc]initWithType:3];
    [self addSubview:_moneyBtn];
    [_moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 4 + width * 3);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    [self setupContent];
}
@end
