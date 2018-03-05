//
//  TXXLCalendarMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalendarMainVC.h"
#import "TXXLNavigationRightView.h"
#import "TXXLCalendarView.h"
#import "TXXLCalendarMessageView.h"
#import "TXXLFestivalCountDownHeaderView.h"
#import "TXXLFestivalCountDownCell.h"
#import "TXXLFestivalListVC.h"
#import "HSPDatePickView.h"
@interface TXXLCalendarMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *_currentDate;
    NSArray *_festivalsList;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) UITableView *festivalTbView;
@property (nonatomic, weak) TXXLCalendarMessageView *messageView;
@property (nonatomic, weak) TXXLCalendarView *calendarView;
@property (nonatomic, weak) TXXLNavigationRightView *rightView;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@end

@implementation TXXLCalendarMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationView];
    [self initializeMainView];
    [self setupDefaultDate];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCalendarDate:) name:kCalendarDateChange object:nil];
    [kUserMessageManager setupViewProperties:self url:nil name:@"万年历首页"];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (NSString *)returnJieqi:(NSArray *)data {
    if (KJudgeIsArrayAndHasValue(data)) {
        NSMutableString *string = [NSMutableString stringWithFormat:@"%@:  ",[data objectAtIndex:0]];
        if (data.count > 1) {
            NSString *dateString = [data objectAtIndex:1];
            if (KJudgeIsNullData(dateString)) {
                NSDate *date = [NSDate stringTransToDate:dateString withFormat:@"yyyy-MM-dd HH-mm-ss"];
                if (date) {
                    NSString *month = [date dateTransformToString:@"MM月dd日"];
                    NSString *second = [date dateTransformToString:@"hh:mm"];
                    [string appendFormat:@"%@  %@  %@",month,[date getWeekDate],second];
                }else {
                    [string appendString:dateString];
                }
            }
        }
        return string;
    }
    return nil;
}
#pragma mark -初始化默认值
- (void)setupDefaultDate {
    NSDate *current = [NSDate stringTransToDate:[[NSDate date] dateTransformToString:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
    _currentDate = current;
    [self changeDateEvent];
}
#pragma mark -私有方法
- (void)changeCalendarDate:(NSNotification *)notification {
    [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    NSDictionary *dict = notification.userInfo;
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSDate *date = [dict objectForKey:@"date"];
        if (date) {
            [self dateSelect:date];
        }
    }
}
- (void)dateSelect:(NSDate *)date {
    NSDate *select = [NSDate stringTransToDate:[date dateTransformToString:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
    if ([_currentDate compare:select] != NSOrderedSame) {
        _currentDate = date;
        [self.calendarView selectDate:date];
        [self changeDateEvent];
    }
}
- (void)changeDateEvent {
    [self.rightView changeTextWithDate:_currentDate];
    [self.calendarView selectDate:_currentDate];
    [self setupMessageView];
}
- (void)setupMessageView {
    [self.messageView setupContentWithDate:_currentDate];
}
#pragma mark - 回调
//跳转更多节假日界面

- (void)jumpMoreVC {
    TXXLFestivalListVC *festivalVC = [[TXXLFestivalListVC alloc]init];
    festivalVC.loadingTimeString = [_currentDate dateTransformToString:kCalendarFormatter];
    festivalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:festivalVC animated:YES];
}
//导航栏选择日期按钮事件
- (void)navigationSelectDateEvent {
    [self.datePickView showInView];
}
//日历大小变化
- (void)calendarFrameChange:(CGFloat)oldHeight currentHeight:(CGFloat)current {
    [self.calendarView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(current);
    }];
    CGFloat contentHeight = self.mainScrollView.contentSize.height;
    contentHeight -= oldHeight;
    contentHeight += current;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
}
//日历选择时间
- (void)calendarSelectDate:(NSDate *)date {
    NSDate *current = [NSDate stringTransToDate:[date dateTransformToString:@"yyyy-MM-dd"] withFormat:@"yyyy-MM-dd"];
    _currentDate = current;
    [self changeDateEvent];
}
#pragma mark -tableview delegate】
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (KJudgeIsArrayAndHasValue(_festivalsList)) {
        return _festivalsList.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLFestivalCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLFestivalCountDownCell];
    NSDictionary *dict = [_festivalsList objectAtIndex:indexPath.row];
    
    [cell setupCellContentWithLeft:NSStringFormat(@"%@  (公历%@)",[dict objectForKey:@"j"],[dict objectForKey:@"d"]) right:NSStringFormat(@"还有%@天",[dict objectForKey:@"l"])];
    return cell;
}
#pragma mark 界面的初始化
- (void)initNavigationView {
    //左按钮
    UILabel *leftLbl = [LSKViewFactory initializeLableWithText:@"万年历" font:24 textColor:[UIColor whiteColor] textAlignment:2 backgroundColor:nil];
    leftLbl.frame = CGRectMake(0, 0, 90, self.navibarHeight);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftLbl];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右按钮
    TXXLNavigationRightView *rightView = [[TXXLNavigationRightView alloc]initWithFrame:CGRectMake(10, 0, 200, self.navibarHeight)];
    self.rightView = rightView;
    @weakify(self)
    rightView.selectBlock = ^(BOOL isSelect) {
        @strongify(self)
        [self navigationSelectDateEvent];
    };
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightItem;
}
- (void)initializeMainView {
    UIScrollView *mainScrollView = [[UIScrollView alloc]init];
    self.mainScrollView = mainScrollView;
    [self.view addSubview:mainScrollView];
    WS(ws)
    CGFloat contentHeight = 304;
    TXXLCalendarView *calendarView = [[TXXLCalendarView alloc]init];
    self.calendarView = calendarView;
    calendarView.frameBlock = ^(CGFloat oldHeight, CGFloat currentHeight) {
        [ws calendarFrameChange:oldHeight currentHeight:currentHeight];
    };
    calendarView.dateBlock = ^(NSDate *selectDate) {
        [ws calendarSelectDate:selectDate];
    };
    [mainScrollView addSubview:calendarView];
    [calendarView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(304);
    }];
    
    contentHeight += 15;
    TXXLCalendarMessageView *messageView = [[TXXLCalendarMessageView alloc]init];
    self.messageView = messageView;
    [mainScrollView addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollView).with.offset(15);
        make.right.equalTo(calendarView).with.offset(-15);
        make.top.equalTo(calendarView.mas_bottom).with.offset(15);
        make.height.mas_equalTo(204);
    }];
    contentHeight += 226;
    contentHeight += 10;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:KColorHexadecimal(kLineMain_Color, 1.0)];
    KViewRadius(tableView, 5.0);
    TXXLFestivalCountDownHeaderView *headerView = [[TXXLFestivalCountDownHeaderView alloc]initWithFrame:CGRectMake(15, 0, SCREEN_WIDTH - 30, 48)];
    headerView.moreBlock = ^(BOOL isMore) {
        [ws jumpMoreVC];
    };
    tableView.tableHeaderView = headerView;
    tableView.rowHeight = 44;
    [tableView registerClass:[TXXLFestivalCountDownCell class] forCellReuseIdentifier:kTXXLFestivalCountDownCell];
    tableView.allowsSelection = NO;
    tableView.tableFooterView = [[UIView alloc]init];
    self.festivalTbView = tableView;
    [mainScrollView addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollView).with.offset(15);
        make.right.equalTo(calendarView).with.offset(-15);
        make.top.equalTo(messageView.mas_bottom).with.offset(10);
        make.height.mas_equalTo(268);
    }];
    contentHeight += 268;
    contentHeight += 15;
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
- (HSPDatePickView *)datePickView {
    if (!_datePickView) {
        HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbar:self.tabbarBetweenHeight];
        datePick.datePickerMode = UIDatePickerModeDate;
        WS(ws)
        datePick.dateBlock = ^(NSDate *date) {
            [ws dateSelect:date];
        };
        datePick.minDate = [NSDate stringTransToDate:kCalendarMinDate withFormat:kCalendarFormatter];
        datePick.maxDate = [NSDate stringTransToDate:kCalendarMaxDate withFormat:kCalendarFormatter];
        _datePickView = datePick;
        [[UIApplication sharedApplication].keyWindow addSubview:datePick];
    }
//    _datePickView.minDate = [[NSDate stringTransToDate:@"19" withFormat:]];
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
