//
//  TXXLAlmanacMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacMainVC.h"
#import "TXXLAlmanacSearchView.h"
#import "TXXLAlmanacMainView.h"
#import "LSKImageManager.h"
#import "TXXLSuitAvoidVC.h"
#import "TXXLMoreSearchVC.h"
#import "TXXLHoursDetailVC.h"
#import "TXXLCompassDetailVC.h"
#import "TXXLAlmanacHomeVM.h"
#import "TXXLSearchDetailVC.h"
@interface TXXLAlmanacMainVC ()
{
    NSInteger _changeDateEventCount;
    NSDate *_currentDate;
    NSInteger _jumpIndex;
    BOOL _isViewIndex;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXXLAlmanacMainView *mainTimeView;
@property (nonatomic, weak) TXXLAlmanacSearchView *searchView;
@property (nonatomic, weak) UIImageView *swiptImageView;
@property (nonatomic, strong) TXXLAlmanacHomeVM *viewModel;
@end

@implementation TXXLAlmanacMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"黄历首页"];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isViewIndex = YES;
    [self.mainTimeView viewDidAppearStartHeading];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    _isViewIndex = NO;
    [self.mainTimeView viewDidDisappearStopHeading];
    [kUserMessageManager analiticsViewDisappear:self];
}

#pragma mark 网络请求
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLAlmanacHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 0) {
            [self.mainTimeView setupMessageContent:model];
            if (_jumpIndex != -1) {
                _jumpIndex = -1;
                [self eventClick:_jumpIndex index:0];
            }
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainTimeView setupNilDate];
    }];
    [self loadData:YES];
}
- (void)loadData:(BOOL)isFirst {
    _viewModel.dateString = [_currentDate dateTransformToString:@"yyyy-MM-dd"];;
    [_viewModel getAlmanacHomeData:isFirst];
}
#pragma mark - 回调事件
//吉日查询事件
- (void)searchViewClickEvent:(SearchEventType) type{
    if (type == SearchEventType_All) {
        TXXLMoreSearchVC *moreVC = [[TXXLMoreSearchVC alloc]init];
        moreVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moreVC animated:YES];
    }else {
        TXXLSearchDetailVC *searchDetailVC = [[TXXLSearchDetailVC alloc]init];
        NSString *title = nil;
        if (type == SearchEventType_Marry) {
            title = @"嫁娶";
        }else if (type == SearchEventType_Open) {
            title = @"开市";
        }else if (type == SearchEventType_Housing) {
            title = @"入宅";
        }
        searchDetailVC.isAvoid = NO;
        searchDetailVC.titleString = title;
        searchDetailVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:searchDetailVC animated:YES];
    }
}
- (void)eventClick:(EventType)type index:(NSInteger)index {
    if (type != EventType_Detail) {
        if (self.viewModel.messageModel != nil) {
            if (type == EventType_Hours) {
                TXXLHoursDetailVC *hoursVC = [[TXXLHoursDetailVC alloc]init];
                hoursVC.hoursArray = self.viewModel.messageModel.h_detail;
                hoursVC.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:hoursVC animated:YES];
            }else if (type == EventType_Compass) {
                TXXLCompassDetailVC *compassView = [[TXXLCompassDetailVC alloc]init];
                compassView.position = self.viewModel.messageModel.position;
                compassView.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:compassView animated:YES];
            }
        }else {
            _jumpIndex = type;
            [self loadData:YES];
        }
    }else if (type == EventType_Detail) {
        TXXLSuitAvoidVC *suitAvoidVC = [[TXXLSuitAvoidVC alloc]init];
        suitAvoidVC.loadingDateString = [_currentDate dateTransformToString:@"yyyy-MM-dd"];
        suitAvoidVC.index = index;
        suitAvoidVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:suitAvoidVC animated:YES];
    }
}
- (void)swiptViewEvent:(DirectionType)direction date:(NSDate *)date{
    _currentDate = date;
    [self loadData:NO];
    if (!_isViewIndex) {
        [self.mainScrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        return;
    }
    self.swiptImageView.hidden = NO;
    CGFloat width = CGRectGetWidth(self.swiptImageView.frame);
    self.swiptImageView.image = [LSKImageManager makeImageWithView:self.view];
    [UIView animateWithDuration:0.3 animations:^{
        self.swiptImageView.frame = CGRectMake(direction == 1 ?SCREEN_WIDTH + width:-width, 0, width, CGRectGetHeight(self.swiptImageView.frame));
    }completion:^(BOOL finished) {
        self.swiptImageView.frame = CGRectMake(0, 0, width, CGRectGetHeight(self.swiptImageView.frame));
        self.swiptImageView.hidden = YES;
        self.swiptImageView.image = nil;
    }];
}

- (UIImageView *)swiptImageView {
    if (!_swiptImageView) {
        UIImageView *imageView = [[UIImageView alloc]init];
        imageView.frame = self.view.bounds;
        _swiptImageView = imageView;
        [self.view addSubview:imageView];
    }
    return _swiptImageView;
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    _jumpIndex = -1;
    WS(ws)
    UIScrollView *mainScrollView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    mainScrollView.showsHorizontalScrollIndicator = NO;
    mainScrollView.backgroundColor = [UIColor clearColor];
    self.mainScrollView = mainScrollView;
    CGFloat contentHeight = 0;
    contentHeight += 166;
    contentHeight += 1;
    contentHeight += 277;
    contentHeight += 1;
    contentHeight += 70;
    TXXLAlmanacMainView *mainView = [[TXXLAlmanacMainView alloc]init];
    mainView.clickBlock = ^(EventType type, NSInteger index) {
        [ws eventClick:type index:index];
    };
    mainView.timeBlock = ^(DirectionType direction, NSDate *date) {
        
        [ws swiptViewEvent:direction date:date];
    };
    _currentDate = mainView.currentDate;
    self.mainTimeView = mainView;
    [mainScrollView addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScrollView);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(contentHeight);
    }];
    TXXLAlmanacSearchView *searchView = [[TXXLAlmanacSearchView alloc]init];
    searchView.clickBlock = ^(SearchEventType eventType) {
        [ws searchViewClickEvent:eventType];
    };
    self.searchView = searchView;
    [mainScrollView addSubview:searchView];
    [searchView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(mainScrollView);
        make.right.equalTo(mainView);
        make.top.equalTo(mainView.mas_bottom).with.offset(1);
        make.height.mas_equalTo(142);
    }];
    contentHeight += 1;
    contentHeight += 142;
    mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    [self.view addSubview:mainScrollView];
    [mainScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
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
