//
//  TXBZSMLiveAnalysisVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMLiveAnalysisVC.h"
#import "TXBZSMTodayAdView.h"
#import "TXBZSMTodayNavigationView.h"
#import "TXBZSMFortuneHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXBZSMContentMainView.h"
@interface TXBZSMLiveAnalysisVC ()
{
    TXBZSMFortuneHomeVM *_viewModel;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXBZSMTodayAdView *adView;
@property (nonatomic, strong) NSArray *adDictionary;
@property (nonatomic, weak) TXBZSMContentMainView *mainView;
@end

@implementation TXBZSMLiveAnalysisVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"八字命运分析"];
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
    _viewModel = [[TXBZSMFortuneHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.mainScrollView.mj_header endRefreshing];
        if (identifier == 10 && [model isKindOfClass:[NSArray class]]) {
            self.adDictionary = model;
            [self.adView setupAdMessage:self.adDictionary];
            if (CGRectGetHeight(self.adView.frame) == 0) {
                [self.adView mas_updateConstraints:^(MASConstraintMaker *make) {
                    make.height.mas_equalTo(WIDTH_RACE_6S(81) + 8);
                }];
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainScrollView.mj_header endRefreshing];
    }];
    _viewModel.contactId = NSStringFormat(@"%@",kFortuneMessageAd);
    _viewModel.limit = @"3";
    _viewModel.isLoadingAd = YES;
    [_viewModel getAdData:NO];
}
- (void)pullDownRefresh {
    [self.mainView refreshData];
    if (!self.adDictionary) {
         [_viewModel getAdData:NO];
    }else {
        [self.mainScrollView.mj_header endRefreshing];
    }
}
#pragma mark - method
- (void)navigationClick:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else {
        
    }
}
- (void)adClickIndex:(NSInteger)index {
    NSDictionary *dict = [self.adDictionary objectAtIndex:index];
    TXSMMessageDetailVC *detail = [[TXSMMessageDetailVC alloc]init];
    detail.titleString = [dict objectForKey:@"title"];
    detail.loadUrl = [dict objectForKey:@"url"];
    detail.pic = [dict objectForKey:@"pic"];
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)changeFrame:(CGFloat)height {
    CGRect frame = self.mainView.frame;
    frame.size.height = height;
    self.mainView.frame = frame;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetHeight(frame));
}
#pragma mark - 视图
- (void)initializeMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"livebg")];
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(357);
    }];
    TXBZSMTodayNavigationView *navigationView = [[TXBZSMTodayNavigationView alloc]init];
    navigationView.title = @"八字命运分析";
    @weakify(self)
    navigationView.navigationBlock = ^(NSInteger type) {
        @strongify(self)
        [self navigationClick:type];
    };
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(STATUSBAR_HEIGHT);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(self.navibarHeight);
    }];
    
    TXBZSMTodayAdView *adView = [[TXBZSMTodayAdView alloc]init];
    adView.adBlock = ^(NSInteger index) {
        @strongify(self)
        [self adClickIndex:index];
    };
    self.adView = adView;
    [self.view addSubview:adView];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        make.height.mas_equalTo(0);
    }];
    
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    self.mainScrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(self.navibarHeight + STATUSBAR_HEIGHT);
        make.bottom.equalTo(self.adView.mas_top).with.offset(-5);
    }];
    
    TXBZSMContentMainView *mainView = [[TXBZSMContentMainView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
    mainView.frameBlock = ^(CGFloat height) {
        @strongify(self)
        [self changeFrame:height];
    };
    self.mainView = mainView;
    [scrollView addSubview:mainView];
    [mainView refreshData];
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
