//
//  TXBZSMTomorrowLuckyView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTomorrowLuckyView.h"
#import "TXBZSMLuckAlertView.h"
@implementation TXBZSMTomorrowLuckyView
{
    TXBZSMLuckAlertView *_colorView;
    TXBZSMLuckAlertView *_moneyView;
    TXBZSMLuckAlertView *_loveView;
    UIView *_lineView1;
    UIView *_lineView2;
    NSInteger _type;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView:type];
    }
    return self;
}
- (CGFloat)returnContentHeight {
    return CGRectGetHeight(self.frame);
}
- (void)refreshData {
    CGFloat contentHeight = 33 + kLineView_Height;
    
    NSDate *date = [NSDate date];
    date = [date dateByAddingTimeInterval:(3600 * 24) *_type];
    TXBZSMHappyManager *manager = [TXBZSMHappyManager sharedInstance];
    NSDictionary *color = [manager getLuckColor:date bitrhDay:kUserMessageManager.birthDay];
    
    [_colorView setupContentWithTitle:[color objectForKey:@"title"] detail:[color objectForKey:@"detail"]];
    CGFloat height = [_colorView returnContentHeight];
    _colorView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    _lineView1.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, 5);
    contentHeight += 5;
    
    NSDictionary *moneyLove = [manager getMoneyAndLovePosition:date];
    NSDictionary *money = [moneyLove objectForKey:@"money"];
    [_moneyView setupContentWithTitle:[money objectForKey:@"title"] detail:[money objectForKey:@"detail"]];
    height = [_moneyView returnContentHeight];
    _moneyView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    _lineView2.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, 5);
    contentHeight += 5;
    
    NSDictionary *love = [moneyLove objectForKey:@"love"];
    [_loveView setupContentWithTitle:[love objectForKey:@"title"] detail:[love objectForKey:@"detail"]];
    height = [_loveView returnContentHeight];
    _loveView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;

    CGRect frame = self.frame;
    frame.size.height = contentHeight;
    self.frame = frame;
}
- (void)_layoutMainView:(NSInteger)type {
    self.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor whiteColor];
    UILabel *_titleLbl = [LSKViewFactory initializeLableWithText:@"开运提示" font:15 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _titleLbl.font = FontBoldInit(15);
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self);
        make.height.mas_equalTo(33);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(_titleLbl.mas_bottom);
        make.height.mas_equalTo(kLineView_Height);
    }];
    CGFloat contentHeight = 33 + kLineView_Height;
    
    _colorView = [[TXBZSMLuckAlertView alloc]initWithType:0];
    CGFloat height = 95;
    _colorView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_colorView];
    KViewRadius(_colorView, 5.0);
    contentHeight += height;
    _lineView1 = [LSKViewFactory initializeLineView];
    _lineView1.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, 5);
    [self addSubview:_lineView1];
    contentHeight += 5;
    
    _moneyView = [[TXBZSMLuckAlertView alloc]initWithType:1];
    _moneyView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_moneyView];
    KViewRadius(_moneyView, 5.0);
    contentHeight += height;
    _lineView2 = [LSKViewFactory initializeLineView];
    _lineView2.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, 5);
    [self addSubview:_lineView2];
    contentHeight += 5;
    
    _loveView = [[TXBZSMLuckAlertView alloc]initWithType:2];
    _loveView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_loveView];
    KViewRadius(_loveView, 5.0);
    contentHeight += height;
    
}

@end
