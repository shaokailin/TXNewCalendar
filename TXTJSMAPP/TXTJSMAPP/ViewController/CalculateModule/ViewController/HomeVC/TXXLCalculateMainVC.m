//
//  TXXLCalculateMainVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateMainVC.h"
#import "TXXLCalculateHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXSMCalculateHomeHeaderView.h"
#import "TXSMHomeHotNewsCell.h"
#import "TXSMCalculateHomeCollectionCell.h"
static NSString * const kCalculateHomeData = @"kCalculateHomeData_save";
@interface TXXLCalculateMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    CGFloat _height;
}
@property (nonatomic, strong) TXSMCalculateHomeHeaderView *tableHeaderView;
@property (nonatomic, weak) UICollectionView *mainCollectionView;
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
    @weakify(self)
    _viewModel = [[TXXLCalculateHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.mainCollectionView.mj_header endRefreshing];
        if ([model isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = model;
            NSString *data = [LSKPublicMethodUtil dictionaryTransformToJson:model];
            [kUserMessageManager setMessageManagerForObjectWithKey:kCalculateHomeData value:data];
            [self.tableHeaderView setupContent:model];
            [self.mainCollectionView reloadData];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainCollectionView.mj_header endRefreshing];
    }];
    _viewModel.contactId = NSStringFormat(@"%@,%@,%@,%@,%@",kCalculateBannerId,kCalculateNavigationId,kCalculateFeelingId,kCalculateFortuneId,kCalculateAdId);
    _viewModel.limit = @"5,4,4,5,15";
    [self.mainCollectionView.mj_header beginRefreshing];
}
- (void)pullDownRefresh {
    [self.viewModel getHomeData:YES];
}
- (void)getSaveData {
    NSString *saveString = [kUserMessageManager getMessageManagerForObjectWithKey:kCalculateHomeData];
    if (KJudgeIsNullData(saveString)) {
        NSDictionary *saveDict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[saveString dataUsingEncoding:NSUTF8StringEncoding]];
        if (saveDict && [saveDict isKindOfClass:[NSDictionary class]]) {
            self.dataDictionary = saveDict;
            [self.tableHeaderView setupContent:saveDict];
            [self.mainCollectionView reloadData];
        }
    }
}
- (void)changeFrame:(CGFloat)height {
    _tableHeaderView.frame = CGRectMake(0, 0, SCREEN_WIDTH, height);
    _height = height;
    [self.mainCollectionView reloadData];
}
#pragma mark - delegate
#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_dataDictionary && [_dataDictionary objectForKey:kCalculateAdId]) {
        NSArray *data = [_dataDictionary objectForKey:kCalculateAdId];
        if (KJudgeIsArrayAndHasValue(data)) {
            return data.count;
        }
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXSMCalculateHomeCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXSMCalculateHomeCollectionCell forIndexPath:indexPath];
    NSArray *data = [_dataDictionary objectForKey:kCalculateAdId];
    NSDictionary *dict = [data objectAtIndex:indexPath.row];
    [cell setupCellContentWithImg:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self headerViewClick:kCalculateAdId index:indexPath.row];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, _height);
}
#pragma mark - 界面初始化
- (void)initializeMainView {
    WS(ws)
    _height = 0;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 1.5, 0);
    layout.itemSize =CGSizeMake((SCREEN_WIDTH - 3) / 3.0, 96);
    layout.minimumLineSpacing = 1.5;
    layout.minimumInteritemSpacing = 1.5;
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:nil];
    self.mainCollectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:kTXSMCalculateHomeCollectionCell bundle:nil] forCellWithReuseIdentifier:kTXSMCalculateHomeCollectionCell];
    _tableHeaderView = [[TXSMCalculateHomeHeaderView alloc]initWithFrame:CGRectZero];
    _tableHeaderView.frameBlock = ^(CGFloat height) {
        [ws changeFrame:height];
    };
    _tableHeaderView.eventBlock = ^(NSString *key, NSInteger index) {
        [ws headerViewClick:key index:index];
    };
    [collectionView addSubview:_tableHeaderView];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
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
