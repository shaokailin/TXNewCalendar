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
@interface TXXLPublicFestivalView ()<UITableViewDelegate, UITableViewDataSource>
{
    NSDate *_currentDate;
}
@property (nonatomic, weak) UITableView *mainTableView;
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
    
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row % 2 == 0) {
        TXXLPublicFestivelCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLPublicFestivelCell];
        @weakify(self)
        cell.timeBlock = ^(id clickCell) {
            @strongify(self)
            [self addTimeClick:clickCell];
        };
        [cell setupCellContent:_currentDate title:@"腊八节" hasCount:@"剩余7天"];
        return cell;
    }else {
        TXXLPublicFestivelRightCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLPublicFestivelRightCell];
        @weakify(self)
        cell.timeBlock = ^(id clickCell) {
            @strongify(self)
            [self addTimeClick:clickCell];
        };
        [cell setupCellContent:_currentDate title:@"腊八节" hasCount:@"剩余7天"];
        return cell;
    }
   
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    _currentDate = [NSDate date];
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
