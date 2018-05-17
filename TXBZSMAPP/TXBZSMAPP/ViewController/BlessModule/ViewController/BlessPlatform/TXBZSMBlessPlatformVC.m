//
//  TXBZSMBlessPlatformVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessPlatformVC.h"
#import "TXBZSMPlatformNaviView.h"
#import "TXBZSMMyBlessVC.h"
#import "TXBZSMGodSelectVC.h"
#import "TXBZSMGodPlatformView.h"
#import "TXBZSMPlatformGoodVC.h"
#import "LSKImageManager.h"
@interface TXBZSMBlessPlatformVC ()<UIScrollViewDelegate>
{
    BOOL _isChangeNavi;
    UIImage *_naviImage;
    UIColor *_nornalColor;
    BOOL _isShowAlert;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
//@property (nonatomic, weak) TXBZSMPlatformNaviView *navigationView;
@end

@implementation TXBZSMBlessPlatformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self addNotificationWithSelector:@selector(changeContent) name:kBlessContentChange];
}
#pragma mark - 事件
- (void)needChange {
    _isChangeNavi = YES;
    if (!_naviImage) {
        _naviImage = ImageNameInit(@"navigationbg");
        _nornalColor = KColorUtilsString(kNavigationTitle_Color);
    }
}
- (void)navigationClick:(NSInteger)type {
    if (type == 1) {
        [self navigationBackClick];
    }else if (type == 2){
#warning share
    }else if (type == 3){
        [self jumpSelectGod];
    }else {
        TXBZSMMyBlessVC *mybless = [[TXBZSMMyBlessVC alloc]init];
        [self.navigationController pushViewController: mybless animated:YES];
    }
}
- (void)jumpSelectGod {
    [self needChange];
    TXBZSMGodSelectVC *select = [[TXBZSMGodSelectVC alloc]init];
    @weakify(self)
    select.selectBlock = ^(NSDictionary *dict) {
        @strongify(self)
        [self addSelectGod:dict];
    };
    [self.navigationController pushViewController: select animated:YES];
}
- (void)addSelectGod:(NSDictionary *)dict {
    _isShowAlert = YES;
    TXBZSMGodMessageModel *model = [[TXBZSMGodMessageModel alloc]init];
    model.godType = [dict objectForKey:@"type"];
    model.godImage = [dict objectForKey:@"image"];
    model.indexId = [dict objectForKey:@"indexId"];
    model.godName = [dict objectForKey:@"name"];
    model.blessType = [dict objectForKey:@"blessType"];
    [kUserMessageManager addBlessModel:model];
    [self changeContent];
}
- (void)changeContent {
    @weakify(self)
    CGFloat contentHeight = SCREEN_HEIGHT - WIDTH_RACE_6S(113) - self.tabbarBetweenHeight;
//    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
//        contentHeight = 471.57333333333332;
//    }
    NSArray *data = kUserMessageManager.blessArray;
    NSInteger count = data.count + 1;
    NSInteger viewCount = self.mainScrollView.subviews.count;
    NSInteger max = MAX(count, viewCount);
    for (int i = 0; i < max; i++) {
        TXBZSMGodPlatformView *godView = nil;
        if (i < viewCount) {
            godView = [self.mainScrollView.subviews objectAtIndex:i];
        }else if(i < count) {
            godView = [[TXBZSMGodPlatformView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, contentHeight)];
            godView.block = ^(PlatformGoodsType selectType) {
                @strongify(self)
                [self godPlatformSelect:selectType];
            };
            [self.mainScrollView addSubview:godView];
        }
        if (i == count - 1) {
            [godView setupContentWithModel:nil];
        }else if (i < count) {
            TXBZSMGodMessageModel *model = [data objectAtIndex:i];
            [godView setupContentWithModel:model];
        }else {
            [godView removeFromSuperview];
        }
    }
    
    [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
    self.mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * count, contentHeight);
    self.pageControl.numberOfPages = count;
    if (self.pageControl.currentPage >= count) {
        self.pageControl.currentPage = 0;
    }
}
- (void)selectGoods:(PlatformGoodsType)type image:(NSString *)image {
    NSInteger index = self.mainScrollView.contentOffset.x / SCREEN_WIDTH;
    if (index < self.mainScrollView.subviews.count) {
        TXBZSMGodPlatformView *view = [self.mainScrollView.subviews objectAtIndex:index];
        [view setupContent:image type:type];
        NSString *date = nil;
        if (view.isAll) {
            [SKHUD showMessageInView:self.view withMessage:@"供奉完成~！"];
            date = [[NSDate date]dateTransformToString:@"yyyy-MM-dd HH:mm"];
        }
        [kUserMessageManager changeBlessWithIndex:index image:image date:date type:type];
    }
}
- (void)godPlatformSelect:(PlatformGoodsType)type {
    if (type < 5) {
        TXBZSMPlatformGoodVC *good = [[TXBZSMPlatformGoodVC alloc]init];
        good.goodsType = type;
        good.bgImageView = [self getImageView];
        @weakify(self)
        good.selectBlock = ^(PlatformGoodsType type, NSString *image) {
            @strongify(self)
            [self selectGoods:type image:(NSString *)image];
        };
        [self.navigationController pushViewController:good animated:YES];
    }else {
        [self jumpSelectGod];
    }
}
- (UIImage *)getImageView {
    UIImage *image = [LSKImageManager makeImageWithView:self.view];
    return image;
}
- (void)initializeMainView {
    TXBZSMPlatformNaviView *navigationView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMPlatformNaviView" owner:self options:nil] lastObject];
    navigationView.topBetween.constant = STATUSBAR_HEIGHT;
    @weakify(self)
    navigationView.block = ^(NSInteger type) {
        @strongify(self)
        [self navigationClick:type];
    };
    [self.view addSubview:navigationView];
    [navigationView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(WIDTH_RACE_6S(168));
    }];
    CGFloat contentHeight = SCREEN_HEIGHT - WIDTH_RACE_6S(113) - self.tabbarBetweenHeight;
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    scrollView.delegate = self;
    scrollView.bounces = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    self.mainScrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        make.height.mas_equalTo(contentHeight);
    }];
    
    UIPageControl *pageControl = [[UIPageControl alloc]init];
    pageControl.currentPage = 0;
    pageControl.userInteractionEnabled = NO;
    pageControl.pageIndicatorTintColor = KColorHexadecimal(0x1a1009, 1.0);
    pageControl.currentPageIndicatorTintColor= KColorHexadecimal(0xfd8a32,    1.0);
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
    CGFloat bottomBetween = self.tabbarBetweenHeight + WIDTH_RACE_6S(20);
    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
        bottomBetween -= 20;
    }
    [pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-bottomBetween);
    }];
    [self changeContent];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.mainScrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChangeNavi) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : _nornalColor};;
        [self.navigationController.navigationBar setBackgroundImage:_naviImage forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChangeNavi = NO;
    if (_isShowAlert) {
        _isShowAlert = NO;
        [SKHUD showMessageInWindowWithMessage:@"请神成功~!"];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)dealloc {
    [self removeNotificationWithName:kBlessContentChange];
    self.mainScrollView.delegate = nil;
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
