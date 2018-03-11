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
static CGFloat kOneImgCellHeight = 103;
static CGFloat kNoImgCellHeight = 83;
static CGFloat kAdCellHeight = 232;
static CGFloat kMoreImgCellHeight = 139;
@interface TXSMMessageListView ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@end
@implementation TXSMMessageListView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)selectViewChange {
    [self.mainTableView.mj_header beginRefreshing];
}
- (void)pullMoreData {
    [self.mainTableView.mj_header endRefreshing];
}
- (void)pullRrfreshData {
    [self.mainTableView.mj_header endRefreshing];
}
#pragma  mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger type = indexPath.row % 4;
    if (type == 0) {
        TXSMMessageOneImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageOneImgCell];
        [cell setupCellContent:nil title:@"凯学生凯学生凯学生凯学生凯学生凯学生凯学生凯学生" where:@"第一星网站" count:@"425355"];
        return cell;
    }else if (type == 1){
        TXSMMessageMoreImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageMoreImgCell];
        [cell setupCellContent:nil img2:nil img3:nil title:@"凯学生凯学生凯学生凯学生凯学生凯学生凯学生凯学生" where:@"第一星网站" count:@"425355"];
        return cell;
    }else if (type == 2){
        TXSMMessageNoImgCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageNoImgCell];
        [cell setupCellContentTitle:@"凯学生凯学生凯学生凯学生凯学生凯学生凯学生凯学生凯学生凯学生" where:@"第一星网站" count:@"425355"];
        return cell;
    }else {
        TXSMMessageAddCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMMessageAddCell];
        [cell setupCellContent:nil title:@"凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生凯先生" where:@"凯先生"];
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger type = indexPath.row % 4;
    if (type == 0) {
        return kOneImgCellHeight;
    }else if (type == 1){
        return kMoreImgCellHeight;
    }else if (type == 2){
        return kNoImgCellHeight;
    }else {
        return kAdCellHeight;
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
