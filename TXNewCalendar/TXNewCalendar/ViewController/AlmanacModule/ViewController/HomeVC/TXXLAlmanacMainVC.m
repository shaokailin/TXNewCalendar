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
@interface TXXLAlmanacMainVC ()
{
    NSInteger _changeDateEventCount;
    NSDate *_currentDate;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) TXXLAlmanacMainView *mainTimeView;
@property (nonatomic, weak) TXXLAlmanacSearchView *searchView;
@property (nonatomic, weak) UIImageView *swiptImageView;
@end

@implementation TXXLAlmanacMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.mainTimeView viewDidAppearStartHeading];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.mainTimeView viewDidDisappearStopHeading];
}
#pragma mark - 回调事件
//吉日查询事件
- (void)searchViewClickEvent:(SearchEventType) type{
    if (type == SearchEventType_All) {
        TXXLMoreSearchVC *moreVC = [[TXXLMoreSearchVC alloc]init];
        moreVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:moreVC animated:YES];
    }
}
- (void)eventClick:(EventType)type {
    if (type == EventType_Hours) {
        TXXLHoursDetailVC *hoursVC = [[TXXLHoursDetailVC alloc]init];
        hoursVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:hoursVC animated:YES];
    }else if (type == EventType_Compass) {
        TXXLSuitAvoidVC *suitView = [[TXXLSuitAvoidVC alloc]init];
        suitView.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:suitView animated:YES];
    }
}
- (void)swiptViewEvent:(DirectionType)direction {
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
    WS(ws)
    UIScrollView *mainScrollView = [[UIScrollView alloc]init];
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
    mainView.clickBlock = ^(EventType type) {
        [ws eventClick:type];
    };
    mainView.timeBlock = ^(DirectionType direction) {
        [ws swiptViewEvent:direction];
    };
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
