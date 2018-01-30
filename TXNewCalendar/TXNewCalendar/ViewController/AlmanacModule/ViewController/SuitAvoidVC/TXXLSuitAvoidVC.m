//
//  TXXLSuitAvoidVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidVC.h"
#import "TXXLSuitAvoidNatigationView.h"
#import "TXXLSuitAvoidTableViewCell.h"
#include "TXXLSuitAvoidHeaderTableViewCell.h"
@interface TXXLSuitAvoidVC ()<UITableViewDelegate,UITableViewDataSource> {
    NSInteger _currentIndex;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) TXXLSuitAvoidNatigationView *titleView;
@end

@implementation TXXLSuitAvoidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeNavigationTitleView];
    [self initializeMainView];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [_titleView removeFromSuperview];
}

#pragma mark - 私有事件
//导航栏切换
- (void)navigaitonClick:(NSInteger)index {
    _currentIndex = index;
    [self.mainTableView reloadData];
}
#pragma mark - default value
- (NSArray *)returnSuitHeaderData {
    return @[@{@"title":@"祭祀",@"detail":@"指祠堂之祭祀、即拜祭祖先或庙寺的祭拜、拜神明等事。"},@{@"title":@"祈福",@"detail":@"就是去寺庙上香还愿，祈求神明降福或设蘸还愿之事。"},@{@"title":@"求嗣",@"detail":@"向神明祈求后嗣(子孙)之意。也就是求子啦"}];
}
- (NSArray *)returnAvoidHeaderData {
    return @[@{@"title":@"祈福",@"detail":@"就是去寺庙上香还愿，祈求神明降福或设蘸还愿之事。"},@{@"title":@"祭祀",@"detail":@"指祠堂之祭祀、即拜祭祖先或庙寺的祭拜、拜神明等事。"}];
}

#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_currentIndex == 0) {
        return 4 + 1;
    }else {
        return 4 + 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TXXLSuitAvoidHeaderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSuitAvoidHeaderTableViewCell];
        [cell setupContentWithType:_currentIndex setupContent:_currentIndex == 0?[self returnSuitHeaderData]:[self returnAvoidHeaderData]];
        return cell;
    }else {
        TXXLSuitAvoidTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLSuitAvoidTableViewCell];
        if (indexPath.row == 1) {
            [cell setupContentWithTitle:@"幸运生肖" setupContent:@[@{@"title":@"六合生肖：龙",@"detail":@"今日与生肖龙（辰）。六合是一种暗合，该生肖是暗中帮助你的贵人"}]];
        }else if (indexPath.row == 2) {
            [cell setupContentWithTitle:@"值神" setupContent:@[@{@"detail":@"数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假数据为假"}]];
        }else if (indexPath.row == 3) {
            [cell setupContentWithTitle:@"凶神宜忌" setupContent:@[@{@"title":@"祭祀",@"detail":@"指祠堂之祭祀、即拜祭祖先或庙寺的祭拜、拜神明等事。"},@{@"title":@"祈福",@"detail":@"就是去寺庙上香还愿，祈求神明降福或设蘸还愿之事。"},@{@"title":@"求嗣",@"detail":@"向神明祈求后嗣(子孙)之意。也就是求子啦"}]];
        }else if (indexPath.row == 4) {
            [cell setupContentWithTitle:@"彭祖百忌" setupContent:@[@{@"title":@"祭祀",@"detail":@"指祠堂之祭祀、即拜祭祖先或庙寺的祭拜、拜神明等事。指祠堂之祭祀、即拜祭祖先或庙寺的祭拜、拜神明等事。"},@{@"title":@"祈福",@"detail":@"就是去寺庙上香还愿，祈求神明降福或设蘸还愿之事。"}]];
        }
        return cell;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        CGFloat top =  10 + 12 + 2 + 40 + 20;
        if (_currentIndex == 0) {
            return top + 17 + 18 + 21 + 13 + 17 + 18 + 21 + 13  + 17 + 18 + 21 + 13;
        }else {
            return top + 17 + 18 + 21 + 13 + 17 + 18 + 21 + 13;
        }
    }
    CGFloat topHeight = 10 + 2 + 18 + 20 + 17;
    if (indexPath.row == 1) {
        return  topHeight + 18 + 15 + 17 + 28;
    }else if (indexPath.row == 2) {
        return  topHeight + 18 + 55;
    }else if (indexPath.row == 3) {
        return  topHeight + 18 + 17 + 15 + 13  + 18 + 17 + 15 + 13  + 18 + 17 + 15 + 13;
    }else if (indexPath.row == 4) {
        return topHeight  + 18 + 17 + 15 + 13 +  + 18 + 17 + 15 + 28;
    }
    if (_currentIndex == 0) {
        
    }else {
        
    }
    return 10;
}
#pragma mark -界面初始化
- (void)initializeNavigationTitleView {
    _titleView = [[TXXLSuitAvoidNatigationView alloc]initWithFrame:CGRectMake(0, (self.navibarHeight - 26) / 2.0, 121, 26)];
    @weakify(self)
    _titleView.navigationBlock = ^(NSInteger index) {
        @strongify(self)
        [self navigaitonClick:index];
    };
    self.navigationItem.titleView = _titleView;
}
- (void)initializeMainView {
    _currentIndex = 0;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:[UIColor whiteColor]];
    self.mainTableView = mainTableView;
    [self.mainTableView registerClass:[TXXLSuitAvoidTableViewCell class] forCellReuseIdentifier:kTXXLSuitAvoidTableViewCell];
    [self.mainTableView registerClass:[TXXLSuitAvoidHeaderTableViewCell class] forCellReuseIdentifier:kTXXLSuitAvoidHeaderTableViewCell];
    [self.view addSubview:mainTableView];
    WS(ws)
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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
