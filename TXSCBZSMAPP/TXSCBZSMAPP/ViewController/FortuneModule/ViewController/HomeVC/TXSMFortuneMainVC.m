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
@interface TXSMFortuneMainVC ()<UITableViewDelegate,UITableViewDataSource>
{
    CGFloat _weekHeight;
    BOOL _isSetup;
    NSInteger _index;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXSMFortuneHomeNaviTitleView *naviView;
@property (nonatomic, strong) UIScrollView *headerScrollerView;
@end

@implementation TXSMFortuneMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isSetup) {
        _isSetup = YES;
        [self setupContent];
    }
}
- (void)setupContent {
    TXSMTodayFortuneView *todayView = [self.headerScrollerView.subviews objectAtIndex:0];
    [todayView setupCellContent:@"凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生"];
    TXSMTodayFortuneView *tomorrowView = [self.headerScrollerView.subviews objectAtIndex:1];
    [tomorrowView setupCellContent:@"凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生"];
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
    return 5;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXSMFortuneHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMFortuneHomeCell];
    [cell setupCellContent:nil title:@"凯先生凯先生凯先生凯先生凯先生凯先生凯先生" count:@"1231231" present:@"213%"];
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
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
