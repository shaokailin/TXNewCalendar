//
//  TXSMFortuneProgressView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneProgressView.h"
#import "TXSMProgressView.h"
@implementation TXSMFortuneProgressView
{
    ProgressType _type;
    UILabel *_timeLbl;
    TXSMProgressView *_jobView;
    TXSMProgressView *_healthView;
    TXSMProgressView *_loveView;
    TXSMProgressView *_moneyView;
    TXSMProgressView *_synView;
}
- (instancetype)initWithFrame:(CGRect)frame progressType:(ProgressType)type {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupScore:(NSDictionary *)dict time:(NSString *)time {
     _timeLbl.text = time;
    CGFloat chushu = 100.0;
    if (_type == ProgressType_Today) {
        [_synView setupValue:[[dict objectForKey:@"synthesize"]integerValue] / chushu ];
    }else {
        chushu = 10.0;
    }
    [_moneyView setupValue:[[dict objectForKey:@"fortune"]integerValue] / chushu];
    [_loveView setupValue:[[dict objectForKey:@"love"]integerValue] / chushu];
    [_jobView setupValue:[[dict objectForKey:@"work"]integerValue] / chushu];
    [_healthView setupValue:[[dict objectForKey:@"health"]integerValue] / chushu];
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 10);
    CGFloat leftMargin = WIDTH_RACE_6S(50);
    CGFloat barWith = 97;
    _jobView = [[TXSMProgressView alloc]initWithType:ProgressStyleType_Job];
    [self addSubview:_jobView];
    [_jobView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(leftMargin);
        make.size.mas_equalTo(CGSizeMake(barWith, 26));
        make.bottom.equalTo(self).with.offset(-17);
    }];
    _healthView = [[TXSMProgressView alloc]initWithType:ProgressStyleType_Health];
    [self addSubview:_healthView];
    [_healthView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(- leftMargin);
        make.width.height.centerY.equalTo(self->_jobView);
    }];

    _moneyView = [[TXSMProgressView alloc]initWithType:ProgressStyleType_Money];
    [self addSubview:_moneyView];
    [_moneyView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_jobView);
        make.width.height.equalTo(self->_jobView);
        make.bottom.equalTo(self->_jobView.mas_top).with.offset(-10);
    }];
    _loveView = [[TXSMProgressView alloc]initWithType:ProgressStyleType_Love];
    [self addSubview:_loveView];
    [_loveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_healthView);
        make.width.height.centerY.equalTo(self->_moneyView);
    }];
    _timeLbl = [TXXLViewManager customTitleLbl:nil font:10];
    [self addSubview:_timeLbl];
    if (_type == 1) {
        _timeLbl.textAlignment = 1;
        [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.bottom.equalTo(self->_moneyView.mas_top).with.offset(-22);
        }];
    }else {
        _synView = [[TXSMProgressView alloc]initWithType:ProgressStyleType_Synthesize];
        [self addSubview:_synView];
        [_synView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_moneyView);
            make.width.height.equalTo(self->_moneyView);
            make.bottom.equalTo(self->_moneyView.mas_top).with.offset(-10);
        }];
        [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self->_loveView);
            make.bottom.equalTo(self->_loveView.mas_top).with.offset(-22);
        }];
    }
    
}
@end
