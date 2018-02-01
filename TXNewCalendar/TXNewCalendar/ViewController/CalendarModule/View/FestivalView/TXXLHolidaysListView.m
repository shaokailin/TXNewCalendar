//
//  TXXLHolidaysListView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHolidaysListView.h"
#import "TXXLHolidaysTableViewCell.h"
#import "TXXLHolidaysHeaderView.h"
@interface TXXLHolidaysListView ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDate *_currentDate;
}
@property (nonatomic, weak) UITableView *mainTableView;
@end
@implementation TXXLHolidaysListView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
#pragma mark - delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 7;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLHolidaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLHolidaysTableViewCell];
    [cell setupCellContent:@"腊八节" date:_currentDate hasCount:@"7天"];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 25;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0.001;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    TXXLHolidaysHeaderView *headerView = [[TXXLHolidaysHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 25)];
    [headerView setupTitle:@"2018年"];
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    _currentDate = [NSDate date];
    self.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStyleGrouped separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(0xf7f7f7, 1.0)];
    [tableView registerClass:[TXXLHolidaysTableViewCell class] forCellReuseIdentifier:kTXXLHolidaysTableViewCell];
    tableView.rowHeight = 62;
    tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 7)];
    self.mainTableView = tableView;
    [self addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
}

@end
