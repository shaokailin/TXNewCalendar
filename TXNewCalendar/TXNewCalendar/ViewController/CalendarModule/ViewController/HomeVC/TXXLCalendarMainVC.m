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
@interface TXXLCalendarMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSDate *_currentDate;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) UITableView *festivalTbView;
@property (nonatomic, weak) TXXLCalendarMessageView *messageView;
@property (nonatomic, weak) TXXLCalendarView *calendarView;
@property (nonatomic, weak) TXXLNavigationRightView *rightView;
@end

@implementation TXXLCalendarMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initNavigationView];
    [self initializeMainView];
    [self setupDefaultDate];
}
#pragma mark -初始化默认值
- (void)setupDefaultDate {
    _currentDate = [NSDate date];
    [self.rightView changeTextWithDate:_currentDate];
    [self.calendarView selectDate:_currentDate];
    [self.messageView setupContentWithDate:_currentDate suitAction:@"纳采  嫁娶  招贤  祈福  纳婿  开市  盖屋" avoidAction:@"订盟  裁衣  安葬  祭祀  修坟" dateDetail:@"三十斋日    (每月6斋期、每月10斋期)" alertFirst:@"小寒：1月5日  星期五 10：41" alertLast:@"小寒：1月5日  星期五 10：41"];
}
#pragma mark - 回调
//跳转更多节假日界面
- (void)viewDidAppear:(BOOL)animated {
    [self jumpMoreVC];
}
- (void)jumpMoreVC {
    TXXLFestivalListVC *festivalVC = [[TXXLFestivalListVC alloc]init];
    festivalVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:festivalVC animated:YES];
}
//导航栏选择日期按钮事件
- (void)navigationSelectDateEvent {
    
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
    
}
#pragma mark -tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLFestivalCountDownCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLFestivalCountDownCell];
    [cell setupCellContentWithLeft:@"腊八节  (公历2018年01月02日)" right:@"还有8天"];
    return cell;
}
#pragma mark 界面的初始化
- (void)initNavigationView {
    //左按钮
    UILabel *leftLbl = [LSKViewFactory initializeLableWithText:@"万年历" font:24 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    leftLbl.frame = CGRectMake(0, 0, 90, self.navibarHeight);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc]initWithCustomView:leftLbl];
    self.navigationItem.leftBarButtonItem = leftItem;
    //右按钮
    TXXLNavigationRightView *rightView = [[TXXLNavigationRightView alloc]initWithFrame:CGRectMake(0, 0, 200, self.navibarHeight)];
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
        make.height.mas_equalTo(226);
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
