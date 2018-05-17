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
#import "TXBZSMFortuneHomeVM.h"
#import "TXSMMessageDetailVC.h"
@interface TXBZSMTodayFortuneVC ()
{
    TXBZSMFortuneHomeVM *_viewModel;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXBZSMTodayHeaderView *headView;
@property (nonatomic, weak) TXBZSMTodayMessageView *messageView;
@property (nonatomic, weak) TXBZSMTodayAdView *adView;
@property (nonatomic, strong) NSArray *adDictionary;
@end

@implementation TXBZSMTodayFortuneVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"运势详情"];
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
        }else if ([model isKindOfClass:[NSDictionary class]] && identifier == 20) {
            self.dataDictionary = model;
            if (self.refreshBlock) {
                self.refreshBlock(model);
            }
            [self setupContent];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainScrollView.mj_header endRefreshing];
    }];
    _viewModel.xingzuo = _xingzuo;
    _viewModel.contactId = NSStringFormat(@"%@",kFortuneMessageAd);
    _viewModel.limit = @"3";
    _viewModel.isLoadingAd = YES;
    if (!_dataDictionary) {
        [_viewModel getHomeData:NO];
    }else {
        [_viewModel getAdData:NO];
    }
}
- (void)pullDownRefresh {
    [_viewModel getHomeData:YES];
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
    NSDictionary *dict = [self.adDictionary objectAtIndex:index];
    TXSMMessageDetailVC *detail = [[TXSMMessageDetailVC alloc]init];
    detail.titleString = [dict objectForKey:@"title"];
    detail.loadUrl = [dict objectForKey:@"url"];
    detail.pic = [dict objectForKey:@"pic"];
    [self.navigationController pushViewController:detail animated:YES];
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
    navigationView.title = @"运势";
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
    
    TXBZSMTodayHeaderView *headerView = [[TXBZSMTodayHeaderView alloc]init];
    self.headView = headerView;
    [scrollView addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(WIDTH_RACE_6S(155));
    }];
    [self setupContent];
}
- (TXBZSMTodayMessageView *)messageView {
    if (!_messageView) {
        TXBZSMTodayMessageView *messageView = [[TXBZSMTodayMessageView alloc]initWithFrame:CGRectMake(0, WIDTH_RACE_6S(155) + 8, SCREEN_WIDTH, 200)];
        @weakify(self)
        messageView.frameBlock = ^(CGFloat height) {
            @strongify(self)
            [self changeFrame:height];
        };
        self.messageView = messageView;
        [self.mainScrollView addSubview:messageView];
    }
    return _messageView;
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
