//
//  TXXLSearchDetailVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchDetailVC.h"
#import "TXXLSearchDetailCell.h"
#import "TXXLSearchDetailHeaderView.h"
@interface TXXLSearchDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *_startDate;
    NSDate *_endDate;
    TimeState _timeState;
    BOOL _isOnlyWeekend;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXXLSearchDetailHeaderView *headerView;
@end

@implementation TXXLSearchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.titleString;
    [self addNavigationBackButton];
    [self initializeMainView];
}
#pragma mark - 私有事件
//选择时间事件
- (void)selectTimeWithState:(TimeState)state {
    _timeState = state;
}
// 开关查看是否只是周末
- (void)changeIsShowWeekend:(BOOL)isOnly {
    _isOnlyWeekend = isOnly;
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSearchDetailCell];
    BOOL isHiden = indexPath.row == 4;
    [cell setupCellContentWithDate:_startDate count:6 god:@"值神:天德" twelveGod:@"十二神：满日" constellation:@"星宿：尾火虎宿星" isHidenLine:isHiden];
    return cell;
}
#pragma makr - 初始化界面
- (void)initializeMainView {
    _startDate = [NSDate getTodayDate];
    _endDate = [_startDate dateByAddingTimeInterval:180 * (60 * 60 * 24)];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(0xededed, 1.0)];
    [tableView registerClass:[TXXLSearchDetailCell class] forCellReuseIdentifier:kTXXLSearchDetailCell];
    tableView.rowHeight = 140;
    _headerView = [[TXXLSearchDetailHeaderView alloc]init];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 197);
    _headerView.titleString = self.titleString;
    tableView.tableHeaderView = _headerView;
    @weakify(self)
    _headerView.headerBlock = ^(TimeState state, NSInteger type) {
        @strongify(self)
        if (type == 0) {
            [self selectTimeWithState:state];
        }else {
            [self changeIsShowWeekend:state];
        }
    };
    [_headerView setupDescribe:@"出行：外出旅游，观光浏览。" count:25];
    [_headerView setupStartTime:_startDate endTime:_endDate];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
