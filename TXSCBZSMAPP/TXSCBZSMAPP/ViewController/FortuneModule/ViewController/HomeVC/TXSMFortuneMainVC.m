//
//  TXSMFortuneMainVC.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneMainVC.h"
#import "TXSMFortuneHomeNaviTitleView.h"
#import "TXSMFortuneHomeCell.h"
#import "TXSMTodayFortuneView.h"
#import "TXSMWeekFortuneView.h"
#import "TXSMFortuneHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXSMNewNavigationTitleView.h"
@interface TXSMFortuneMainVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>
{
    CGFloat _weekHeight;
    NSInteger _index;
    NSString *_currentXingZuo;
    BOOL _isClickAnimal;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXSMNewNavigationTitleView *naviTitleView;
@property (nonatomic, weak) TXSMFortuneHomeNaviTitleView *naviView;
@property (nonatomic, strong) UIScrollView *headerScrollerView;
@property (nonatomic, strong) TXSMFortuneHomeVM *viewModel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) UIView *headerView;
@end

@implementation TXSMFortuneMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"运势首页"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXSMFortuneHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 10) {
            [self setupContent:model];
        }else {
            [self.mainTableView.mj_header endRefreshing];
            self.dataArray = model;
            [self.mainTableView reloadData];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    _viewModel.contactId = @"27";
    _viewModel.limit = @"5";
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"aries",@"白羊座",@"taurus",@"金牛座",@"gemini",@"双子座",@"cancer",@"巨蟹座",@"leo",@"狮子座",@"virgo",@"处女座",@"libra",@"天秤座",@"scorpius",@"天蝎座",@"sagittarius",@"射手座",@"capricoenus",@"摩羯座",@"aquarius",@"水瓶座",@"pisces",@"双鱼座", nil];
    _viewModel.xingzuo = [dict objectForKey:_currentXingZuo];
    [self.mainTableView.mj_header beginRefreshing];
}
- (void)pullDownRefresh {
    [self.viewModel getHomeData:YES];
}
- (void)setupContent:(NSDictionary *)dict {
    UIView<TXSMFortuneHomeProtocol> *view1 = [self.headerScrollerView.subviews objectAtIndex:0];
    [view1 setupContent:_currentXingZuo dict:[dict objectForKey:@"today"]];
    
    UIView<TXSMFortuneHomeProtocol> *view2 = [self.headerScrollerView.subviews objectAtIndex:1];
    [view2 setupContent:_currentXingZuo dict:[dict objectForKey:@"tomorrow"]];
    
    UIView<TXSMFortuneHomeProtocol> *view3 = [self.headerScrollerView.subviews objectAtIndex:2];
    [view3 setupContent:_currentXingZuo dict:[dict objectForKey:@"week"]];
    [view3 setupEnglistName:self.viewModel.xingzuo];
    UIView<TXSMFortuneHomeProtocol> *view4 = [self.headerScrollerView.subviews objectAtIndex:3];
    [view4 setupContent:_currentXingZuo dict:[dict objectForKey:@"month"]];
    [view4 setupEnglistName:self.viewModel.xingzuo];
    
    UIView<TXSMFortuneHomeProtocol> *view5 = [self.headerScrollerView.subviews objectAtIndex:4];
    NSDictionary *dict1 = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"xingzuo" ofType:@"plist"]];
    [view5 setupContent:_currentXingZuo dict:[dict1 objectForKey:_currentXingZuo]];
    [view5 setupEnglistName:self.viewModel.xingzuo];
    [self frameChange];
}
- (void)frameChange {
    UIView<TXSMFortuneHomeProtocol> *view = [self.headerScrollerView.subviews objectAtIndex:_index];
    CGFloat contentHeight = [view returnViewHeight];
    CGFloat scrollHeight = CGRectGetHeight(self.headerScrollerView.frame);
    if (contentHeight != scrollHeight) {
        self.naviView.hidden = NO;
        self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, contentHeight + kHomeHeadButtonHeight);
        CGRect frame = self.headerScrollerView.frame;
        frame.size.height = contentHeight;
        self.headerScrollerView.frame = frame;
        self.mainTableView.tableHeaderView = self.headerView;
        [self.headerScrollerView setContentOffset:CGPointMake(SCREEN_WIDTH * _index, 0)];
    }
}
- (void)changeSelectShow:(NSInteger)index {
    if (_index != index) {
        _index = index;
        [UIView animateWithDuration:0.25 animations:^{
            [self.headerScrollerView setContentOffset:CGPointMake(SCREEN_WIDTH * index, 0)];
        }completion:^(BOOL finished) {
            [self frameChange];
        }];
    }
}
- (void)showXingZuoListView {
    
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (KJudgeIsArrayAndHasValue(self.dataArray)) {
        return self.dataArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXSMFortuneHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMFortuneHomeCell];
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"] count:nil present:@"97%"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *url = [dict objectForKey:@"url"];
    if (KJudgeIsNullData(url)) {
        TXSMMessageDetailVC *webVC = [[TXSMMessageDetailVC alloc]init];
        webVC.titleString = [dict objectForKey:@"title"];
        webVC.loadUrl = url;
        webVC.pic = [dict objectForKey:@"image"];
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma marak - init view
- (void)initializeMainView {
    _index = 0;
    _currentXingZuo = [self getXingzuo];
    WS(ws)
    self.naviTitleView = [[TXSMNewNavigationTitleView alloc]initWithFrame:CGRectMake(0, 0, 150, 44)];
    [self.naviTitleView setupXingZuoName:_currentXingZuo];
    self.naviTitleView.clickBlock = ^(BOOL isClick) {
        [ws showXingZuoListView];
    };
    self.navigationItem.titleView = self.naviTitleView;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerClass:[TXSMFortuneHomeCell class] forCellReuseIdentifier:kTXSMFortuneHomeCell];
    tableView.rowHeight = 192 / 2.0;
    self.mainTableView = tableView;
    tableView.tableHeaderView = self.headerView;;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        
    }
    return _headerView;
}
- (TXSMFortuneHomeNaviTitleView *)naviView {
    if (!_naviView) {
        TXSMFortuneHomeNaviTitleView *naviView = [[TXSMFortuneHomeNaviTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHomeHeadButtonHeight)];
        naviView.backgroundColor = [UIColor whiteColor];
        self.naviView = naviView;
        WS(ws)
        naviView.selectBlock = ^(NSInteger index) {
            [ws changeSelectShow:index];
        };
        [_headerView addSubview:naviView];
    }
    return _naviView;
}
- (UIScrollView *)headerScrollerView {
    if (!_headerScrollerView) {
        _headerScrollerView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
        _headerScrollerView.frame = CGRectMake(0, kHomeHeadButtonHeight, SCREEN_WIDTH, 0);
        _headerScrollerView.showsHorizontalScrollIndicator = NO;
        _headerScrollerView.showsVerticalScrollIndicator = NO;
        _headerScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH * 5, SCREEN_HEIGHT * 2);
        _headerScrollerView.pagingEnabled = YES;
        _headerScrollerView.layer.masksToBounds = YES;
        _headerScrollerView.delegate = self;
        _headerScrollerView.bounces = NO;
        for (int i = 0; i < 5; i++) {
            if (i < 2) {
                TXSMTodayFortuneView *view = [[TXSMTodayFortuneView alloc]initWithType:i];
                view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [view returnViewHeight]);
                [_headerScrollerView addSubview:view];
            }else {
               TXSMWeekFortuneView *view = [[TXSMWeekFortuneView alloc]initWithType:i - 2];
                view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [view returnViewHeight]);
                [_headerScrollerView addSubview:view];
            }
        }
        [self.headerView addSubview:_headerScrollerView];
    }
    return _headerScrollerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)getXingzuo {
    NSString *retStr=@"";
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger i_month = comps.month;
    NSInteger i_day = comps.day;
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
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
