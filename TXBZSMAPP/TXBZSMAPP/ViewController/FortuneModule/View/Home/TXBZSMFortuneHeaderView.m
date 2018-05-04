//
//  TXBZSMFortuneHeaderView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMFortuneHeaderView.h"
#import "TXBZSMHotSelectView.h"
#import "TXBZSMUserMessageView.h"
#import "TXBZSMTodayFortuneView.h"
#import "TXBZSMBlessPlatformView.h"
@implementation TXBZSMFortuneHeaderView
{
    TXBZSMHotSelectView *_hotSelectView;
    TXBZSMUserMessageView *_userMessageView;
    TXBZSMTodayFortuneView *_todayView;
    TXBZSMBlessPlatformView *_blessView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}

- (void)setupHotData:(NSArray *)array {
    if (KJudgeIsArrayAndHasValue(array)) {
        NSDictionary *dict = [array objectAtIndex:0];
        [_hotSelectView setupContentWithImg:[dict objectForKey:@"image"]];
    }
}
- (void)setupTodayData:(NSDictionary *)dict {
    [_todayView setupContent:dict];
}
- (void)hotEventClick{
    if (self.eventBlock) {
        self.eventBlock(3);
    }
}
- (void)blessEventClick {
    if (self.eventBlock) {
        self.eventBlock(4);
    }
}
- (void)todayEventClick {
    if (self.eventBlock) {
        self.eventBlock(2);
    }
}
- (void)userEventClick {
    if (self.eventBlock) {
        self.eventBlock(1);
    }
}
- (void)_layoutMainView {
    [self customMessageView];
    [self customToday];
    [self customHotView];
    [self customBlessView];
}

- (void)customMessageView {
    NSArray *userXibs =  [[NSBundle mainBundle] loadNibNamed:@"TXBZSMUserMessageView"owner:self options:nil];
    _userMessageView = [userXibs objectAtIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(userEventClick)];
    [_userMessageView addGestureRecognizer:tap];
    KViewRadius(_userMessageView, 5);
    [self addSubview:_userMessageView];
    [_userMessageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.top.equalTo(self);
        make.width.mas_equalTo(SCREEN_WIDTH - 10);
        make.height.mas_equalTo(152);
    }];
}
- (void)customToday {
    NSArray *todayXibs =  [[NSBundle mainBundle] loadNibNamed:@"TXBZSMTodayFortuneView"owner:self options:nil];
    _todayView = [todayXibs objectAtIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(todayEventClick)];
    [_todayView addGestureRecognizer:tap];
    KViewRadius(_todayView, 5);
    [self addSubview:_todayView];
    [_todayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_userMessageView);
        make.top.equalTo(self->_userMessageView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(202);
    }];
}
- (void)customHotView {
    NSArray *hotXibs =  [[NSBundle mainBundle] loadNibNamed:@"TXBZSMHotSelectView"owner:self options:nil];
    _hotSelectView = [hotXibs objectAtIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hotEventClick)];
    [_hotSelectView addGestureRecognizer:tap];
    KViewRadius(_hotSelectView, 5);
    [self addSubview:_hotSelectView];
    [_hotSelectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_userMessageView);
        make.top.equalTo(self->_todayView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(195);
    }];
}
- (void)customBlessView {
    NSArray *blessXibs =  [[NSBundle mainBundle] loadNibNamed:@"TXBZSMBlessPlatformView"owner:self options:nil];
    _blessView = [blessXibs objectAtIndex:0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blessEventClick)];
    [_blessView addGestureRecognizer:tap];
    KViewRadius(_blessView, 5);
    [self addSubview:_blessView];
    [_blessView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_userMessageView);
        make.top.equalTo(self->_hotSelectView.mas_bottom).with.offset(5);
        make.height.mas_equalTo(183);
    }];
}
@end
