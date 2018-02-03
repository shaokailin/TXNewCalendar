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
#import "TXXLSolarTermAndFestivalVM.h"
#import "TXXLFestivalsProtocol.h"
@interface TXXLFestivalListVC ()
{
    NSInteger _currentTpye;
}
@property (nonatomic, weak)TXXLFestivalListHeaderView *headerView;
@property (nonatomic, weak)TXXLPublicFestivalView *publicFestivalView;
@property (nonatomic, weak)TXXLTwentyFourSolarTermsView *twentyFourView;
@property (nonatomic, weak)TXXLHolidaysListView *holidaysView;
@property (nonatomic, strong) TXXLSolarTermAndFestivalVM *viewModel;
@end

@implementation TXXLFestivalListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"节日节气";
    [self addNavigationBackButton];
    [self bindSignal];
    [self initializeMainView];
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLSolarTermAndFestivalVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [[self returnCurrentView]loadSucess:model];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [[self returnCurrentView]loadError];
    }];
    _viewModel.time = [[NSDate date]dateTransformToString:@"yyyy-MM-dd"];
}
- (void)loadData:(BOOL)isPull {
    _viewModel.type = _currentTpye;
    [_viewModel getSolarTermAndFestivalList:isPull];
}
- (void)changeShowWithState:(FestivalShowType)type {
    _currentTpye = type;
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
            [self.publicFestivalView selectCurrentView];
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
            [self.twentyFourView selectCurrentView];
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
            [self.holidaysView selectCurrentView];
        }
            break;
            
        default:
            break;
    }
}
- (id<TXXLFestivalsProtocol>)returnCurrentView {
    if (_currentTpye == 0) {
        return _publicFestivalView;
    }else if (_currentTpye == 1) {
        return self.twentyFourView;
    }else {
        return self.holidaysView;
    }
}
- (void)initializeMainView {
    _currentTpye = 0;
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
    publicFestivalView.loadBlock = ^(BOOL isCanLoad) {
        [ws loadData:isCanLoad];
    };
    [self.view addSubview:publicFestivalView];
    [publicFestivalView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(40, 0, ws.tabbarBetweenHeight, 0));
    }];
    [self changeShowWithState:0];
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
        twentyFourView.loadBlock = ^(BOOL isCanLoad) {
            [ws loadData:isCanLoad];
        };
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
        holidaysView.loadBlock = ^(BOOL isCanLoad) {
            [ws loadData:isCanLoad];
        };
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
