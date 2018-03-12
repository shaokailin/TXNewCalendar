//
//  TXSMMessageListView.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageListView.h"
#import "TXSMMessageOneImgCell.h"
#import "TXSMMessageMoreImgCell.h"
#import "TXSMMessageAddCell.h"
#import "TXSMMessageNoImgCell.h"
#import "TXSMMessageHomeVM.h"
#import "TXXLWebVC.h"
#import "TXSMMessageDetailVC.h"
static CGFloat kOneImgCellHeight = 103;
static CGFloat kNoImgCellHeight = 83;
static CGFloat kAdCellHeight = 232;
static CGFloat kMoreImgCellHeight = 139;
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
            if (self.viewModel.adDict) {
                [self setupFooterView];
                [self endRefreshing];
            }
        }else {
            if (self.viewModel.adDict && self.viewModel.adDict.allKeys.count > 0) {
                NSArray *adArray = [self.viewModel.adDict objectForKey:@"28"];
                NSArray *moreArray = [self.viewModel.adDict objectForKey:@"29"];
                if (!KJudgeIsArrayAndHasValue(adArray) && !KJudgeIsArrayAndHasValue(moreArray)) {
                    _isHasAd = NO;
                }else {
                    _isHasAd = YES;
                }
            }
           [self setupFooterView];
            [self endRefreshing];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 20) {
            [self setupFooterView];
            [self.mainTableView reloadData];
        }
        [self endRefreshing];
    }];
    _viewModel.contactId = @"28,29";
    _viewModel.type = type;
    
}
- (void)setupFooterView {
    NSInteger count = self.dataArray.count;
    if (_isHasAd) {
        NSInteger yushu = count / 3;
        count += yushu;
    }
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
    NSInteger type = (indexPath.row - 3) % 4;
    NSInteger count = (indexPath.row - 3) / 4;
    if (indexPath.row < 3 || (type != 0) ) {
        NSInteger index = indexPath.row < 3?indexPath.row:indexPath.row - count - 1;
        NSDictionary *dict = [self.dataArray objectAtIndex:index];
        NSString *image = [dict objectForKey:@"pic"];
        NSString *title = [dict objectForKey:@"title"];
        NSString *from = [dict objectForKey:@"from"];
        NSString *hits = [dict objectForKey:@"hits"];
        if (KJudgeIsNullData(image)) {
            TXSMMessageOneImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageOneImgCell];
            [cell setupCellContent:image title:title where:from count:hits];
            return cell;
        }else {
            TXSMMessageNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageNoImgCell];
            [cell setupCellContentTitle:title where:from count:hits];
            return cell;
        }
    }else {
        if (count % 2 != 0) {
            NSArray *array = [self.viewModel.adDict objectForKey:@"29"];
            NSInteger index = (count - 1) / 2;
            index = index % array.count;
            NSDictionary *dict = [array objectAtIndex:index];
            TXSMMessageMoreImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageMoreImgCell];
            [cell setupCellContent:[dict objectForKey:@"image"] img2:[dict objectForKey:@"imageer"] img3:[dict objectForKey:@"imagesan"] title:[dict objectForKey:@"title"] where:nil count:nil];
            return cell;
        }else {
            NSArray *array = [self.viewModel.adDict objectForKey:@"28"];
            NSInteger index = count / 2;
            index = index % array.count;
            NSDictionary *dict = [array objectAtIndex:index];
            TXSMMessageAddCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageAddCell];
            [cell setupCellContent:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"] where:nil];
            return cell;
        }
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger type = (indexPath.row - 3) % 4;
    NSInteger count = (indexPath.row - 3) / 4;
    if (indexPath.row < 3 || (type != 0) ) {
        NSInteger index = indexPath.row < 3?indexPath.row:indexPath.row - count - 1;
        NSDictionary *dict = [self.dataArray objectAtIndex:index];
        NSString *image = [dict objectForKey:@"image"];
        if (KJudgeIsNullData(image)) {
            return kOneImgCellHeight;
        }else {
            return kNoImgCellHeight;
        }
    }else {
        if (count % 2 != 0) {
            return kMoreImgCellHeight;
        }else {
            return kAdCellHeight;
        }
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger type = (indexPath.row - 3) % 4;
    NSInteger count = (indexPath.row - 3) / 4;
    if (!_controller) {
        _controller = [LSKViewFactory getCurrentViewController];
    }
    if (indexPath.row < 3 || (type != 0) ) {
        NSInteger index = indexPath.row < 3?indexPath.row:indexPath.row - count - 1;
        NSDictionary *dict = [self.dataArray objectAtIndex:index];
        TXSMMessageDetailVC *detail = [[TXSMMessageDetailVC alloc]init];
        detail.dataDict = dict;
        detail.hidesBottomBarWhenPushed = YES;
        [_controller.navigationController pushViewController:detail animated:YES];
    }else {
        NSString *url = nil;
        NSString *title = nil;
        if (count % 2 != 0) {
            NSArray *array = [self.viewModel.adDict objectForKey:@"29"];
            NSInteger index = (count - 1) / 2;
            index = index % array.count;
            NSDictionary *dict = [array objectAtIndex:index];
            url = [dict objectForKey:@"url"];
            title = [dict objectForKey:@"title"];
        }else {
            NSArray *array = [self.viewModel.adDict objectForKey:@"28"];
            NSInteger index = count / 2;
            index = index % array.count;
            NSDictionary *dict = [array objectAtIndex:index];
            url = [dict objectForKey:@"url"];
            title = [dict objectForKey:@"title"];
        }
        if (KJudgeIsNullData(url)) {
            TXXLWebVC *webVC = [[TXXLWebVC alloc]init];
            webVC.titleString = title;
            webVC.loadUrl = url;
            webVC.hidesBottomBarWhenPushed = YES;
            [_controller.navigationController pushViewController:webVC animated:YES];
        }
    }
}
#pragma mark - init
- (void)_layoutMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:@selector(pullRrfreshData) footRefreshAction:@selector(pullMoreData) separatorColor:nil backgroundColor:nil];
    [tableView registerClass:[TXSMMessageAddCell class] forCellReuseIdentifier:kTXSMMessageAddCell];
    [tableView registerClass:[TXSMMessageOneImgCell class] forCellReuseIdentifier:kTXSMMessageOneImgCell];
    [tableView registerClass:[TXSMMessageMoreImgCell class] forCellReuseIdentifier:kTXSMMessageMoreImgCell];
    [tableView registerClass:[TXSMMessageNoImgCell class] forCellReuseIdentifier:kTXSMMessageNoImgCell];
    self.mainTableView = tableView;
    [self addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    
}
@end
