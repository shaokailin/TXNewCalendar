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
    UILabel *_calendarNewLbl;
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
- (void)setupDateContent:(NSDate *)date {
    _date = date;
    _calendarNewLbl.text = NSStringFormat(@"公历%@",[date dateTransformToString:@"yyyy年MM月dd日"]);
    _calendarChinessLbl.text = NSStringFormat(@"%@%@",[date getChineseMonthString],[date getChineseDayString]);
    [self setupNilData];
}
- (void)setupNilData {
    _detailLbl.text = nil;
}
- (void)setupChinessDateData:(NSDictionary *)jinian week:(NSString *)week shengxiao:(NSString *)shengxiao nongli:(NSDictionary *)nongli {
    if ([nongli isKindOfClass:[NSDictionary class]]) {
        NSString *month = KJudgeIsNullData([nongli objectForKey:@"m"])?[nongli objectForKey:@"m"]:[_date getChineseMonthString];
        NSString *day = KJudgeIsNullData([nongli objectForKey:@"d"])?[nongli objectForKey:@"d"]:[_date getChineseDayString];
        _calendarChinessLbl.text = NSStringFormat(@"%@%@",month,day);
    }
    NSString *year = nil;
    NSString *month = @"";
    NSString *day = @"";
    NSString *weekend = KJudgeIsNullData(week)?week:[_date getWeekDate];
    NSString *shengxiaoString = KJudgeIsNullData(shengxiao)?shengxiao:[_date getZodiac];
    if ([jinian isKindOfClass:[NSDictionary class]]) {
        NSArray *yearArray = [jinian objectForKey:@"y"];
        if (KJudgeIsArrayAndHasValue(yearArray)) {
            year = [self reurnDateAppend:yearArray];
        }else {
            year = [_date getChinessYearString];
        }
        NSArray *monthArray = [jinian objectForKey:@"m"];
        if (KJudgeIsArrayAndHasValue(monthArray)) {
            month = NSStringFormat(@"%@月",[self reurnDateAppend:monthArray]);
        }
        NSArray *dayArray = [jinian objectForKey:@"d"];
        if (KJudgeIsArrayAndHasValue(dayArray)) {
            day = NSStringFormat(@"%@日",[self reurnDateAppend:dayArray]);
        }
    }
    _detailLbl.text = NSStringFormat(@"%@[%@]年  %@  %@ %@",year,shengxiaoString,month,day,weekend);
}
- (NSString *)reurnDateAppend:(NSArray *)array {
    return NSStringFormat(@"%@%@",[array objectAtIndex:0],(array.count > 1)?[array objectAtIndex:1]:@"");
}
- (void)_layoutMainView {
    UILabel *calendarNewLbl = [TXXLViewManager customTitleLbl:nil font:16];
    _calendarNewLbl = calendarNewLbl;
    [self addSubview:calendarNewLbl];
    WS(ws)
    [calendarNewLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws);
        make.centerX.equalTo(ws);
        make.height.mas_equalTo(46);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(calendarNewLbl.mas_bottom);
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
