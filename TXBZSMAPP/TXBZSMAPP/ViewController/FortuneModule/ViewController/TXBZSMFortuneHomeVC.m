//
//  TXBZSMFortuneHomeVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMFortuneHomeVC.h"
#import "TXBZSMNavigationView.h"
#import "TXBZSMFortuneHomeCell.h"
#import "TXBZSMFortuneHeaderView.h"
#import "TXBZSMFortuneHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXBZSMTodayFortuneVC.h"
#import "TXBZSMLiveAnalysisVC.h"
static NSString * const kFortuneHomeData = @"kFortuneHomeData_save";
@interface TXBZSMFortuneHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSInteger _currentXingzuo;
    TXBZSMFortuneHomeVM *_viewModel;
    NSDictionary *_dataDictionary;
    NSDictionary *_xingzuoDictionry;
    BOOL _isJumpFortune;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXBZSMFortuneHeaderView *headerView;
@end

@implementation TXBZSMFortuneHomeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _currentXingzuo = -1;
    [self initializeMainView];
    [self getSaveData];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"运势首页"];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}

#pragma  mark - data
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXBZSMFortuneHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, NSDictionary *model) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
         if ([model isKindOfClass:[NSDictionary class]]) {
             if (identifier == 10) {
                 self->_dataDictionary = model;
                 NSString *data = [LSKPublicMethodUtil dictionaryTransformToJson:model];
                 [kUserMessageManager setMessageManagerForObjectWithKey:kFortuneHomeData value:data];
                 [self.headerView setupHotData:[model objectForKey:kFortuneHomeHot]];
                 [self.mainTableView reloadData];
             }else {
                 self->_xingzuoDictionry = model;
                 if (self->_isJumpFortune) {
                     [self headerEventClick:2];
                     self->_isJumpFortune = NO;
                 }
                 [self.headerView setupTodayData:[model objectForKey:@"today"]];
             }
         }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    [self getXingzuoMessage];
    _viewModel.contactId = NSStringFormat(@"%@,%@",kFortuneHomeHot,kFortuneHomeAd);
    _viewModel.limit = @"1,3";
    _viewModel.isLoadingAd = YES;
    [self.mainTableView.mj_header beginRefreshing];
    
}
- (void)pullDownRefresh {
    [_viewModel getHomeData:YES];
}
- (void)getSaveData {
    NSString *saveString = [kUserMessageManager getMessageManagerForObjectWithKey:kFortuneHomeData];
    if (KJudgeIsNullData(saveString)) {
        NSDictionary *saveDict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[saveString dataUsingEncoding:NSUTF8StringEncoding]];
        if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
            _dataDictionary = saveDict;
            [self.headerView setupHotData:[_dataDictionary objectForKey:kFortuneHomeHot]];
            [self.mainTableView reloadData];
        }
    }
}
#pragma mark - event
- (void)getXingzuoMessage {
    NSInteger index = [kUserMessageManager.birthDay getXingzuo];
    NSArray *array = [NSArray arrayWithPlist:@"xingzuoList"];
    NSDictionary *dict = [array objectAtIndex:index];
    _viewModel.xingzuo = [dict objectForKey:@"english"];
    if (_currentXingzuo != -1 && _currentXingzuo != index) {
        [_viewModel getHomeData:NO];
    }
    _currentXingzuo = index;
}
- (void)headerEventClick:(NSInteger)type {
    if (type == 3) {
        if (_dataDictionary) {
            NSArray *array = [_dataDictionary objectForKey:kFortuneHomeHot];
            if (KJudgeIsArrayAndHasValue(array)) {
                NSDictionary *dict = [array objectAtIndex:0];
                [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"] pic:[dict objectForKey:@"image"]];
            }
        }
    }else if (type == 2) {
        TXBZSMTodayFortuneVC *today = [[TXBZSMTodayFortuneVC alloc]init];
        today.dataDictionary = _xingzuoDictionry;
        today.xingzuo = _viewModel.xingzuo;
        @weakify(self)
        today.refreshBlock = ^(NSDictionary *data) {
            @strongify(self)
            self->_dataDictionary = data;
            [self.headerView setupTodayData:[data objectForKey:@"today"]];
        };
        today.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:today animated:YES];
    }else if (type == 1) {
        TXBZSMLiveAnalysisVC *live = [[TXBZSMLiveAnalysisVC alloc]init];
        live.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:live animated:YES];
    }
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataDictionary) {
        NSArray *data = [_dataDictionary objectForKey:kFortuneHomeAd];
        if (KJudgeIsArrayAndHasValue(data)) {
            return data.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMFortuneHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMFortuneHomeCell];
    NSArray *data = [_dataDictionary objectForKey:kFortuneHomeAd];
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"title"]  img:[dict objectForKey:@"image"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *data = [_dataDictionary objectForKey:kFortuneHomeAd];
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"] pic:[dict objectForKey:@"image"]];
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url pic:(NSString *)pic {
    TXSMMessageDetailVC *detail = [[TXSMMessageDetailVC alloc]init];
    detail.titleString = title;
    detail.loadUrl = url;
    detail.pic = pic;
    detail.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:detail animated:YES];
}

#pragma mark -view
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)initializeMainView {
    TXBZSMNavigationView *navigationView = [[TXBZSMNavigationView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.navibarHeight + STATUSBAR_HEIGHT + 11)];
    [self.view addSubview:navigationView];
    
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:[UIColor clearColor]];
    tableView.rowHeight = 87;
    [tableView registerNib:[UINib nibWithNibName:kTXBZSMFortuneHomeCell bundle:nil] forCellReuseIdentifier:kTXBZSMFortuneHomeCell];
    _headerView = [[TXBZSMFortuneHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 747)];
    @weakify(self)
    _headerView.eventBlock = ^(NSInteger type) {
      @strongify(self)
        [self headerEventClick:type];
    };
    tableView.tableHeaderView = self.headerView;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom).with.offset(-19);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
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
