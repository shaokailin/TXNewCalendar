//
//  TXXLCalculateMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateMainVC.h"
#import "LSKBarnerScrollView.h"
#import "TXXLCategoryView.h"
#import "TXXLMiddelAdView.h"
#import "TXXLBottonAdView.h"
@interface TXXLCalculateMainVC ()
{
    CGFloat _bannerHeight;
    CGFloat _middleHeight;
    CGFloat _bottonHeight;
}
@property (nonatomic, weak) UIScrollView *mainScrollerView;
@property (nonatomic, weak) LSKBarnerScrollView *bannerScrollerView;
@property (nonatomic, weak) TXXLMiddelAdView *middleAdView;
@property (nonatomic, weak) TXXLCategoryView *categoryView;
@end

@implementation TXXLCalculateMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)pullDownRefresh {
    [self.mainScrollerView.mj_header endRefreshing];
}

- (void)initializeMainView {
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    self.mainScrollerView = scrollView;
    CGFloat contentHeight = 0;
    _middleHeight = WIDTH_RACE_6S(220) + 50;
    _bottonHeight = WIDTH_RACE_6S(112) + 50;
    contentHeight = _bannerHeight = WIDTH_RACE_6S(180);
    LSKBarnerScrollView *bannerView = [[LSKBarnerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _bannerHeight) placeHolderImage:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        
    }];
    self.bannerScrollerView = bannerView;
    [scrollView addSubview:bannerView];
    
    TXXLCategoryView *categoryView = [[TXXLCategoryView alloc]init];
    self.categoryView = categoryView;
    [scrollView addSubview:categoryView];
    [categoryView setupCategoryBtnArray:@[@"123",@"123",@"123",@"123",@"123",@"123",@"123"]];
    CGFloat height = [categoryView returnHeight];
    categoryView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
    contentHeight += height;
    contentHeight += 10;
    TXXLMiddelAdView *middleAdView = [[TXXLMiddelAdView alloc]initWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH, _middleHeight)];
    [middleAdView setupContentWithTitle:@"感情" english:@"Feelings" dataArray:@[@"123",@"123",@"123"]];
    self.middleAdView = middleAdView;
    [scrollView addSubview:middleAdView];
    contentHeight += _middleHeight;
    
    contentHeight += 20;
    TXXLBottonAdView *adView = [[TXXLBottonAdView alloc]init];
    adView.frame  = CGRectMake(0, contentHeight, SCREEN_WIDTH, _bottonHeight);
    adView.tag = 600;
    [adView setupContentWithTitle:@"财运" english:@"Fortune" dataDict:nil];
    [scrollView addSubview:adView];
    contentHeight += _bottonHeight;
    contentHeight += 10;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    [self.view addSubview:scrollView];
    WS(ws)
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    categoryView.clickBlock = ^(NSInteger index) {
        
    };
    middleAdView.clickBlock = ^(NSInteger index) {
        
    };
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
