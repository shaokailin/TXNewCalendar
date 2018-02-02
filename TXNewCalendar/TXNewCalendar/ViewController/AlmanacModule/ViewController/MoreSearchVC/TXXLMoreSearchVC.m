//
//  TXXLMoreSearchVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLMoreSearchVC.h"
#import "TXXLMoreCollectionViewCell.h"
#import "TXXLMoreHeaderReusableView.h"
#import "TXXLSuitAvoidNatigationView.h"
#import "TXXLMoreAlertView.h"
#import "TXXLSearchDetailVC.h"
#import "TXXLSearchMoreVM.h"
@interface TXXLMoreSearchVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSInteger _currentIndex;
    NSIndexPath *_selectIndexPath;
}
@property (nonatomic, weak) UICollectionView *mainCollectionView;
@property (nonatomic, strong) TXXLSuitAvoidNatigationView *titleView;
@property (nonatomic, strong) TXXLSearchMoreVM *viewModel;
@property (nonatomic, strong) NSMutableDictionary *dataDictionary;
@end

@implementation TXXLMoreSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeNavigationTitleView];
    [self initializeMainView];
    [self bindSignal];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.navigationItem.titleView = nil;
    if (_selectIndexPath) {
        TXXLMoreCollectionViewCell *cell = (TXXLMoreCollectionViewCell *)[self.mainCollectionView cellForItemAtIndexPath:_selectIndexPath];
        if (cell) {
            [cell changeSelectState:NO];
        }
        _selectIndexPath = nil;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_titleView && _titleView.superview == nil) {
        self.navigationItem.titleView = _titleView;
    }
}
#pragma mark - 数据加载
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXXLSearchMoreVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        [self.mainCollectionView.mj_header endRefreshing];
        [self.dataDictionary setObject:model forKey:NSStringFormat(@"%zd",_currentIndex)];
        [self.mainCollectionView reloadData];
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.mainCollectionView.mj_header endRefreshing];
    }];
    _viewModel.isAvoid = _currentIndex;
    [_viewModel getSearchMoreList:NO];
}
- (void)pullDownRefresh {
    [_viewModel getSearchMoreList:YES];
}
#pragma mark - 私有事件
//导航栏切换
- (void)navigaitonClick:(NSInteger)index {
    _currentIndex = index;
    NSArray *sectionData = [self.dataDictionary objectForKey:NSStringFormat(@"%zd",_currentIndex)];
    if (!KJudgeIsArrayAndHasValue(sectionData)) {
        _viewModel.isAvoid = _currentIndex;
        [_viewModel getSearchMoreList:NO];
    }
    [self.mainCollectionView reloadData];
}
//显示提示
- (void)showAlertView {
    TXXLMoreAlertView *alertView = [[TXXLMoreAlertView alloc]init];
    [alertView show];
}
#pragma mark --UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section{
    NSArray *sectionData = [self.dataDictionary objectForKey:NSStringFormat(@"%zd",_currentIndex)];
    if (KJudgeIsArrayAndHasValue(sectionData)) {
        return sectionData.count;
    }
    return 8;
}

//定义展示的Section的个数
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    NSArray *sectionData = [self.dataDictionary objectForKey:NSStringFormat(@"%zd",_currentIndex)];
    if (KJudgeIsArrayAndHasValue(sectionData)) {
        return sectionData.count;
    }
    return 0 ;
}

//每个UICollectionView展示的内容
-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    TXXLMoreCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXXLMoreCollectionViewCell forIndexPath:indexPath];
    [cell setupContentWithTitle:@"嫁娶"];
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        TXXLMoreHeaderReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXXLMoreHeaderReusableView forIndexPath:indexPath];
        if (indexPath.section == 0) {
            headerView.alertBtn.hidden = NO;
            WS(ws)
            headerView.alertBlock = ^(BOOL isAlert) {
                [ws showAlertView];
            };
        }else {
            headerView.alertBtn.hidden = YES;
        }
        headerView.titleLbl.text = @"常用";
        return headerView;
    }
    return nil;
}
#pragma mark --UICollectionViewDelegate

//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
    TXXLMoreCollectionViewCell *cell = (TXXLMoreCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell changeSelectState:YES];
    _selectIndexPath = indexPath;
    TXXLSearchDetailVC *detailVC = [[TXXLSearchDetailVC alloc]init];
    detailVC.titleString = [cell returnTitleString];
    detailVC.isAvoid = (_currentIndex == 0?NO:YES);
    [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的边距(次序: 上，左，下，右边)
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake(0, WIDTH_RACE_6S(37), 18, WIDTH_RACE_6S(37));
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(85, 47);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return CGSizeMake(SCREEN_WIDTH, 73);
    }else {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
}
//设置单元格间的横向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return (SCREEN_WIDTH - WIDTH_RACE_6S(74) - 85 * 3) / 2;
}

//设置单元格间的竖向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

#pragma mark -界面初始化
- (void)initializeNavigationTitleView {
    _titleView = [[TXXLSuitAvoidNatigationView alloc]initWithFrame:CGRectMake(0, (self.navibarHeight - 26) / 2.0, 121, 26)];
    @weakify(self)
    _titleView.navigationBlock = ^(NSInteger index) {
        @strongify(self)
        [self navigaitonClick:index];
    };
    self.navigationItem.titleView = _titleView;
}
- (void)initializeMainView {
    _dataDictionary = [NSMutableDictionary dictionary];
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:[UIColor whiteColor]];

    [collectView registerNib:[UINib nibWithNibName:kTXXLMoreCollectionViewCell bundle:nil] forCellWithReuseIdentifier:kTXXLMoreCollectionViewCell];
    [collectView registerNib:[UINib nibWithNibName:kTXXLMoreHeaderReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXXLMoreHeaderReusableView];
    self.mainCollectionView = collectView;
    [self.view addSubview:collectView];
    WS(ws)
    [collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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
