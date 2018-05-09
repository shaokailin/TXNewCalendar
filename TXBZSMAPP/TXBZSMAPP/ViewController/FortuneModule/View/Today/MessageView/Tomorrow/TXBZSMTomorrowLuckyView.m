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
    contentHeight += 5;
    
    NSDictionary *moneyLove = [manager getMoneyAndLovePosition:date];
    NSDictionary *money = [moneyLove objectForKey:@"money"];
    [_moneyView setupContentWithTitle:[money objectForKey:@"title"] detail:[money objectForKey:@"detail"]];
    height = [_moneyView returnContentHeight];
    _moneyView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
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
    self.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    KViewRadius(bgView, 5.0);
    [self addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(33);
    }];
    UILabel *_titleLbl = [LSKViewFactory initializeLableWithText:@"开运提示" font:15 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:[UIColor whiteColor]];
    _titleLbl.font = FontBoldInit(15);
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(15);
        make.top.equalTo(self);
        make.height.mas_equalTo(33);
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.bottom.equalTo(bgView.mas_bottom);
        make.height.mas_equalTo(5);
    }];
    UIView *lineView3 = [[UIView alloc]init];
    lineView3.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView3];
    [lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(bgView.mas_bottom).with.offset(kLineView_Height);
        make.height.mas_equalTo(5);
    }];
    
    CGFloat contentHeight = 33 + kLineView_Height;
    
    _colorView = [[TXBZSMLuckAlertView alloc]initWithType:0];
    CGFloat height = 95;
    _colorView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_colorView];
    
    contentHeight += height;
    contentHeight += 5;
    
    _moneyView = [[TXBZSMLuckAlertView alloc]initWithType:1];
    _moneyView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_moneyView];
    contentHeight += height;
    contentHeight += 5;
    
    _loveView = [[TXBZSMLuckAlertView alloc]initWithType:2];
    _loveView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH - 10, height);
    [self addSubview:_loveView];
    
    contentHeight += height;
    KViewRadius(_colorView, 5.0);
    KViewRadius(_loveView, 5.0);
    KViewRadius(_moneyView, 5.0);
}

@end
