//
//  TXXLAlimanacHoursView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacHoursView.h"
#import "TXXLHourView.h"
@implementation TXXLAlmanacHoursView
{
    NSInteger _currentHour;
}
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithHours:(NSArray *)hours states:(NSArray *)states {
    NSInteger hourCount = hours.count;
    NSInteger stateCount = states.count;
    for (int i = 0; i < 12; i++) {
        TXXLHourView *hourView = [self viewWithTag:200 + i];
        NSString *hourString = nil;
        NSString *stateString = nil;
        if (i < hourCount) {
            hourString = [hours objectAtIndex:i];
            if (i < stateCount) {
                stateString = [states objectAtIndex:i];
            }
        }
        [hourView setupContentWithHour:hourString state:stateString];
    }
}
- (void)currentHourChange:(NSInteger)hour {
    if (hour >= 0) {
        if (hour != _currentHour) {
            if (_currentHour != -1) {
                TXXLHourView *hourView = [self viewWithTag:200 + _currentHour];
                hourView.isCurrent = NO;
            }
            _currentHour = hour;
            TXXLHourView *hourView = [self viewWithTag:200 + hour];
            hourView.isCurrent = YES;
        }
    }else if(_currentHour != -1 && hour == -1) {
        TXXLHourView *hourView = [self viewWithTag:200 + _currentHour];
        _currentHour = -1;
        hourView.isCurrent = NO;
    }
}
- (void)_layoutMainView {
    _currentHour = -1;
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"时辰\n宜忌" font:18];
    titleLbl.numberOfLines = 2;
    titleLbl.textAlignment = 2;
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.centerY.equalTo(ws);
        make.width.mas_equalTo(40);
    }];
    
    TXXLHourView *hour1 = [[TXXLHourView alloc]init];
    hour1.tag = 200;
    [self addSubview:hour1];
    [hour1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(titleLbl.mas_right).with.offset(5);
    }];
    
    TXXLHourView *hour2 = [[TXXLHourView alloc]init];
    hour2.tag = 201;
    [self addSubview:hour2];
    [hour2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour1.mas_right);
        make.width.equalTo(hour1);
    }];
    
    TXXLHourView *hour3 = [[TXXLHourView alloc]init];
    hour3.tag = 202;
    [self addSubview:hour3];
    [hour3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour2.mas_right);
        make.width.equalTo(hour2);
    }];
    
    TXXLHourView *hour4 = [[TXXLHourView alloc]init];
    hour4.tag = 203;
    [self addSubview:hour4];
    [hour4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour3.mas_right);
        make.width.equalTo(hour3);
    }];
    
    TXXLHourView *hour5 = [[TXXLHourView alloc]init];
    hour5.tag = 204;
    [self addSubview:hour5];
    [hour5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour4.mas_right);
        make.width.equalTo(hour4);
    }];
    
    TXXLHourView *hour6 = [[TXXLHourView alloc]init];
    hour6.tag = 205;
    [self addSubview:hour6];
    [hour6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour5.mas_right);
        make.width.equalTo(hour5);
    }];
    
    TXXLHourView *hour7 = [[TXXLHourView alloc]init];
    hour7.tag = 206;
    [self addSubview:hour7];
    [hour7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour6.mas_right);
        make.width.equalTo(hour6);
    }];
    
    TXXLHourView *hour8 = [[TXXLHourView alloc]init];
    hour8.tag = 207;
    [self addSubview:hour8];
    [hour8 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour7.mas_right);
        make.width.equalTo(hour7);
    }];
    
    TXXLHourView *hour9 = [[TXXLHourView alloc]init];
    hour9.tag = 208;
    [self addSubview:hour9];
    [hour9 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour8.mas_right);
        make.width.equalTo(hour8);
    }];
    
    TXXLHourView *hour10 = [[TXXLHourView alloc]init];
    hour10.tag = 209;
    [self addSubview:hour10];
    [hour10 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour9.mas_right);
        make.width.equalTo(hour9);
    }];
    
    TXXLHourView *hour11 = [[TXXLHourView alloc]init];
    hour11.tag = 210;
    [self addSubview:hour11];
    [hour11 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour10.mas_right);
        make.width.equalTo(hour10);
    }];
    TXXLHourView *hour12 = [[TXXLHourView alloc]init];
    hour12.tag = 211;
    [self addSubview:hour12];
    [hour12 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(ws);
        make.left.equalTo(hour11.mas_right);
        make.width.equalTo(hour11);
        make.right.equalTo(ws).with.offset(-5);
    }];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(showDetailClick)];
    [self addGestureRecognizer:tap];
}
- (void)showDetailClick {
    if (self.clickBlock) {
        self.clickBlock(0);
    }
}

@end
