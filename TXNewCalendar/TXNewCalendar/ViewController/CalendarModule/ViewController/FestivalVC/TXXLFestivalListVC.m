//
//  TXXLFestivalListVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLFestivalListVC.h"
#import "TXXLFestivalListHeaderView.h"
#import "TXXLPublicFestivalView.h"
#import "TXXLTwentyFourSolarTermsView.h"
#import "TXXLHolidaysListView.h"
@interface TXXLFestivalListVC ()
@property (nonatomic, weak)TXXLFestivalListHeaderView *headerView;
@property (nonatomic, weak)TXXLPublicFestivalView *publicFestivalView;
@property (nonatomic, weak)TXXLTwentyFourSolarTermsView *twentyFourView;
@property (nonatomic, weak)TXXLHolidaysListView *holidaysView;
@end

@implementation TXXLFestivalListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"节日节气";
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)changeShowWithState:(FestivalShowType)type {
    switch (type) {
        case FestivalShowType_Public:
        {
            self.publicFestivalView.hidden = NO;
            if (_twentyFourView && !_twentyFourView.hidden) {
                _twentyFourView.hidden = YES;
            }
            if (_holidaysView && !_holidaysView.hidden) {
                _holidaysView.hidden = YES;
            }
        }
            break;
        case FestivalShowType_TwentyFour:
        {
            self.twentyFourView.hidden = NO;
            if (!_publicFestivalView.hidden) {
                _publicFestivalView.hidden = YES;
            }
            if (_holidaysView && !_holidaysView.hidden) {
                _holidaysView.hidden = YES;
            }
        }
            break;
        case FestivalShowType_Holidays:
        {
            self.holidaysView.hidden = NO;
            if (!_publicFestivalView.hidden) {
                _publicFestivalView.hidden = YES;
            }
            if (_twentyFourView && !_twentyFourView.hidden) {
                _twentyFourView.hidden = YES;
            }
        }
            break;
            
        default:
            break;
    }
}
- (void)initializeMainView {
    TXXLFestivalListHeaderView *headerView = [[TXXLFestivalListHeaderView alloc]init];
    self.headerView = headerView;
    [self.view addSubview:headerView];
    WS(ws)
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws.view);
        make.height.mas_equalTo(40);
    }];
    headerView.clickBlock = ^(FestivalShowType showType) {
        [ws changeShowWithState:showType];
    };
    
    TXXLPublicFestivalView *publicFestivalView = [[TXXLPublicFestivalView alloc]init];
    self.publicFestivalView = publicFestivalView;
    [self.view addSubview:publicFestivalView];
    [publicFestivalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(40, 0, ws.tabbarBetweenHeight, 0));
    }];
}
- (TXXLTwentyFourSolarTermsView *)twentyFourView {
    if (!_twentyFourView) {
        TXXLTwentyFourSolarTermsView *twentyFourView = [[TXXLTwentyFourSolarTermsView alloc]init];
        _twentyFourView = twentyFourView;
        [self.view addSubview:twentyFourView];
        WS(ws)
        [twentyFourView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(40, 0, ws.tabbarBetweenHeight, 0));
        }];
    }
    return _twentyFourView;
}
- (TXXLHolidaysListView *)holidaysView {
    if (!_holidaysView) {
        TXXLHolidaysListView *holidaysView = [[TXXLHolidaysListView alloc]init];
        _holidaysView = holidaysView;
        [self.view addSubview:holidaysView];
        WS(ws)
        [holidaysView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(40, 0, ws.tabbarBetweenHeight, 0));
        }];
    }
    return _holidaysView;
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
