//
//  TXXLCalculateMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateMainVC.h"
#import "TXXLCalculateHomeVM.h"
#import "TXXLWebVC.h"
#import "TXSMCalculateHomeHeaderView.h"
#import "TXSMHomeHotNewsCell.h"
static NSString * const kCalculateHomeData = @"kCalculateHomeData_save";
@interface TXXLCalculateMainVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) TXSMCalculateHomeHeaderView *tableHeaderView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXXLCalculateHomeVM *viewModel;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@end

@implementation TXXLCalculateMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self getSaveData];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"测算首页"];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableHeaderView viewDidAppearStartRun];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tableHeaderView viewDidDisappearStop];
    [kUserMessageManager analiticsViewDisappear:self];
}
#pragma mark - 事件处理
- (void)headerViewClick:(NSString *)key index:(NSInteger)index {
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:key];
        if (KJudgeIsArrayAndHasValue(array) && index < array.count) {
            NSDictionary *dict = [array objectAtIndex:index];
            [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"]];
        }
    }
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url {
    if (KJudgeIsNullData(url)) {
        TXXLWebVC *webVC = [[TXXLWebVC alloc]init];
        webVC.titleString = title;
        webVC.loadUrl = url;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark -数据处理
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLCalculateHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
        if ([model isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = model;
            NSString *data = [LSKPublicMethodUtil dictionaryTransformToJson:model];
            [kUserMessageManager setMessageManagerForObjectWithKey:kCalculateHomeData value:data];
            [self.tableHeaderView setupContent:model];
            [self.mainTableView reloadData];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
    }];
    _viewModel.contactId = NSStringFormat(@"%@,%@,%@,%@,%@,%@,%@",kCalculateBannerId,kCalculateNavigationId,kCalculateFeelingId,kCalculateFortuneId,kCalculateUnbindNameId,kCalculateNoticeId,kCalculateAdId);
    _viewModel.limit = @"5,8,4,4,4,2,3";
    [self.mainTableView.mj_header beginRefreshing];
//    [_viewModel getHomeData:NO];
}
- (void)pullDownRefresh {
    [self.viewModel getHomeData:YES];
}
- (void)getSaveData {
    NSString *saveString = [kUserMessageManager getMessageManagerForObjectWithKey:kCalculateHomeData];
    if (KJudgeIsNullData(saveString)) {
        NSDictionary *saveDict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[saveString dataUsingEncoding:NSUTF8StringEncoding]];
        if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = saveDict;
            [self.tableHeaderView setupContent:saveDict];
            [self.mainTableView reloadData];
        }
    }
}
- (void)changeFrame:(CGFloat)height {
    self.mainTableView.tableHeaderView = nil;
    self.mainTableView.tableHeaderView = self.tableHeaderView;
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_dataDictionary && [_dataDictionary objectForKey:kCalculateAdId]) {
        NSArray *data = [_dataDictionary objectForKey:kCalculateAdId];
        if (KJudgeIsArrayAndHasValue(data)) {
            return data.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXSMHomeHotNewsCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMHomeHotNewsCell];
    NSArray *data = [_dataDictionary objectForKey:kCalculateAdId];
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"] detail:@"3123123"];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    WS(ws)
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    self.mainTableView = tableView;
    tableView.rowHeight = 87;
    [tableView registerClass:[TXSMHomeHotNewsCell class] forCellReuseIdentifier:kTXSMHomeHotNewsCell];
    _tableHeaderView = [[TXSMCalculateHomeHeaderView alloc]initWithFrame:CGRectZero];
    _tableHeaderView.frameBlock = ^(CGFloat height) {
        [ws changeFrame:height];
    };
    _tableHeaderView.eventBlock = ^(NSString *key, NSInteger index) {
        [ws headerViewClick:key index:index];
    };
    tableView.tableHeaderView = self.tableHeaderView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
