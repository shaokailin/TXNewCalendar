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
@interface TXSMFortuneMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _weekHeight;
    NSInteger _index;
    NSString *_currentXingZuo;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXSMFortuneHomeNaviTitleView *naviView;
@property (nonatomic, strong) UIScrollView *headerScrollerView;
@property (nonatomic, strong) TXSMFortuneHomeVM *viewModel;
@property (nonatomic, strong) NSArray *dataArray;
@end

@implementation TXSMFortuneMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
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
    _currentXingZuo = [self getXingzuo];
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
    
    UIView<TXSMFortuneHomeProtocol> *view4 = [self.headerScrollerView.subviews objectAtIndex:3];
    [view4 setupContent:_currentXingZuo dict:[dict objectForKey:@"month"]];
    [self frameChange];
}
- (void)frameChange {
    UIView<TXSMFortuneHomeProtocol> *view = [self.headerScrollerView.subviews objectAtIndex:_index];
    CGFloat contentHeight = [view returnViewHeight];
    CGFloat scrollHeight = CGRectGetHeight(self.headerScrollerView.frame);
    if (contentHeight != scrollHeight) {
        self.headerScrollerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, contentHeight);
        self.headerScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
        self.mainTableView.tableHeaderView = nil;
        self.mainTableView.tableHeaderView = self.headerScrollerView;
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
    [cell setupCellContent:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"] count:@"1231231" present:@"213%"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma marak - init view
- (void)initializeMainView {
    _index = 0;
    self.naviView = [[TXSMFortuneHomeNaviTitleView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHomeHeadButtonHeight)];
    WS(ws)
    self.naviView.selectBlock = ^(NSInteger index) {
        [ws changeSelectShow:index];
    };
    self.navigationItem.titleView = self.naviView;
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerClass:[TXSMFortuneHomeCell class] forCellReuseIdentifier:kTXSMFortuneHomeCell];
    tableView.rowHeight = 192 / 2.0;
    self.mainTableView = tableView;
    tableView.tableHeaderView = self.headerScrollerView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
- (UIScrollView *)headerScrollerView {
    if (!_headerScrollerView) {
        _headerScrollerView = [[UIScrollView alloc]initWithFrame:CGRectZero];
        _headerScrollerView.showsHorizontalScrollIndicator = NO;
        _headerScrollerView.showsVerticalScrollIndicator = NO;
        _headerScrollerView.pagingEnabled = YES;
        _headerScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT / 2.0);
        _headerScrollerView.scrollEnabled = NO;
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
