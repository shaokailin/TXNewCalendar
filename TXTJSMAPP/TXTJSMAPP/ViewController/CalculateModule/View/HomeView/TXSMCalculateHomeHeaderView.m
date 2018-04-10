//
//  TXSMCalculateHomeHeaderView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCalculateHomeHeaderView.h"
#import "LSKBarnerScrollView.h"
#import "TXXLCategoryView.h"
#import "TXSMFourAdView.h"
#import "TXSMFiveAdView.h"
@interface TXSMCalculateHomeHeaderView ()
{
    CGFloat _bannerHeight;
    CGFloat _middleHeight;
    CGFloat _bottonHeight;
}
@property (nonatomic, weak) UIView *bottonContentView;
@property (nonatomic, weak) LSKBarnerScrollView *bannerScrollerView;
@property (nonatomic, weak) TXXLCategoryView *categoryView;
@property (nonatomic, weak) TXSMFourAdView *fourView;
@property (nonatomic, weak) TXSMFiveAdView *fiveView;
@end
@implementation TXSMCalculateHomeHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = KColorHexadecimal(kMainBackground_Color, 1.0);
        [self _layoutMainView];
    }
    return self;
}
- (void)viewDidDisappearStop {
    if (_bannerScrollerView) {
        [self.bannerScrollerView viewDidDisappearStop];
    }
}
- (void)viewDidAppearStartRun {
    if (_bannerScrollerView) {
        [self.bannerScrollerView viewDidAppearStartRun];
    }
}
#pragma mark - 事件处理
- (void)bannerClick:(NSInteger)index {
    [self eventClickWithKey:kCalculateBannerId index:index];
}
- (void)navigationClick:(NSInteger)index {
    [self eventClickWithKey:kCalculateNavigationId index:index];
}
- (void)eventClickWithKey:(NSString *)key index:(NSInteger)index {
    if (self.eventBlock) {
        self.eventBlock(key, index);
    }
}
- (void)fourViewClick:(NSInteger)index {
    [self eventClickWithKey:kCalculateFeelingId index:index];
}
- (void)fiveViewClick:(NSInteger)index {
   [self eventClickWithKey:kCalculateFortuneId index:index];
}
#pragma mark - 数据填充
- (void)setupContent:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        CGFloat contentHeight = _bannerHeight;
        NSArray *bannerArray = [dict objectForKey:kCalculateBannerId];
        [self.bannerScrollerView setupBannarContentWithUrlArray:bannerArray];
        
        contentHeight += 5;
        NSArray *fourArr = [dict objectForKey:kCalculateFeelingId];
        if (KJudgeIsArrayAndHasValue(fourArr)) {
            [self.fourView setupCategoryBtnArray:fourArr];
            CGFloat height = [self.fourView returnHeight];
            self.fourView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
            contentHeight += height;
            contentHeight += 8;
        }else if(_fourView) {
            [_fourView removeFromSuperview];
            _fourView = nil;
        }
        
        NSArray *navigationArr = [dict objectForKey:kCalculateNavigationId];
        if (KJudgeIsArrayAndHasValue(navigationArr)) {
            [self.categoryView setupCategoryBtnArray:navigationArr];
            CGFloat height = [self.categoryView returnHeight];
            self.categoryView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
            contentHeight += height;
            contentHeight += 8;
        }else if(_categoryView) {
            [_categoryView removeFromSuperview];
            _categoryView = nil;
        }
        
        NSArray *fiveArr = [dict objectForKey:kCalculateFortuneId];
        if (KJudgeIsArrayAndHasValue(fiveArr)) {
            [self.fiveView setupCategoryBtnArray:fiveArr];
            CGFloat height = [self.fiveView returnHeight];
            self.fiveView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
            contentHeight += height;
            contentHeight += 8;
        }else if(_fiveView) {
            [_fiveView removeFromSuperview];
            _fiveView = nil;
        }
        CGFloat frameHeight = CGRectGetHeight(self.frame);
        if (contentHeight != frameHeight) {
            CGRect frame = self.frame;
            frame.size.height = contentHeight;
            self.frame = frame;
            if (self.frameBlock) {
                self.frameBlock(contentHeight);
            }
        }
    }
}
- (void)_layoutMainView {
    _bannerHeight = WIDTH_RACE_6S(200);
}
- (TXSMFiveAdView *)fiveView {
    if (!_fiveView) {
        TXSMFiveAdView *fiveView = [[TXSMFiveAdView alloc]init];
        WS(ws)
        fiveView.clickBlock = ^(NSInteger index) {
            [ws fiveViewClick:index];
        };
        _fiveView = fiveView;
        [self addSubview:fiveView];
    }
    return _fiveView;
}
- (LSKBarnerScrollView *)bannerScrollerView {
    if (!_bannerScrollerView) {
        WS(ws)
        LSKBarnerScrollView *bannerView = [[LSKBarnerScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, _bannerHeight) placeHolderImage:nil imageDidSelectedBlock:^(NSInteger selectedIndex) {
            [ws bannerClick:selectedIndex];
        }];
        _bannerScrollerView = bannerView;
        [self addSubview:bannerView];
    }
    return _bannerScrollerView;
}
- (TXXLCategoryView *)categoryView {
    if (!_categoryView) {
        TXXLCategoryView *categoryView = [[TXXLCategoryView alloc]init];
        _categoryView = categoryView;
        WS(ws)
        categoryView.clickBlock = ^(NSInteger index) {
            [ws navigationClick:index];
        };
        [self addSubview:categoryView];
        CGFloat height = [categoryView returnHeight];
        categoryView.frame = CGRectMake(0, _bannerHeight, SCREEN_WIDTH, height);
    }
    return _categoryView;
}
- (TXSMFourAdView *)fourView {
    if (!_fourView) {
        TXSMFourAdView *fourView = [[TXSMFourAdView alloc]init];
        WS(ws)
        fourView.clickBlock = ^(NSInteger index) {
            [ws fourViewClick:index];
        };
        _fourView = fourView;
        [self addSubview:fourView];
    }
    return _fourView;
}
@end
