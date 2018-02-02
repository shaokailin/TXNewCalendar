//
//  TXXLSearchDetailCell.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchDetailCell.h"
@interface TXXLSearchDetailCell ()
{
    BOOL _isWeekend;
}
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak)UILabel *yearMonthLbl;
@property (nonatomic, weak)UILabel *dayLbl;
@property (nonatomic, weak)UILabel *weekLbl;
@property (nonatomic, weak)UILabel *chinessMonthDayLbl;
@property (nonatomic, weak)UILabel *chinessYearLbl;
@property (nonatomic, weak)UILabel *hasCountDayLbl;
@property (nonatomic, weak)UILabel *godLbl;
@property (nonatomic, weak)UILabel *twelveGodLbl;
@property (nonatomic, weak)UILabel *constellationLbl;
@end
@implementation TXXLSearchDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)addTimeClick {
    if (self.timeBlock) {
        self.timeBlock(self);
    }
}
- (void)setupCellContentWithDay:(NSString *)day yearMonth:(NSString *)yearMonth nongli:(NSString *)nongli chinessYMD:(NSString *)chinessYMD week:(NSString *)week count:(NSString *)count god:(NSString *)god twelveGod:(NSString *)twelveGod constellation:(NSString *)constellation isHidenLine:(BOOL)isHiden {
    _dayLbl.text = day;
    _yearMonthLbl.text = yearMonth;
    _weekLbl.text = week;
    _chinessYearLbl.text = chinessYMD;
    _chinessMonthDayLbl.text = nongli;
    _hasCountDayLbl.text = NSStringFormat(@"%@天后",count);
    _godLbl.text = god;
    _twelveGodLbl.text = twelveGod;
    _constellationLbl.text = constellation;
    BOOL isWeekend = ([week isEqualToString:@"星期天"] || [week isEqualToString:@"星期日"] || [week isEqualToString:@"星期六"]);
    if (isWeekend != _isWeekend) {
        _isWeekend = isWeekend;
        [self changeTextColor];
    }
    self.lineView.hidden = isHiden;
}
- (void)changeTextColor {
    UIColor *color = _isWeekend ? KColorHexadecimal(kAPP_Main_Color, 1.0):KColorHexadecimal(kText_Green_Color, 1.0);
    self.dayLbl.textColor = color;
    self.yearMonthLbl.textColor = color;
    self.weekLbl.textColor = color;
}

- (void)_layoutMainView {
    _isWeekend = NO;
    self.selectionStyle = 0;
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    UIView *conView = [[UIView alloc]init];
    conView.backgroundColor = [UIColor whiteColor];
    UILabel *dayLbl = [LSKViewFactory initializeLableWithText:nil font:30 textColor:KColorHexadecimal(kText_Green_Color, 1.0) textAlignment:1 backgroundColor:nil];
    self.dayLbl = dayLbl;
    [conView addSubview:dayLbl];
    [dayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView.mas_left).with.offset(34);
        make.centerY.equalTo(conView);
    }];
    
    UILabel *yearMonthLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(kText_Green_Color, 1.0) textAlignment:1 backgroundColor:nil];
    self.yearMonthLbl = yearMonthLbl;
    [conView addSubview:yearMonthLbl];
    [yearMonthLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(dayLbl.mas_top).with.offset(-3);
        make.centerX.equalTo(dayLbl);
    }];
    
    UILabel *weekLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(kText_Green_Color, 1.0) textAlignment:1 backgroundColor:nil];
    self.weekLbl = weekLbl;
    [conView addSubview:weekLbl];
    [weekLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(dayLbl.mas_bottom).with.offset(3);
        make.centerX.equalTo(dayLbl);
    }];
    
    UILabel *chinessMonthDayLbl = [TXXLViewManager customTitleLbl:nil font:17];
    self.chinessMonthDayLbl = chinessMonthDayLbl;
    [conView addSubview:chinessMonthDayLbl];
    [chinessMonthDayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dayLbl.mas_right).with.offset(42);
        make.top.equalTo(conView).with.offset(18);
    }];
    UILabel *hasCountDayLbl = [TXXLViewManager customTitleLbl:nil font:11];
    self.hasCountDayLbl = hasCountDayLbl;
    [conView addSubview:hasCountDayLbl];
    [hasCountDayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(chinessMonthDayLbl);
        make.right.equalTo(conView).with.offset(-15);
    }];
    
    UILabel *chinessYearLbl = [TXXLViewManager customTitleLbl:nil font:12];
    self.chinessYearLbl = chinessYearLbl;
    [conView addSubview:chinessYearLbl];
    [chinessYearLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chinessMonthDayLbl);
        make.top.equalTo(chinessMonthDayLbl.mas_bottom).with.offset(14);
    }];
    
    UILabel *godLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0xb3b3b3, 1.0) textAlignment:0 backgroundColor:nil];
    self.godLbl = godLbl;
    [conView addSubview:godLbl];
    [godLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chinessMonthDayLbl);
        make.top.equalTo(chinessYearLbl.mas_bottom).with.offset(14);
    }];
    
    UILabel *twelveGodLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0xb3b3b3, 1.0) textAlignment:0 backgroundColor:nil];
    self.twelveGodLbl = twelveGodLbl;
    [conView addSubview:twelveGodLbl];
    [twelveGodLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(godLbl.mas_right).with.offset(28);
        make.centerY.equalTo(godLbl);
    }];
    UILabel *constellationLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0xb3b3b3, 1.0) textAlignment:0 backgroundColor:nil];
    self.constellationLbl = constellationLbl;
    [conView addSubview:constellationLbl];
    [constellationLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chinessMonthDayLbl);
        make.top.equalTo(godLbl.mas_bottom).with.offset(14);
    }];
    
    UIButton *addTimeBtn = [LSKViewFactory initializeButtonNornalImage:@"addTime" selectedImage:nil target:self action:@selector(addTimeClick)];
    [conView addSubview:addTimeBtn];
    [addTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(conView).with.offset(-7.5);
        make.centerY.equalTo(constellationLbl);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    [self.contentView addSubview:conView];
    WS(ws)
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 10, 0, 10));
    }];
    
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KColorHexadecimal(0xd3d3d3, 1.0);
    self.lineView = lineView;
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(conView);
        make.height.mas_equalTo(1);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
