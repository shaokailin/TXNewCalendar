//
//  TXSMMessageListView.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageListView.h"
#import "TXSMMessageOneImgCell.h"
#import "TXSMMessageHomeVM.h"
#import "TXSMMessageDetailVC.h"
static CGFloat kOneImgCellHeight = 103;
@interface TXSMMessageListView ()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL _isHasStartPull;
    BOOL _isHasAd;
    NSInteger _currentMoreAd;
    NSInteger _currentOneAd;
    UIViewController *_controller;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) TXSMMessageHomeVM *viewModel;
@end
@implementation TXSMMessageListView

- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
        [self bindSignal:type];
    }
    return self;
}
- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)bindSignal:(NSInteger)type {
    @weakify(self)
    _viewModel = [[TXSMMessageHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 10) {
            if (self.viewModel.page == 0) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:model];
            [self setupFooterView];
            [self endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self endRefreshing];
    }];
    _viewModel.type = type;
}
- (void)setupFooterView {
    NSInteger count = self.dataArray.count;
    [LSKViewFactory setupFootRefresh:self.mainTableView page:self.viewModel.page currentCount:count];
    [self.mainTableView reloadData];
}
- (void)endRefreshing {
    if (_viewModel.page == 0) {
        [self.mainTableView.mj_header endRefreshing];
    }else {
        [self.mainTableView.mj_footer endRefreshing];
    }
}
- (void)selectViewChange {
    if (!KJudgeIsArrayAndHasValue(_dataArray) || !_isHasStartPull) {
        _isHasStartPull = YES;
        [self.mainTableView.mj_header beginRefreshing];
    }
}
- (void)pullMoreData {
    self.viewModel.page += 1;
    [self.viewModel getHomeData:YES];
}
- (void)pullRrfreshData {
    self.viewModel.page = 0;;
    [self.viewModel getHomeData:YES];
}
#pragma  mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (KJudgeIsNullData(_dataArray)) {
        NSInteger count = _dataArray.count;
        if (_isHasAd) {
            NSInteger yushu = count / 3;
            count += yushu;
        }
        return count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXSMMessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    TXSMMessageOneImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageOneImgCell];
    [cell setupCellContent:model.pic title:model.title where:model.from count:model.hits];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (!_controller) {
        _controller = [LSKViewFactory getCurrentViewController];
    }
    TXSMMessageModel *model = [self.dataArray objectAtIndex:indexPath.row];
    TXSMMessageDetailVC *detail = [[TXSMMessageDetailVC alloc]init];
    detail.model = model;
    detail.hidesBottomBarWhenPushed = YES;
    [_controller.navigationController pushViewController:detail animated:YES];
}
#pragma mark - init
- (void)_layoutMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullRrfreshData) footRefreshAction:@selector(pullMoreData) separatorColor:[UIColor clearColor] backgroundColor:[UIColor clearColor]];
    [tableView registerClass:[TXSMMessageOneImgCell class] forCellReuseIdentifier:kTXSMMessageOneImgCell];
    tableView.rowHeight = kOneImgCellHeight;
    self.mainTableView = tableView;
    [self addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    
}
@end
