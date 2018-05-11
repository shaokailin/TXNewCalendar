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
@interface TXBZSMBlessPlatformVC ()
{
    BOOL _isChangeNavi;
    UIImage *_naviImage;
    UIColor *_nornalColor;
}
@property (nonatomic, weak) UIScrollView *mainScrollView;
//@property (nonatomic, weak) TXBZSMPlatformNaviView *navigationView;
@end

@implementation TXBZSMBlessPlatformVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
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
        [self needChange];
        TXBZSMGodSelectVC *select = [[TXBZSMGodSelectVC alloc]init];
        [self.navigationController pushViewController: select animated:YES];
    }else {
        TXBZSMMyBlessVC *mybless = [[TXBZSMMyBlessVC alloc]init];
        [self.navigationController pushViewController: mybless animated:YES];
    }
}
- (void)selectGoods:(PlatformGoodsType)type image:(NSString *)image {
    NSInteger index = self.mainScrollView.contentOffset.x / SCREEN_WIDTH;
    if (index < self.mainScrollView.subviews.count) {
        TXBZSMGodPlatformView *view = [self.mainScrollView.subviews objectAtIndex:index];
        [view setupContent:image type:type];
    }
}
- (void)godPlatformSelect:(PlatformGoodsType)type {
    TXBZSMPlatformGoodVC *good = [[TXBZSMPlatformGoodVC alloc]init];
    good.goodsType = type;
    good.bgImageView = [self getImageView];
    @weakify(self)
    good.selectBlock = ^(PlatformGoodsType type, NSString *image) {
        @strongify(self)
        [self selectGoods:type image:(NSString *)image];
    };
    [self.navigationController pushViewController:good animated:YES];
}
- (UIImage *)getImageView {
    CGFloat naviHeight = self.navibarHeight + STATUSBAR_HEIGHT;
    UIImage *image = [LSKImageManager makeImageWithView:self.view scope:CGRectMake(0, self.navibarHeight + STATUSBAR_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT - naviHeight - self.tabbarBetweenHeight)];
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
    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
        contentHeight = 471.57333333333332;
    }
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.pagingEnabled = YES;
    TXBZSMGodPlatformView *godView = [[TXBZSMGodPlatformView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentHeight)];
    godView.block = ^(PlatformGoodsType selectType) {
        @strongify(self)
        [self godPlatformSelect:selectType];
    };
    [scrollView addSubview:godView];
    scrollView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    self.mainScrollView = scrollView;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        make.height.mas_equalTo(contentHeight);
    }];
    
    
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
