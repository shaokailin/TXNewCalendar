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
#import "HSPDatePickView.h"
static const CGFloat kMaxTimeBetween = 180 * 24 * 60 * 60;
@interface TXXLSearchDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *_startDate;
    NSDate *_endDate;
    TimeState _timeState;
    BOOL _isWeekend;
    NSString *_titleDetail;
}
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXXLSearchDetailHeaderView *headerView;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@end

@implementation TXXLSearchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSStringFormat(@"%@%@",self.isAvoid?@"忌":@"宜",self.titleString);
    [self addNavigationBackButton];
    [self initializeMainView];
    [kUserMessageManager setupViewProperties:self url:nil name:self.titleString];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
#pragma mark - 网络请求
- (void)getDataWithWeek {
    NSTimeInterval time = [_endDate timeIntervalSinceDate:_startDate];
    NSInteger count = (NSInteger)time / (60 * 60 * 24);
    NSArray *data = [KDateManager getSearshList:_startDate timeBetween:count key:self.titleString isWeek:_isWeekend isAvoid:self.isAvoid];
    self.dataArray = data;
    [self.mainTableView reloadData];
    [self.headerView setupDescribe:_titleDetail count:self.dataArray.count];
}

- (void)clickTimeAdd:(TXXLSearchDetailCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *dateString = [dict objectForKey:@"date"];
    NSDate *date = [NSDate stringTransToDate:dateString withFormat:kCalendarFormatter];
    if (date) {
        [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kAlmanacDateChange object:nil userInfo:@{@"date":date}];
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}
#pragma mark - 私有事件
//选择时间事件
- (void)selectTimeWithState:(TimeState)state {
    _timeState = state;
    [self.datePickView showInView];
}
- (void)datePickSelect:(NSDate *)date {
    if (_timeState == TimeState_Start) {//
        NSInteger state = [self compareTime:date right:_endDate];
        if (state != 0) {//-1 开始时间小于结束时间
            [self.datePickView cancleSelectedClick];
            if (state == 1) {
                _startDate = _endDate;
                _endDate = date;
            }else {
                _startDate = date;
            }
            [self.headerView setupStartTime:_startDate endTime:_endDate];
            [self getDataWithWeek];
        }
    }else {
        NSInteger state = [self compareTime:_startDate right:date];
        if (state != 0) {// -1 开始时间 比 结束时间小
            [self.datePickView cancleSelectedClick];
            if (state == 1) {
                _endDate = _startDate;
                _startDate = date;
            }else {
                _endDate = date;
            }
            [self.headerView setupStartTime:_startDate endTime:_endDate];
            [self getDataWithWeek];
        }
    }
}
- (NSInteger)compareTime:(NSDate *)leftDate right:(NSDate *)rightDate {
    NSTimeInterval timebetween = [leftDate timeIntervalSinceDate:rightDate];
    if (fabs(timebetween) > kMaxTimeBetween) {
        [SKHUD showMessageInWindowWithMessage:@"查看的时间间隔只能在180内"];
        return 0;
    }else {
        if (timebetween >= 0) {
            return 1;
        }else {
            return -1;
        }
    }
}
// 开关查看是否只是周末
- (void)changeIsShowWeekend:(BOOL)isOnly {
    _isWeekend = isOnly;
    [self getDataWithWeek];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataArray) {
        return self.dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSearchDetailCell];
    BOOL isHiden = indexPath.row == self.dataArray.count - 1;
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *date = [dict objectForKey:@"date"];
    NSArray *dateArray = [date componentsSeparatedByString:@"-"];
    NSString *day = [dateArray objectAtIndex:2];
    NSString *yearMonth = NSStringFormat(@"%@.%@",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]);
    NSString *chinessYMD = NSStringFormat(@"%@[%@]年  %@月  %@日",[dict objectForKey:@"nlYeargz"],[dict objectForKey:@"nlYeargz"],[dict objectForKey:@"shengxiao"],[dict objectForKey:@"nlDaygz"]);
    NSString *nongli = [dict objectForKey:@"nlmonthday"];
    NSString *zhishen = [dict objectForKey:@"zhishen"];
    NSString *week = [dict objectForKey:@"week"];
    @weakify(self)
    cell.timeBlock = ^(id clickCell) {
       @strongify(self)
        [self clickTimeAdd:clickCell];
    };
    [cell setupCellContentWithDay:day yearMonth:yearMonth nongli:nongli chinessYMD:chinessYMD week:week count:[dict objectForKey:@"count"] god:NSStringFormat(@"值神：%@",zhishen) twelveGod:NSStringFormat(@"十二神：%@日",[dict objectForKey:@"jianchu"]) constellation:NSStringFormat(@"星宿：%@星",[dict objectForKey:@"xingxiu"]) isHidenLine:isHiden];
    return cell;
}
#pragma makr - 初始化界面
- (void)initializeMainView {
    _titleDetail = NSStringFormat(@"%@:%@",self.titleString,[KDateManager getYiJiDetail:self.titleString]);
    _startDate = [NSDate getTodayDate];
    _endDate = [_startDate dateByAddingTimeInterval:180 * (60 * 60 * 24)];
    _isWeekend = NO;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(0xededed, 1.0)];
    [tableView registerClass:[TXXLSearchDetailCell class] forCellReuseIdentifier:kTXXLSearchDetailCell];
    tableView.rowHeight = 140;
    _headerView = [[TXXLSearchDetailHeaderView alloc]init];
    _headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 197);
    _headerView.titleString = self.navigationItem.title;
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
    [_headerView setupStartTime:_startDate endTime:_endDate];
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 12)];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
    }];
    [self getDataWithWeek];
}
- (HSPDatePickView *)datePickView {
    if (!_datePickView) {
        HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbar:self.tabbarBetweenHeight];
        datePick.datePickerMode = UIDatePickerModeDate;
        datePick.isAutoHiden = NO;
        WS(ws)
        datePick.dateBlock = ^(NSDate *date) {
            [ws datePickSelect:[NSDate stringTransToDate:[date dateTransformToString:kCalendarFormatter] withFormat:kCalendarFormatter]];
        };
        datePick.minDate = [NSDate date];
        datePick.maxDate = [NSDate stringTransToDate:kCalendarMaxDate withFormat:kCalendarFormatter];
        _datePickView = datePick;
        [[UIApplication sharedApplication].keyWindow addSubview:datePick];
    }
    _datePickView.minDate = [NSDate date];
    return _datePickView;
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
