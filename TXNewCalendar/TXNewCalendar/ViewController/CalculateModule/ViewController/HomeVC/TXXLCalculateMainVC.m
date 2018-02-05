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
#import "TXXLCalculateHomeVM.h"
#import "TXXLWebVC.h"
static NSString * const kCalculateBannerId = @"11";
static NSString * const kCalculateNavigationId = @"13";
static NSString * const kCalculateFeelingId = @"14";
static NSString * const kCalculateFortuneId = @"15";
static NSString * const kCalculateCareerId = @"17";
static NSString * const kCalculateHomeData = @"kCalculateHomeData_save";
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
}
-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.bannerScrollerView viewDidAppearStartRun];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.bannerScrollerView viewDidDisappearStop];
}
#pragma mark - 事件处理
- (void)bottonActionClick:(NSInteger)type index:(NSInteger)index {
    NSString *key = nil;
    if (type == 0) {
        key = kCalculateFortuneId;
    }else {
        key = kCalculateCareerId;
    }
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:key];
        if (KJudgeIsArrayAndHasValue(array) && index < array.count) {
            NSDictionary *dict = [array objectAtIndex:index];
            [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"]];
        }
    }
}
- (void)middleClickUrl:(NSString *)url title:(NSString *)title {
    [self jumpWebView:title url:url];
}
- (void)bannerClick:(NSInteger)index {
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:kCalculateBannerId];
        if (KJudgeIsArrayAndHasValue(array) && index < array.count) {
            NSDictionary *dict = [array objectAtIndex:index];
            [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"]];
        }
    }
}
- (void)navigationClick:(NSInteger)index {
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:kCalculateNavigationId];
        if (KJudgeIsArrayAndHasValue(array) && index < array.count) {
            NSDictionary *dict = [array objectAtIndex:index];
            [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"]];
        }
    }
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url {
    if (KJudgeIsNullData(url)) {
        TXXLWebVC *webVC = [[TXXLWebVC alloc]init];
//        webVC.titleString = title;
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
        [self.mainScrollerView.mj_header endRefreshing];
        if ([model isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = model;
            [kUserMessageManager setMessageManagerForObjectWithKey:kCalculateHomeData value:model];
            [self setupContent:model];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainScrollerView.mj_header endRefreshing];
    }];
    _viewModel.contactId = NSStringFormat(@"%@,%@,%@,%@,%@",kCalculateBannerId,kCalculateNavigationId,kCalculateFeelingId,kCalculateFortuneId,kCalculateCareerId);
    _viewModel.limit = @"5,8,3,3,3";
    [_viewModel getHomeData:YES];
}
- (void)pullDownRefresh {
    [self.viewModel getHomeData:NO];
}
- (void)getSaveData {
    NSDictionary *saveDict = [kUserMessageManager getMessageManagerForObjectWithKey:kCalculateHomeData];
    if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
        self.dataDictionary = saveDict;
        [self setupContent:saveDict];
    }
}
- (void)setupContent:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        CGFloat contentHeight = _bannerHeight;
        NSArray *bannerArray = [dict objectForKey:kCalculateBannerId];
        [self.bannerScrollerView setupBannarContentWithUrlArray:bannerArray];
        NSArray *navigationArr = [dict objectForKey:kCalculateNavigationId];
        [self.categoryView setupCategoryBtnArray:navigationArr];
        CGFloat height = [self.categoryView returnHeight];
        self.categoryView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
        contentHeight += height;
        contentHeight += 10;
        NSArray *cardArr = [dict objectForKey:kCalculateFeelingId];
        if (KJudgeIsArrayAndHasValue(cardArr)) {
            self.middleAdView.hidden = NO;
            self.middleAdView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, _middleHeight);
            [self.middleAdView setupContentWithDataArray:cardArr];
            contentHeight += _middleHeight;
        }else {
            self.middleAdView.hidden = YES;
        }
        NSArray *fortune = [dict objectForKey:kCalculateFortuneId];
        TXXLBottonAdView *fortuneView = [self.mainScrollerView viewWithTag:600];
        if (KJudgeIsArrayAndHasValue(fortune)) {
            contentHeight += 20;
            if (fortuneView == nil) {
                fortuneView = [self customBottonViewWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH, _bottonHeight) flag:600];
            }
            [fortuneView setupContentWithData:fortune];
            contentHeight += _bottonHeight;
        }else if(fortuneView) {
            [fortuneView removeFromSuperview];
        }
        NSArray *career = [dict objectForKey:kCalculateCareerId];
        TXXLBottonAdView *careerView = [self.mainScrollerView viewWithTag:601];
        if (KJudgeIsArrayAndHasValue(fortune)) {
            contentHeight += 20;
            if (careerView == nil) {
                careerView = [self customBottonViewWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH, _bottonHeight) flag:601];
            }
            [careerView setupContentWithData:career];
            contentHeight += _bottonHeight;
        }else if(careerView) {
            [careerView removeFromSuperview];
        }
        
        contentHeight += 10;
        self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    }
}
- (TXXLBottonAdView *)customBottonViewWithFrame:(CGRect)frame flag:(NSInteger)flag {
    TXXLBottonAdView *bottonView = [[TXXLBottonAdView alloc]init];
    bottonView.frame = frame;
    bottonView.flag = flag;
    WS(ws)
    bottonView.clickBlock = ^(NSInteger flag, NSInteger type) {
        [ws bottonActionClick:flag index:type];
    };
    [self.mainScrollerView addSubview:bottonView];
    return bottonView;
}
- (void)initializeMainView {
    WS(ws)
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    self.mainScrollerView = scrollView;
    CGFloat contentHeight = 0;
    _middleHeight = WIDTH_RACE_6S(220) + 50;
    _bottonHeight = WIDTH_RACE_6S(112) + 50;
    contentHeight = _bannerHeight = WIDTH_RACE_6S(180);
    LSKBarnerScrollView *bannerView = [[LSKBarnerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _bannerHeight) placeHolderImage:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
        [ws bannerClick:selectedIndex];
    }];
    self.bannerScrollerView = bannerView;
    [scrollView addSubview:bannerView];
    
    TXXLCategoryView *categoryView = [[TXXLCategoryView alloc]init];
    self.categoryView = categoryView;
    [scrollView addSubview:categoryView];
    CGFloat height = [categoryView returnHeight];
    categoryView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
    contentHeight += height;
    contentHeight += 10;
    TXXLMiddelAdView *middleAdView = [[TXXLMiddelAdView alloc]initWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH, _middleHeight)];
    [middleAdView setupContentWithTitle:@"感情" english:@"Feelings"];
    self.middleAdView = middleAdView;
    [scrollView addSubview:middleAdView];
    middleAdView.hidden = YES;
    contentHeight += _middleHeight;
    
    
    contentHeight += 10;
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    [self.view addSubview:scrollView];
    
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    categoryView.clickBlock = ^(NSInteger index) {
        [ws navigationClick:index];
    };
    middleAdView.clickBlock = ^(NSString *url,NSString *title) {
        [ws middleClickUrl:url title:title];
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
