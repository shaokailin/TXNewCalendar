//
//  TXSMMessageMainVC.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageMainVC.h"
#import "HListView.h"
#import "TXSMMessageHomeNaviCell.h"
#import "TXSMMessageListView.h"
#import "TXSMContentBgView.h"
@interface TXSMMessageMainVC ()<UIScrollViewDelegate,HListViewDataSource,HListViewDelegate> {
    BOOL isClickAnimal;
    BOOL _isHasShowView;
}
@property (strong ,nonatomic) HListView *m_naviListView;
@property (strong ,nonatomic) NSMutableArray *m_naviTitleArray;
@property (strong ,nonatomic) UIScrollView *m_mainScrollView;
@property (assign ,nonatomic) NSInteger currentIndex;
@end

@implementation TXSMMessageMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
     [kUserMessageManager setupViewProperties:self url:nil name:@"资讯首页"];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!_isHasShowView) {
        [self changeProductShow:YES];
    }
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)initializeMainView {
    TXSMContentBgView *bgImageView = [[TXSMContentBgView alloc]initWithType:0];
    [self.view addSubview:bgImageView];
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    self.m_naviTitleArray = [[NSMutableArray alloc]initWithObjects:@"推荐",@"命理",@"风水",@"生肖",@"星座",@"运势", nil];
    _currentIndex = 0;
    [self customHeadButtonView];
    LSKLog(@"%f-%f-%f",SCREEN_HEIGHT,STATUSBAR_HEIGHT,self.tabbarHeight);
    CGFloat viewHeight = SCREEN_HEIGHT - STATUSBAR_HEIGHT - kHomeHeadButtonHeight - self.tabbarHeight ;
    self.m_mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kHomeHeadButtonHeight + STATUSBAR_HEIGHT, SCREEN_WIDTH,viewHeight )];
    self.m_mainScrollView.delegate = self;
    self.m_mainScrollView.bounces = NO;
    self.m_mainScrollView.pagingEnabled = YES;
    self.m_mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * self.m_naviTitleArray.count, viewHeight);
    self.m_mainScrollView.layer.masksToBounds = YES;
    self.m_mainScrollView.showsVerticalScrollIndicator = NO;
    self.m_mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.m_mainScrollView];
    for (int i = 0; i < self.m_naviTitleArray.count; i++) {
        TXSMMessageListView *view = [[TXSMMessageListView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, viewHeight) type:i];
        [self.m_mainScrollView addSubview:view];
    }
}
//设置头部导航
- (void)customHeadButtonView {
    self.m_naviListView = [[HListView alloc]initWithFrame:CGRectMake(0, STATUSBAR_HEIGHT, SCREEN_WIDTH, kHomeHeadButtonHeight)];
    self.m_naviListView.delegate = self;
    self.m_naviListView.dataSource = self;
    self.m_naviListView.hTableView.scrollEnabled = NO;
    [self.m_naviListView.hTableView registerClass:[TXSMMessageHomeNaviCell class] forCellReuseIdentifier:kTXSMMessageHomeNaviCell];
    [self.view addSubview:self.m_naviListView];
}
#pragma mark 控制产品界面的切换
- (void)changeProductShow:(BOOL)isTap {
    if (!isTap) {
        isClickAnimal = YES;
        [self.m_mainScrollView scrollRectToVisible:CGRectMake(SCREEN_WIDTH * _currentIndex, kHomeHeadButtonHeight, self.view.frame.size.width, self.view.frame.size.height - kHomeHeadButtonHeight) animated:YES];
        [self.m_naviListView reloadListData];
    }
    [kUserMessageManager analiticsEvent:[self.m_naviTitleArray objectAtIndex:_currentIndex] viewName:@"资讯"];
    TXSMMessageListView *listView = [self.m_mainScrollView.subviews objectAtIndex:_currentIndex];
    [listView selectViewChange];
}
#pragma mark scroller delegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    isClickAnimal = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = self.m_mainScrollView.contentOffset.x;
    if (!isClickAnimal) {
        CGFloat screenWidth = SCREEN_WIDTH;
        NSInteger indexPage = floor(x / screenWidth) ;
        if (indexPage < self.m_naviTitleArray.count) {
            NSInteger lastPage = 0;
            CGFloat rate = 0;
            CGFloat lastrate = 0;
            CGFloat pageWidth = indexPage * screenWidth;
            if (x < pageWidth) {
                rate = (pageWidth - x) / screenWidth;
                lastrate = 1 - rate;
                lastPage = indexPage - 1;
            }else if(x > pageWidth)
            {
                rate = (x - pageWidth) / screenWidth;
                lastrate = 1 - rate;
                lastPage = indexPage + 1;
            }else{
                rate = 1;
                lastrate = 1;
                lastPage = indexPage;
            }
            TXSMMessageHomeNaviCell *current = (TXSMMessageHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:indexPage];
            TXSMMessageHomeNaviCell *last = (TXSMMessageHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:lastPage];
            [current changeTitleAttribute:[self decimalwithX:lastrate]];
            [last changeTitleAttribute:[self decimalwithX:rate]];
        }
        if ((NSInteger)x % (NSInteger)screenWidth == 0) {
            NSInteger indexPage = x / screenWidth ;
            if (_currentIndex != indexPage) {
                _currentIndex = indexPage;
                [self changeProductShow:YES];
            }
        }
    }
}
- (CGFloat ) decimalwithX:(CGFloat)floatX {
    return (floorf(floatX * 100 + 0.5))/100;
}

#pragma mark hlist delegate
- (NSInteger) numberOfColumnsInListView:(HListView *)listView {
    return self.m_naviTitleArray.count;
}
- (CGFloat)widthListView:(HListView *)listView OfColumnForIndex:(NSInteger)index {
    CGFloat width = SCREEN_WIDTH / self.m_naviTitleArray.count;
    return width;
}
- (UITableViewCell*)listView:(UITableView*)tablView columnForIndex:(NSInteger)index {
    TXSMMessageHomeNaviCell *cell = [tablView dequeueReusableCellWithIdentifier:kTXSMMessageHomeNaviCell];
    BOOL isSelect = NO;
    if (_currentIndex == index) {
        isSelect = YES;
    }
    [cell setupContentWithTitle:[self.m_naviTitleArray objectAtIndex:index] isSeleted:isSelect];
    return cell;
}

- (void) listView:(HListView*)listView didSelectedListViewAtIndex:(NSInteger)index {
    if (index != _currentIndex) {
        _currentIndex = index;
        [self changeProductShow:NO];
    }
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
