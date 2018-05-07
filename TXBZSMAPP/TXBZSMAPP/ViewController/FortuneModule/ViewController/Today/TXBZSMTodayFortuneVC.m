//
//  TXBZSMTodayFortuneVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTodayFortuneVC.h"
#import "TXBZSMTodayAdView.h"
#import "TXBZSMTodayMessageView.h"
#import "TXBZSMTodayHeaderView.h"
#import "TXBZSMTodayNavigationView.h"
@interface TXBZSMTodayFortuneVC ()
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXBZSMTodayHeaderView *headView;
@property (nonatomic, weak) TXBZSMTodayMessageView *messageView;
@property (nonatomic, weak) TXBZSMTodayAdView *adView;
@end

@implementation TXBZSMTodayFortuneVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark - event
- (void)setupContent {
    if (self.dataDictionary) {
        [self.messageView setupContentDate:self.dataDictionary];
    }
}
- (void)navigationClick:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else {
        
    }
}
- (void)adClickIndex:(NSInteger)index {
    
}
- (void)pullDownRefresh {
    [self.mainScrollView.mj_header endRefreshing];
}
- (void)changeFrame:(CGFloat)height {
    CGRect frame = self.messageView.frame;
    frame.size.height = height;
    self.messageView.frame = frame;
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, CGRectGetHeight(frame) + frame.origin.y);
}
#pragma mark - 视图
- (void)initializeMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"today_bg")];
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(219);
    }];
    TXBZSMTodayNavigationView *navigationView = [[TXBZSMTodayNavigationView alloc]init];
    navigationView.title = @"今日运势";
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
    adView.backgroundColor = [UIColor redColor];
    self.adView = adView;
    [self.view addSubview:adView];
    [adView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        make.height.mas_equalTo(WIDTH_RACE_6S(81) + 8);
    }];
    
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil];
    self.mainScrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(self.navibarHeight + STATUSBAR_HEIGHT);
        make.bottom.equalTo(self.adView.mas_top).with.offset(-5);
    }];
    
    TXBZSMTodayHeaderView *headerView = [[TXBZSMTodayHeaderView alloc]init];
    self.headView = headerView;
    [scrollView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(WIDTH_RACE_6S(155));
    }];
    
    TXBZSMTodayMessageView *messageView = [[TXBZSMTodayMessageView alloc]initWithFrame:CGRectMake(0, WIDTH_RACE_6S(155) + 8, SCREEN_WIDTH, 200)];
    messageView.frameBlock = ^(CGFloat height) {
        @strongify(self)
        [self changeFrame:height];
    };
    self.messageView = messageView;
    [scrollView addSubview:messageView];
    [self setupContent];
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
