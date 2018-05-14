//
//  TXBZSMBlessHomeVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/3.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeVC.h"
#import "TXBZSMBlessHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXBZSMBlessHomeHeaderView.h"
#import "TXBZSMBlessHomeCell.h"
#import "TXBZSMTodayNavigationView.h"
#import "TXBZSMBlessHomeBgView.h"
#import "TXBZSMMyBlessVC.h"
#import "TXBZSMBlessPlatformVC.h"
#import "TXBZSMWishTreeVC.h"
static NSString * const kBlessHomeData = @"kBlessHomeData_save";
@interface TXBZSMBlessHomeVC ()<UITableViewDelegate,UITableViewDataSource>
{
    BOOL _isLoading;
}
@property (nonatomic, weak) TXBZSMBlessHomeHeaderView *tableHeaderView;
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXBZSMBlessHomeVM *viewModel;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@end

@implementation TXBZSMBlessHomeVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self getSaveData];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"祈福首页"];
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
    [kUserMessageManager resetWishTreeData];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
#pragma mark - 事件处理
- (void)headerViewClick:(NSInteger)type index:(NSInteger)index {
    if (type == 1) {
        [self jumpBlessMain];
    }else if (type == 2) {
        if (self.dataDictionary) {
            NSArray *array = [self.dataDictionary objectForKey:kBlessNavigationId];
            if (KJudgeIsArrayAndHasValue(array)) {
                if (index < array.count) {
                    NSDictionary *dict = [array objectAtIndex:index];
                    [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"] image:[dict objectForKey:@"image"]];
                    return;
                }
            }
        }
        [self jumpWishingTree];
    }else if (type == 0) {
        TXBZSMMyBlessVC *my = [[TXBZSMMyBlessVC alloc]init];
        my.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:my animated:YES];
    }
}
- (void)jumpBlessMain {
    TXBZSMBlessPlatformVC *bless = [[TXBZSMBlessPlatformVC alloc]init];
    bless.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:bless animated:YES];
}
- (void)jumpWishingTree {
    TXBZSMWishTreeVC *tree = [[TXBZSMWishTreeVC alloc]init];
    tree.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:tree animated:YES];
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url image:(NSString *)image {
    if (KJudgeIsNullData(url)) {
        TXSMMessageDetailVC *webVC = [[TXSMMessageDetailVC alloc]init];
        webVC.titleString = title;
        webVC.loadUrl = url;
        webVC.pic = image;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}
#pragma mark -数据处理
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXBZSMBlessHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, NSDictionary *model) {
        @strongify(self)
        [self.mainTableView.mj_header endRefreshing];
        if ([model isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = model;
            NSString *data = [LSKPublicMethodUtil dictionaryTransformToJson:model];
            [kUserMessageManager setMessageManagerForObjectWithKey:kBlessHomeData value:data];
            [self.tableHeaderView setupContent:[model objectForKey:kBlessNavigationId]];
            [self.mainTableView reloadData];
        }
        self->_isLoading = NO;
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        self->_isLoading = NO;
        [self.mainTableView.mj_header endRefreshing];
    }];
    _viewModel.contactId = NSStringFormat(@"%@,%@",kBlessNavigationId,kBlessAdId);
    _viewModel.limit = @"3,3";
    if (!self.dataDictionary) {
        [self.mainTableView.mj_header beginRefreshing];
    }else {
        _isLoading = YES;
        [self.viewModel getHomeData:YES];
    }
}
- (void)pullDownRefresh {
    if (!_isLoading) {
        [self.viewModel getHomeData:YES];
    }else {
        [self.mainTableView.mj_header endRefreshing];
    }
}
- (void)getSaveData {
    NSString *saveString = [kUserMessageManager getMessageManagerForObjectWithKey:kBlessHomeData];
    if (KJudgeIsNullData(saveString)) {
        NSDictionary *saveDict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[saveString dataUsingEncoding:NSUTF8StringEncoding]];
        if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = saveDict;
            [self.tableHeaderView setupContent:[saveDict objectForKey:kBlessNavigationId]];
        }
    }
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:kBlessAdId];
        if (KJudgeIsArrayAndHasValue(array)) {
            return array.count;
        }
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMBlessHomeCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMBlessHomeCell];
    NSArray *array = [self.dataDictionary objectForKey:kBlessAdId];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    [cell setupCellContent:dict];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.dataDictionary objectForKey:kBlessAdId];
    NSDictionary *dict = [array objectAtIndex:indexPath.row];
    [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"] image:[dict objectForKey:@"image"]];
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    TXBZSMBlessHomeBgView *bgView = [[TXBZSMBlessHomeBgView alloc]init];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.height.mas_equalTo(311);
    }];
    TXBZSMTodayNavigationView *navigationView = [[TXBZSMTodayNavigationView alloc]init];
    navigationView.title = @"祈福";
    navigationView.isBack = NO;
    navigationView.isShare = NO;
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(STATUSBAR_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.navibarHeight);
    }];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil separatorColor:nil backgroundColor:[UIColor clearColor]];
    [tableView registerNib:[UINib nibWithNibName:kTXBZSMBlessHomeCell bundle:nil] forCellReuseIdentifier:kTXBZSMBlessHomeCell];
    tableView.rowHeight = 230;
    TXBZSMBlessHomeHeaderView *headerView = [[TXBZSMBlessHomeHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 362)];
    @weakify(self)
    headerView.block = ^(NSInteger type, NSInteger index) {
      @strongify(self)
        [self headerViewClick:type index:index];
    };
    self.tableHeaderView = headerView;
    tableView.tableHeaderView = headerView;
    tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 5, 10)];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(navigationView.mas_bottom);
        make.left.right.bottom.equalTo(self.view);
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
