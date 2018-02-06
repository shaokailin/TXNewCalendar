//
//  TXXLSuitAvoidVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidVC.h"
#import "TXXLSuitAvoidHeaderView.h"
#import "TXXLSuitAvoidContentView.h"
#import "TXXLAlmanacDetailVM.h"
@interface TXXLSuitAvoidVC ()
@property (nonatomic, strong) TXXLAlmanacDetailVM *viewModel;
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXXLSuitAvoidHeaderView *suitView;
@property (nonatomic, weak) TXXLSuitAvoidHeaderView *avoidView;
@end

@implementation TXXLSuitAvoidVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"黄历现代文";
    [self addNavigationBackButton];
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"黄历现代文"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_index > 1) {
        UIView *view = [self.mainScrollView viewWithTag:400 + _index];
        if (view) {
            self.mainScrollView.contentOffset = CGPointMake(0, view.frame.origin.y);
//            [self.mainScrollView scrollRectToVisible:view.frame animated:YES];
        }
    }
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLAlmanacDetailVM alloc]initWithSuccessBlock:^(NSUInteger identifier, TXXLAlmanacDetailModel *model) {
        @strongify(self)
        [self setupViewContent:model];
        [self.mainScrollView.mj_header endRefreshing];
        if (self.index > 1) {
            UIView *view = [self.mainScrollView viewWithTag:400 + self.index];
            if (view) {
                self.mainScrollView.contentOffset = CGPointMake(0, view.frame.origin.y);
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainScrollView.mj_header endRefreshing];
    }];
    [_viewModel getAlmanacDetailData:NO];
}
- (void)pullDownRefresh {
    [_viewModel getAlmanacDetailData:YES];
}
- (void)setupViewContent:(TXXLAlmanacDetailModel *)model {
    CGFloat contentHeight = 10;
    CGFloat viewHeight = 0;
    [self.suitView setupContent:model.yi];
    viewHeight = self.suitView.contentHeight;
    self.suitView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
    contentHeight += viewHeight;
    contentHeight += 10;
    
    [self.avoidView setupContent:model.ji];
    viewHeight = self.avoidView.contentHeight;
    self.avoidView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
    contentHeight += viewHeight;
    contentHeight += 10;
    
    for (int i = 2; i < 12; i ++) {
        TXXLSuitAvoidContentView *contentView = (TXXLSuitAvoidContentView *)[self.mainScrollView viewWithTag:400 + i];
        if (i == 2) {
            [contentView setupContentWithDic:model.lucky];
        }else if (i == 3) {
            [contentView setupContentWithDic:model.chong_sha];
        }else if (i == 4) {
            [contentView setupContentWithDic:model.zhi_shen];
        }else if (i == 5) {
            [contentView setupContentArr:model.na_yin];
        }else if (i == 6) {
            [contentView setupContentWithDic:model.jishen];
        }else if (i == 7) {
            [contentView setupContentWithDic:model.xiong];
        }else if (i == 8) {
            [contentView setupContentArr:model.tai_shen];
        }else if (i == 9) {
            [contentView setupContentArr:model.peng_zu];
        }else if (i == 10) {
            [contentView setupContentArr:model.jian_chu];
        }else if (i == 11) {
            [contentView setupContentArr:model.xing_su];
        }
        viewHeight = contentView.contentHeight;
        contentView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
        contentHeight += viewHeight;
        contentHeight += 10;
    }
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    
}
#pragma mark -界面初始化
- (void)initializeMainView {
    UIScrollView *mainScrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    mainScrollView.backgroundColor = [UIColor whiteColor];
    self.mainScrollView = mainScrollView;
    [self.view addSubview:mainScrollView];
    TXXLSuitAvoidHeaderView *suitView = [[TXXLSuitAvoidHeaderView alloc]initWithHeaderType:0];
    CGFloat contentHeight = 10;
    CGFloat viewHeight = suitView.contentHeight;
    suitView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
    self.suitView = suitView;
    [mainScrollView addSubview:suitView];
    
    contentHeight += viewHeight;
    contentHeight += 10;
    TXXLSuitAvoidHeaderView *avoidView = [[TXXLSuitAvoidHeaderView alloc]initWithHeaderType:1];
    viewHeight = avoidView.contentHeight;
    avoidView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
    self.avoidView = avoidView;
    [mainScrollView addSubview:avoidView];
    contentHeight += 10;
    contentHeight += viewHeight;
    for (int i = 2; i < 12; i++) {
        TXXLSuitAvoidContentView *contentView = [[TXXLSuitAvoidContentView alloc]initWithHeaderType:i];
        contentView.tag = 400 + i;
        viewHeight = contentView.contentHeight;
        contentView.frame = CGRectMake(10, contentHeight, SCREEN_WIDTH - 20, viewHeight);
        [mainScrollView addSubview:contentView];
        contentHeight += 10;
        contentHeight += viewHeight;
    }
    contentHeight += 10;
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    WS(ws)
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
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
