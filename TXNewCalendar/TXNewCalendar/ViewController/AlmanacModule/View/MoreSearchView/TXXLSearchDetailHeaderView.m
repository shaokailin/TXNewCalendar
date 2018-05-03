//
//  TXXLSearchDetailHeaderView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchDetailHeaderView.h"

@implementation TXXLSearchDetailHeaderView
{
    UIButton *_startTimeBtn;
    UIButton *_endTimeBtn;
    UILabel *_detailLbl;
    UILabel *_countLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
#pragma mark method
- (void)onlyShowWeekend:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (self.headerBlock) {
        self.headerBlock(btn.selected, 1);
    }
}
- (void)selectTime:(UIButton *)btn {
    if (self.headerBlock) {
        if (btn == _startTimeBtn) {
            self.headerBlock(TimeState_Start, 0);
        }else {
            self.headerBlock(TimeState_End, 0);
        }
    }
}
- (void)setupStartTime:(NSDate *)startDate endTime:(NSDate *)endDate {
    if (startDate) {
        KDateManager.searchDate = startDate;
        [_startTimeBtn setTitle:NSStringFormat(@"开始%@  %@  %@%@",[startDate dateTransformToString:@"yyyy.MM.dd"],[startDate getWeekDate],KDateManager.chineseMonthString,KDateManager.chineseDayString) forState: UIControlStateNormal];
    }
    if (endDate) {
        KDateManager.searchDate = endDate;
        [_endTimeBtn setTitle:NSStringFormat(@"结束%@  %@  %@%@",[endDate dateTransformToString:@"yyyy.MM.dd"],[endDate getWeekDate],KDateManager.chineseMonthString,KDateManager.chineseDayString) forState: UIControlStateNormal];
    }
}
- (void)setupDescribe:(NSString *)describe count:(NSInteger)count {
    _detailLbl.text = describe;
    [self setupCountAttribute:count];
}
- (void)setupCountAttribute:(NSInteger)count {
    NSString *content = NSStringFormat(@"近期%@的日子共有%ld天",self.titleString,(long)count);
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:content];
    [attributedString addAttribute:NSForegroundColorAttributeName value:KColorHexadecimal(kAPP_Main_Color, 1.0) range:NSMakeRange(7 + self.titleString.length , content.length - 1 - 7 - self.titleString.length)];
    _countLbl.attributedText = attributedString;
}
#pragma mark - init
- (void)_layoutMainView {
    UIView *topView = [[UIView alloc]init];
    topView.backgroundColor = [UIColor whiteColor];
    UIButton *switchBtn = [LSKViewFactory initializeButtonNornalImage:@"close_showweak" selectedImage:@"open_showweak" target:self action:@selector(onlyShowWeekend:)];
    [topView addSubview:switchBtn];
    CGFloat rightBetween = [LSKPublicMethodUtil getiPhoneType] > 1 ? 25:15;
    [switchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(topView).with.offset(- rightBetween);
        make.size.mas_equalTo(CGSizeMake(54, 28));
        make.centerY.equalTo(topView);
    }];
    CGFloat lineBetween = [LSKPublicMethodUtil getiPhoneType] > 1 ? 15:10;
    UIView *lineView1 = [LSKViewFactory initializeLineView];
    [topView addSubview:lineView1];
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(switchBtn.mas_left).with.offset(-lineBetween);
        make.centerY.equalTo(topView);
        make.size.mas_equalTo(CGSizeMake(1, 50));
    }];
    UIView *lineView2 = [LSKViewFactory initializeLineView];
    [topView addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(lineView1.mas_left).with.offset(-lineBetween);
        make.centerY.equalTo(topView);
        make.left.equalTo(topView).with.offset(10);
        make.height.mas_equalTo(1);
    }];
    
    _startTimeBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(selectTime:) textfont:WIDTH_RACE_6S(16) textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    _startTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topView addSubview:_startTimeBtn];
    [_startTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2);
        make.right.equalTo(lineView2).with.offset(5);
        make.bottom.equalTo(lineView2.mas_top);
        make.top.equalTo(topView);
    }];
    _endTimeBtn = [LSKViewFactory initializeButtonWithTitle:nil target:self action:@selector(selectTime:) textfont:WIDTH_RACE_6S(16) textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    _endTimeBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [topView addSubview:_endTimeBtn];
    [_endTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(lineView2);
        make.right.equalTo(lineView2).with.offset(5);
        make.top.equalTo(lineView2.mas_bottom);
        make.bottom.equalTo(topView);
    }];
    
    [self addSubview:topView];
    WS(ws)
    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH, 100));
    }];
    
    UIView *bottomView = [[UIView alloc]init];
    bottomView.backgroundColor = [UIColor whiteColor];
    
    UILabel *detailLbl = [TXXLViewManager customTitleLbl:nil font:18];
    detailLbl.textAlignment = 1;
    detailLbl.numberOfLines = 2;
    _detailLbl = detailLbl;
    [bottomView addSubview:detailLbl];
    [detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bottomView).with.offset(10);
        make.right.equalTo(bottomView).with.offset(-10);
        make.top.equalTo(bottomView).with.offset(13);
    }];
    
    _countLbl = [TXXLViewManager customDetailLbl:nil font:12];
    [bottomView addSubview:_countLbl];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(detailLbl.mas_bottom).with.offset(13);
        make.centerX.equalTo(detailLbl);
    }];
    
    
    [self addSubview:bottomView];
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(topView);
        make.top.equalTo(topView.mas_bottom).with.offset(5);
        make.bottom.equalTo(ws).with.offset(-5);
    }];
}

@end
