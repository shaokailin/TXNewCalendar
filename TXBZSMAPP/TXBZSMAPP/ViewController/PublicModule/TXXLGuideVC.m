//
//  TXXLGuideVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLGuideVC.h"
#import "AppDelegate.h"
static const int kGuide_count = 4;
@interface TXXLGuideVC ()<UIScrollViewDelegate>
@property (nonatomic, weak) UIScrollView *mainScrollView;
@property (nonatomic, weak) UIPageControl *pageControl;
@end

@implementation TXXLGuideVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)initializeMainView {
    UIScrollView *scrollView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    CGFloat width = SCREEN_WIDTH;
    CGFloat height = SCREEN_HEIGHT;
    scrollView.frame = self.view.bounds;
    scrollView.contentSize = CGSizeMake(width * kGuide_count, height);
    scrollView.bounces = NO;
    scrollView.pagingEnabled = YES;
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    self.mainScrollView = scrollView;
    [self.view addSubview:scrollView];
    NSInteger iphoneType = [LSKPublicMethodUtil getiPhoneType];
    NSString *iconString = @"";
    NSInteger type = 0;
    if (iphoneType == 0) {
        type = 1;
        iconString = @"640_";
    }else if (iphoneType == 4) {
        type = 2;
        iconString = @"1125_";
    }
    for (int i = 0; i < kGuide_count; i++) {
        UIImageView *imageView = [[UIImageView alloc]initWithImage:ImageFileInit(NSStringFormat(@"%@guide_%d",iconString,i), @"png")];
        imageView.contentMode = UIViewContentModeScaleAspectFill ;
        imageView.layer.masksToBounds = YES;
        imageView.frame = CGRectMake(width * i, 0, width, height);
        [scrollView addSubview:imageView];
        if (i == kGuide_count - 1) {
            [self setupLastImageBtnView:imageView type:type];
        }
    }
    scrollView.delegate = self;
    UIPageControl *pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, height - 30 - 5, width, 30)];
    pageControl.numberOfPages = kGuide_count;
    pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    pageControl.userInteractionEnabled = NO;
    self.pageControl = pageControl;
    [self.view addSubview:pageControl];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    self.pageControl.currentPage = self.mainScrollView.contentOffset.x / CGRectGetWidth(self.view.bounds);
}

- (void)setupLastImageBtnView:(UIImageView *)imageView type:(NSInteger)type {
    imageView.userInteractionEnabled = YES;
    UIButton *startBtn = [LSKViewFactory initializeButtonWithTitle:@"立即体验" nornalImage:nil selectedImage:nil target:self action:@selector(startBtnClick) textfont:15 textColor:KColorHexadecimal(0x186ba4, 1.0) backgroundColor:nil backgroundImage:nil];
    KViewRadius(startBtn, 1);
    KViewBorderLayer(startBtn, KColorHexadecimal(0x186ba4, 1.0), kLineView_Height);
    CGFloat height = 0;
    if (type == 0) {
        height = CGRectGetHeight(imageView.frame) - WIDTH_RACE_6S(74);
    }else if (type == 1) {
        height = CGRectGetHeight(imageView.frame) - 105;
    }else {
        height = CGRectGetHeight(imageView.frame) - 120;
    }
    
    startBtn.frame = CGRectMake((SCREEN_WIDTH - WIDTH_RACE_6S(137)) / 2.0 , height,  WIDTH_RACE_6S(137),  WIDTH_RACE_6S(39));
    [imageView addSubview:startBtn];
}
- (void)startBtnClick {
    [kUserMessageManager setMessageManagerForBoolWithKey:kGuide_Is_Has_Show value:YES];
    [((AppDelegate *)[UIApplication sharedApplication].delegate) windowRootController];
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
