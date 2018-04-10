//
//  TXXLCalculateMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateMainVC.h"
//#import "TXXLCalculateHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXSMCalculateHomeHeaderView.h"
//static NSString * const kCalculateHomeData = @"kCalculateHomeData_save";
@interface TXXLCalculateMainVC ()
{
    CGFloat _height;
}
@property (nonatomic, strong) TXSMCalculateHomeHeaderView *tableHeaderView;
@property (nonatomic, weak) UIScrollView *mainScrollerView;
//@property (nonatomic, strong) TXXLCalculateHomeVM *viewModel;
@property (nonatomic, strong) NSDictionary *dataDictionary;
@end

@implementation TXXLCalculateMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
//    [self getSaveData];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"命理首页"];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.tableHeaderView viewDidAppearStartRun];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.tableHeaderView viewDidDisappearStop];
    [kUserMessageManager analiticsViewDisappear:self];
}
#pragma mark - 事件处理
- (void)headerViewClick:(NSString *)key index:(NSInteger)index {
    if (self.dataDictionary) {
        NSArray *array = [self.dataDictionary objectForKey:key];
        if (KJudgeIsArrayAndHasValue(array) && index < array.count) {
            NSDictionary *dict = [array objectAtIndex:index];
            [self jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"] image:[dict objectForKey:@"image"]];
        }
    }
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url image:(NSString *)image {
    if (KJudgeIsNullData(url)) {
        TXSMMessageDetailVC *webVC = [[TXSMMessageDetailVC alloc]init];
        webVC.titleString = title;
        webVC.loadUrl = url;
        webVC.pic = image;
        webVC.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:webVC animated:YES];
    }
}

#pragma mark -数据处理
- (void)bindSignal {
//    @weakify(self)
//    _viewModel = [[TXXLCalculateHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
//        @strongify(self)
//        [self.mainScrollerView.mj_header endRefreshing];
//        if ([model isKindOfClass:[NSDictionary class]]) {
//            self.dataDictionary = model;
//            NSString *data = [LSKPublicMethodUtil dictionaryTransformToJson:model];
//            [kUserMessageManager setMessageManagerForObjectWithKey:kCalculateHomeData value:data];
//            [self.tableHeaderView setupContent:model];
//        }
//    } failure:^(NSUInteger identifier, NSError *error) {
//        @strongify(self)
//        [self.mainScrollerView.mj_header endRefreshing];
//    }];
//    _viewModel.contactId = NSStringFormat(@"%@,%@,%@,%@,%@",kCalculateBannerId,kCalculateNavigationId,kCalculateHotId,kCalculateChoiceId,kCalculateSynthesizeId);
//    _viewModel.limit = @"5,8,5,4,4";
//    [self.mainScrollerView.mj_header beginRefreshing];
}
- (void)pullDownRefresh {
//    [self.viewModel getHomeData:YES];
}
//- (void)getSaveData {
//    NSString *saveString = [kUserMessageManager getMessageManagerForObjectWithKey:kCalculateHomeData];
//    if (KJudgeIsNullData(saveString)) {
//        NSDictionary *saveDict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[saveString dataUsingEncoding:NSUTF8StringEncoding]];
//        if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
//            self.dataDictionary = saveDict;
//            [self.tableHeaderView setupContent:saveDict];
//        }
//    }
//}
- (void)changeFrame:(CGFloat)height {
    _height = height;
    _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    self.mainScrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, height);
}

#pragma mark - 界面初始化
- (void)initializeMainView {
    WS(ws)
    self.dataDictionary = [[NSDictionary alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"numerologyData" ofType:@"plist"]];
    _height = 0;
    UIScrollView *scrollerView = [LSKViewFactory initializeScrollViewTarget:self headRefreshAction:nil footRefreshAction:nil];
    _tableHeaderView = [[TXSMCalculateHomeHeaderView alloc]initWithFrame:CGRectZero];
    _tableHeaderView.frameBlock = ^(CGFloat height) {
        [ws changeFrame:height];
    };
    _tableHeaderView.eventBlock = ^(NSString *key, NSInteger index) {
        [ws headerViewClick:key index:index];
    };
    [scrollerView addSubview:_tableHeaderView];
    self.mainScrollerView = scrollerView;
    [self.view addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
    [self.tableHeaderView setupContent:self.dataDictionary];
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
