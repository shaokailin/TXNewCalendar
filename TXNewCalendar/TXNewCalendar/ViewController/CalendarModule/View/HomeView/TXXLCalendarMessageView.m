//
//  TXXLCalendarMessageView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalendarMessageView.h"
@interface TXXLCalendarMessageView ()
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UILabel *suitLbl;
@property (nonatomic, weak) UILabel *avoidLbl;
@property (nonatomic, weak) UILabel *dateMessageLbl;
@property (nonatomic, weak) UILabel *dateDetailLbl;
@property (nonatomic, weak) UILabel *alertFirstLbl;
@property (nonatomic, weak) UILabel *alertLastLbl;
@end
@implementation TXXLCalendarMessageView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithDate:(NSDate *)date {
    KDateManager.searchDate = date;
    NSDictionary *yiji = [KDateManager getTgdzYiJiXiongJi];
    NSString *yiString = @"无";
    NSString *jiString = @"无";
    NSString *yi = [yiji objectForKey:@"yi"];
    if (KJudgeIsNullData(yi)) {
        yiString = [yi stringByReplacingOccurrencesOfString:@"、" withString:@"  "];
    }
    NSString *ji = [yiji objectForKey:@"ji"];
    if (KJudgeIsNullData(ji)) {
        jiString = [ji stringByReplacingOccurrencesOfString:@"、" withString:@"  "];
    }
    self.timeLbl.text = KDateManager.chineseDayString;
    self.suitLbl.text = yiString;
    self.avoidLbl.text = jiString;
    self.dateMessageLbl.text = NSStringFormat(@"%@%@ %@",[date dateTransformToString:@"MM月dd日"],KDateManager.weekString,[KDateManager getXingzuo]);
    self.dateDetailLbl.text = nil;
    NSDictionary *jieqi = [KDateManager getBetweenSolarterm];
    NSDictionary *firstDict = [jieqi objectForKey:@"first"];
    if (firstDict) {
        self.alertFirstLbl.text = [self transformTextForSolar:firstDict];
    }
    NSDictionary *lastDict = [jieqi objectForKey:@"last"];
    if (lastDict) {
        self.alertLastLbl.text = [self transformTextForSolar:lastDict];
    }
}
- (NSString *)transformTextForSolar:(NSDictionary *)dict {
    NSString *name = [dict objectForKey:@"title"];
    NSDate *date = [dict objectForKey:@"date"];
    return NSStringFormat(@"%@:  %@  %@  %@",name,[date dateTransformToString:@"MM月dd日"],[date getWeekDate],[date dateTransformToString:@"HH:mm"]);
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 5.0);
    UIView *lineView1 = [LSKViewFactory initializeLineView];
    [self addSubview:lineView1];
    WS(ws)
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(ws);
        make.top.equalTo(ws).with.offset(80);
        make.height.mas_equalTo(kLineView_Height);
    }];
    BOOL isWith320 = [LSKPublicMethodUtil getiPhoneType] < 2?YES:NO;
    UILabel *oldLbl = [TXXLViewManager customTitleLbl:nil font:isWith320?WIDTH_RACE_6S(40):40];
    self.timeLbl = oldLbl;
    [self addSubview:oldLbl];
    [oldLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.top.equalTo(ws);
        make.width.mas_equalTo(isWith320?WIDTH_RACE_6S(90):90);
        make.height.mas_equalTo(80);
    }];
    
    UILabel *suitTitleLbl = [LSKViewFactory initializeLableWithText:@"宜" font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(kText_LightGreen_Color, 1.0)];
    KViewBoundsRadius(suitTitleLbl, 15 / 2.0);
    [self addSubview:suitTitleLbl];
    [suitTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(oldLbl.mas_right).with.offset(12);
        make.top.equalTo(ws).with.offset(21);
        make.size.mas_equalTo(CGSizeMake(15, 15));
    }];
    
    UILabel *suitLbl = [TXXLViewManager customTitleLbl:nil font:13];
    self.suitLbl = suitLbl;
    [self addSubview:suitLbl];
    [suitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(suitTitleLbl.mas_right).with.offset(6);
        make.centerY.equalTo(suitTitleLbl);
        make.right.lessThanOrEqualTo(ws).with.offset(-5);
    }];
    
    
    UILabel *avoidTitleLbl = [LSKViewFactory initializeLableWithText:@"忌" font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(kAPP_Main_Color, 1.0)];
    KViewBoundsRadius(avoidTitleLbl, 15 / 2.0);
    [self addSubview:avoidTitleLbl];
    [avoidTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.width.height.equalTo(suitTitleLbl);
        make.top.equalTo(suitTitleLbl.mas_bottom).with.offset(15);
    }];
    UILabel *avoidLbl = [TXXLViewManager customTitleLbl:nil font:13];
    self.avoidLbl = avoidLbl;
    [self addSubview:avoidLbl];
    [avoidLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(suitLbl);
        make.centerY.equalTo(avoidTitleLbl);
        make.right.lessThanOrEqualTo(ws).with.offset(-5);
    }];
    
    UILabel *dateMessageLbl = [TXXLViewManager customTitleLbl:nil font:13];
    self.dateMessageLbl = dateMessageLbl;
    [self addSubview:dateMessageLbl];
    [dateMessageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(12);
        make.right.lessThanOrEqualTo(ws).with.offset(-10);
        make.top.equalTo(lineView1.mas_bottom).with.offset(16);
    }];
    UIView *lineView2 = [LSKViewFactory initializeLineView];
    [self addSubview:lineView2];
    [lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.height.equalTo(lineView1);
        make.top.equalTo(lineView1.mas_bottom).with.offset(50);//72
    }];
    
    UILabel *dateDetailLbl = [LSKViewFactory initializeLableWithText:nil font:13 textColor:KColorHexadecimal(0x848484, 1.0) textAlignment:0 backgroundColor:nil];
    self.dateDetailLbl = dateDetailLbl;
    [self addSubview:dateDetailLbl];
    [dateDetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateMessageLbl);
        make.right.lessThanOrEqualTo(ws).with.offset(-10);
        make.bottom.equalTo(lineView2.mas_top).with.offset(-14);
    }];
    
    UILabel *alert1Lbl = [TXXLViewManager customTitleLbl:nil font:13];
    self.alertFirstLbl = alert1Lbl;
    [self addSubview:alert1Lbl];
    [alert1Lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateMessageLbl);
        make.right.lessThanOrEqualTo(ws).with.offset(-10);
        make.top.equalTo(lineView2.mas_bottom).with.offset(14);
    }];
    
    UILabel *alert2Lbl = [TXXLViewManager customTitleLbl:nil font:13];
    self.alertLastLbl = alert2Lbl;
    [self addSubview:alert2Lbl];
    [alert2Lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(dateMessageLbl);
        make.right.lessThanOrEqualTo(ws).with.offset(-10);
        make.bottom.equalTo(ws.mas_bottom).with.offset(-14);
    }];
}

@end
