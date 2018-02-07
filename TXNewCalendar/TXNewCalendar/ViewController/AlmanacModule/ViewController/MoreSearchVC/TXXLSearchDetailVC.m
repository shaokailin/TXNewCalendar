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
#import "TXXLSearchDetailVM.h"
#import "HSPDatePickView.h"
static const CGFloat kMaxTimeBetween = 180 * 24 * 60 * 60;
@interface TXXLSearchDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *_startDate;
    NSDate *_endDate;
    TimeState _timeState;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXXLSearchDetailHeaderView *headerView;
@property (nonatomic, strong) TXXLSearchDetailVM *viewModel;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@end

@implementation TXXLSearchDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSStringFormat(@"%@%@",self.isAvoid?@"忌":@"宜",self.titleString);
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
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
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLSearchDetailVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.headerView setupDescribe:NSStringFormat(@"%@: %@",self.titleString,self.viewModel.detailModel.title) count:self.viewModel.detailModel.num];
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (self.viewModel.detailModel) {
            [self.headerView setupDescribe:NSStringFormat(@"%@: %@",self.titleString,self.viewModel.detailModel.title) count:self.viewModel.detailModel.num];
        }
        [self.mainTableView reloadData];
        [self.mainTableView.mj_header endRefreshing];
    }];
    _viewModel.isAvoid = self.isAvoid;
    _viewModel.text = self.titleString;
    _viewModel.startTime = [_startDate dateTransformToString:@"yyyy-MM-dd"];
    _viewModel.endTime = [_endDate dateTransformToString:@"yyyy-MM-dd"];
    [_viewModel getSearchDetail:NO];
}
- (void)pullDownRefresh {
    [_viewModel getSearchDetail:YES];
}
- (void)clickTimeAdd:(TXXLSearchDetailCell *)cell {
    NSIndexPath *indexPath = [self.mainTableView indexPathForCell:cell];
    TXXLSearchDetailModel *model = [self.viewModel.detailModel.detail objectAtIndex:indexPath.row];
    if ([model.time isKindOfClass:[NSDictionary class]]) {
        NSString *dateString = NSStringFormat(@"%@-%@-%@",[model.time objectForKey:@"y"],[model.time objectForKey:@"m"],[model.time objectForKey:@"d"]);
        NSDate *date = [NSDate stringTransToDate:dateString withFormat:kCalendarFormatter];
        if (date) {
            [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kAlmanacDateChange object:nil userInfo:@{@"date":date}];
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
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
            _viewModel.startTime = [_startDate dateTransformToString:@"yyyy-MM-dd"];
            _viewModel.endTime = [_endDate dateTransformToString:@"yyyy-MM-dd"];
            [self.headerView setupStartTime:_startDate endTime:_endDate];
            [_viewModel getSearchDetail:NO];
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
            _viewModel.startTime = [_startDate dateTransformToString:@"yyyy-MM-dd"];
            _viewModel.endTime = [_endDate dateTransformToString:@"yyyy-MM-dd"];
            [self.headerView setupStartTime:_startDate endTime:_endDate];
            [_viewModel getSearchDetail:NO];
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
    self.viewModel.isShowWeenken = isOnly;
    [self.viewModel getSearchDetail:NO];
}
#pragma mark delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.viewModel.detailModel && KJudgeIsArrayAndHasValue(self.viewModel.detailModel.detail)) {
        return self.viewModel.detailModel.detail.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLSearchDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSearchDetailCell];
    BOOL isHiden = indexPath.row == self.viewModel.detailModel.detail.count - 1;
    TXXLSearchDetailModel *model = [self.viewModel.detailModel.detail objectAtIndex:indexPath.row];
    NSString *day = nil;
    NSString *yearMonth = nil;
    if ([model.time isKindOfClass:[NSDictionary class]]) {
        day = [model.time objectForKey:@"d"];
        yearMonth = NSStringFormat(@"%@.%@",[model.time objectForKey:@"y"],[model.time objectForKey:@"m"]);
    }
    NSString *nongli = nil;
    if ([model.nongli isKindOfClass:[NSDictionary class]]) {
        nongli = NSStringFormat(@"%@%@",[model.nongli objectForKey:@"m"],[model.nongli objectForKey:@"d"]);
    }
    NSMutableString *chinessYMD = [NSMutableString stringWithString:@""];
    if ([model.jinian isKindOfClass:[NSDictionary class]]) {
        NSArray *year = [model.jinian objectForKey:@"y"];
        if (KJudgeIsArrayAndHasValue(year)) {
            [chinessYMD appendFormat:@"%@[%@]年  ",[year componentsJoinedByString:@""],model.shengxiao];
        }
        NSArray *month = [model.jinian objectForKey:@"m"];
        if (KJudgeIsArrayAndHasValue(month)) {
            [chinessYMD appendFormat:@"%@月  ",[month componentsJoinedByString:@""]];
        }
        NSArray *dayArray = [model.jinian objectForKey:@"d"];
        if (KJudgeIsArrayAndHasValue(dayArray)) {
            [chinessYMD appendFormat:@"%@日",[dayArray componentsJoinedByString:@""]];
        }
    }
    NSString *zhishen = nil;
    if ([model.zhi_ri isKindOfClass:[NSDictionary class]]) {
        zhishen = [model.zhi_ri objectForKey:@"shen_sha"];
    }
    @weakify(self)
    cell.timeBlock = ^(id clickCell) {
       @strongify(self)
        [self clickTimeAdd:clickCell];
    };
    [cell setupCellContentWithDay:day yearMonth:yearMonth nongli:nongli chinessYMD:chinessYMD week:model.week count:model.tian god:zhishen twelveGod:NSStringFormat(@"十二神：%@日",model.jian_chu) constellation:NSStringFormat(@"星宿：%@星",model.xing_su) isHidenLine:isHiden];
    return cell;
}
#pragma makr - 初始化界面
- (void)initializeMainView {
    _startDate = [NSDate getTodayDate];
    _endDate = [_startDate dateByAddingTimeInterval:180 * (60 * 60 * 24)];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(0xededed, 1.0)];
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
}
- (HSPDatePickView *)datePickView {
    if (!_datePickView) {
        HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbar:self.tabbarBetweenHeight];
        datePick.datePickerMode = UIDatePickerModeDate;
        datePick.isAutoHiden = NO;
        WS(ws)
        datePick.dateBlock = ^(NSDate *date) {
            [ws datePickSelect:date];
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
