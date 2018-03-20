//
//  TXXLAlmanacDateView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacDateView.h"

@implementation TXXLAlmanacDateView
{
    UIButton *_calendarNewBtn;
    UILabel *_calendarChinessLbl;
    UILabel *_detailLbl;
    NSDate *_date;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)selectDateClick {
    if (self.changeDateBlock) {
        self.changeDateBlock(2);
    }
}
- (void)setupDateContent:(NSDate *)date {
    _date = date;
    [_calendarNewBtn setTitle:NSStringFormat(@"公历%@",[date dateTransformToString:@"yyyy年MM月dd日"]) forState:UIControlStateNormal];
    _calendarChinessLbl.text = NSStringFormat(@"%@%@",KDateManager.chineseMonthString,KDateManager.chineseDayString);
    _detailLbl.text = NSStringFormat(@"%@年  %@月  %@日 %@",KDateManager.tgdzString,[KDateManager getGanzhiMouth],[KDateManager getGanzhiDay],[_date getWeekDate]);;
}
- (void)_layoutMainView {
    _calendarNewBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(selectDateClick) textfont:16 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    [self addSubview:_calendarNewBtn];
    WS(ws)
    [_calendarNewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws);
        make.centerX.equalTo(ws);
        make.height.mas_equalTo(46);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(ws).with.offset(46);
        make.height.mas_equalTo(1);
    }];
    UILabel *calendarChinessLbl = [TXXLViewManager customTitleLbl:nil font:40];
    _calendarChinessLbl = calendarChinessLbl;
    [self addSubview:calendarChinessLbl];
    [calendarChinessLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom).with.offset(26);
        make.centerX.equalTo(ws);
    }];
    UIButton *leftBtn = [LSKViewFactory initializeButtonNornalImage:@"date_arrow_left" selectedImage:nil target:self action:@selector(prevDateClick)];
    [self addSubview:leftBtn];
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(calendarChinessLbl.mas_left).with.offset(-47);
        make.top.equalTo(calendarChinessLbl.mas_top).with.offset(-1);
        make.size.mas_equalTo(CGSizeMake(25, 39));
    }];
    UIButton *rightBtn = [LSKViewFactory initializeButtonNornalImage:@"date_arrow_right" selectedImage:nil target:self action:@selector(nextDateClick)];
    [self addSubview:rightBtn];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(calendarChinessLbl.mas_right).with.offset(47);
        make.top.equalTo(leftBtn.mas_top);
        make.width.height.equalTo(leftBtn);
    }];
    
    UILabel *detailLbl = [TXXLViewManager customTitleLbl:nil font:11];
    _detailLbl = detailLbl;
    [self addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.bottom.equalTo(ws).with.offset(-17);
    }];
}
- (void)prevDateClick {
    if (self.changeDateBlock) {
        self.changeDateBlock(0);
    }
}
- (void)nextDateClick {
    if (self.changeDateBlock) {
        self.changeDateBlock(1);
    }
}
@end
