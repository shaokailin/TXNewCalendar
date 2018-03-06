//
//  TXXLPublicFestivalView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLPublicFestivalView.h"
#import "TXXLPublicFestivelCell.h"
#import "TXXLPublicFestivelRightCell.h"
#import "TXXLSolarTermAndFestivalVM.h"
@interface TXXLPublicFestivalView ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, weak) TXXLSolarTermAndFestivalVM *viewModel;
@end
@implementation TXXLPublicFestivalView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
        
    }
    return self;
}
#pragma mark - 事件
- (void)addTimeClick:(TXXLPublicFestivelCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *dateString = [dict objectForKey:@"date"];
    if (KJudgeIsNullData(dateString)) {
        NSDate *date = [NSDate stringTransToDate:dateString withFormat:@"yyyy年MM月dd日"];
        NSDate *maxDate = [NSDate stringTransToDate:kCalendarMaxDate withFormat:kCalendarFormatter];
        if (date && [date timeIntervalSinceDate:maxDate] < 0) {
            [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kCalendarDateChange object:nil userInfo:@{@"date":date}];
            if (self.popBlock) {
                self.popBlock(YES);
            }
        }
    }
}
- (void)selectCurrentView {
    if (!KJudgeIsArrayAndHasValue(_dataArray)) {
        KDateManager.searchDate = self.date;
        _dataArray = [KDateManager getHolidayList:NO];
        [self.mainTableView reloadData];
    }
}
- (void)loadError {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)loadSucess:(id)data {
    _dataArray = data;
    [self.mainTableView reloadData];
    [self loadError];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (KJudgeIsArrayAndHasValue(_dataArray)) {
        return _dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *timeString = [dict objectForKey:@"date"];
    NSString *titleString = [dict objectForKey:@"title"];
    NSString *week = [dict objectForKey:@"week"];
    NSString *hasCount = NSStringFormat(@"剩余%@天",[dict objectForKey:@"day"]);
    if (indexPath.row % 2 == 0) {
        TXXLPublicFestivelCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLPublicFestivelCell];
        @weakify(self)
        cell.timeBlock = ^(id clickCell) {
            @strongify(self)
            [self addTimeClick:clickCell];
        };
        [cell setupContentWithDate:timeString week:week title:titleString hasCount:hasCount];
        return cell;
    }else {
        TXXLPublicFestivelRightCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLPublicFestivelRightCell];
        @weakify(self)
        cell.timeBlock = ^(id clickCell) {
            @strongify(self)
            [self addTimeClick:clickCell];
        };
        [cell setupContentWithDate:timeString week:week title:titleString hasCount:hasCount];
        return cell;
    }
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UITableView *tabbleView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    tabbleView.rowHeight = 190 / 2.0;
    [tabbleView registerClass:[TXXLPublicFestivelCell class] forCellReuseIdentifier:kTXXLPublicFestivelCell];
    [tabbleView registerClass:[TXXLPublicFestivelRightCell class] forCellReuseIdentifier:kTXXLPublicFestivelRightCell];
    tabbleView.tableFooterView = [self customLineView];
    tabbleView.tableHeaderView = [self customLineView];
    self.mainTableView = tabbleView;
    [self addSubview:tabbleView];
    WS(ws)
    [tabbleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
}
- (UIView *)customLineView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 15)];
    view.backgroundColor = [UIColor whiteColor];
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 2) / 2.0, 0, 2, 15)];
    lineView.backgroundColor = KColorHexadecimal(0xd3d3d3, 1.0);
    [view addSubview:lineView];
    return view;
}

@end
