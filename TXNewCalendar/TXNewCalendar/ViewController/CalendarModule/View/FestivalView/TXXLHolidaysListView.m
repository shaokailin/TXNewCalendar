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
    NSDictionary *_dataDiction;
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
- (void)pullDownRefresh {
    if (self.loadBlock) {
        self.loadBlock(YES);
    }
}
- (void)selectCurrentView {
    if (!_dataDiction) {
        if (self.loadBlock) {
            self.loadBlock(NO);
        }
    }
}
- (void)loadError {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)loadSucess:(id)data {
    _dataDiction = data;
    [self.mainTableView reloadData];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if ([_dataDiction isKindOfClass:[NSDictionary class]]) {
        NSString *key = [_dataDiction.allKeys objectAtIndex:0];
        NSArray *data = [_dataDiction objectForKey:key];
        if (KJudgeIsArrayAndHasValue(data)) {
            return data.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLHolidaysTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLHolidaysTableViewCell];
    NSString *key = [_dataDiction.allKeys objectAtIndex:0];
    NSArray *data = [_dataDiction objectForKey:key];
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"title"] monthDay:[dict objectForKey:@"ri"] date:NSStringFormat(@"%@年%@  %@",key,[dict objectForKey:@"nongli"],[dict objectForKey:@"week"]) week:[dict objectForKey:@"week"] hasCount:[dict objectForKey:@"tian"]];
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
    if ([_dataDiction isKindOfClass:[NSDictionary class]]) {
        NSString *key = [_dataDiction.allKeys objectAtIndex:0];
        [headerView setupTitle:NSStringFormat(@"%@年",key)];
    }else {
        [headerView setupTitle:@""];
    }
    
    return headerView;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    return nil;
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    self.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStyleGrouped separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(0xf7f7f7, 1.0)];
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
