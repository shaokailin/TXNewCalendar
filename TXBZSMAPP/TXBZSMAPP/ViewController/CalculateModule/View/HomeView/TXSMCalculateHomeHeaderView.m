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
}
@property (nonatomic, weak) UIView *lineView;
@property (nonatomic, weak) LSKBarnerScrollView *bannerScrollerView;
@property (nonatomic, weak) TXXLCategoryView *categoryView;
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
- (void)fourViewClick:(NSInteger)index key:(NSString *)key {
    [self eventClickWithKey:key index:index];
}
- (void)fiveViewClick:(NSInteger)index {
   [self eventClickWithKey:kCalculateHotId index:index];
}
#pragma mark - 数据填充
- (void)setupContent:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        CGFloat contentHeight = _bannerHeight;
        NSArray *bannerArray = [dict objectForKey:kCalculateBannerId];
        [self.bannerScrollerView setupBannarContentWithUrlArray:bannerArray];
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
        self.lineView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, 5);
        contentHeight += 5;
        
        NSArray *fiveArr = [dict objectForKey:kCalculateHotId];
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
        TXSMFourAdView *choiceView = [self viewWithTag:600];
        NSArray *fourArr = [dict objectForKey:kCalculateChoiceId];
        if (KJudgeIsArrayAndHasValue(fourArr)) {
            if (!choiceView) {
                choiceView = [self customFourViewWithKey:kCalculateChoiceId flag:0];
            }
            [choiceView setupCategoryBtnArray:fourArr];
            CGFloat height = [choiceView returnHeight];
            choiceView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
            contentHeight += height;
        }else if(choiceView) {
            [choiceView removeFromSuperview];
        }
        
        TXSMFourAdView *synthesizeView = [self viewWithTag:601];
        NSArray *synthesizeArr = [dict objectForKey:kCalculateSynthesizeId];
        if (KJudgeIsArrayAndHasValue(synthesizeArr)) {
            if (!synthesizeView) {
                synthesizeView = [self customFourViewWithKey:kCalculateSynthesizeId flag:1];
            }
            [synthesizeView setupCategoryBtnArray:synthesizeArr];
            CGFloat height = [choiceView returnHeight];
            synthesizeView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
            contentHeight += height;
        }else if(synthesizeView) {
            [synthesizeView removeFromSuperview];
        }
        contentHeight += 10;
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
    _bannerHeight = WIDTH_RACE_6S(202);
    self.backgroundColor = [UIColor whiteColor];
}
- (TXSMFiveAdView *)fiveView {
    if (!_fiveView) {
        TXSMFiveAdView *fiveView = [[TXSMFiveAdView alloc]init];
        _fiveView = fiveView;
        WS(ws)
        _fiveView.clickBlock = ^(NSString *key, NSInteger index) {
            [ws fiveViewClick:index];
        };
        [self addSubview:fiveView];
    }
    return _fiveView;
}
- (UIView *)lineView {
    if (!_lineView) {
        UIView *lineView = [LSKViewFactory initializeLineView];
        _lineView = lineView;
        [self addSubview:lineView];
    }
    return _lineView;
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
    }
    return _categoryView;
}
- (TXSMFourAdView *)customFourViewWithKey:(NSString *)key flag:(NSInteger)flag {
    TXSMFourAdView *fourView = [[TXSMFourAdView alloc]initWithType:flag];
    fourView.tag = flag + 600;
    fourView.key = key;
    WS(ws)
    fourView.clickBlock = ^(NSString *key, NSInteger index) {
        [ws fourViewClick:index key:key];
    };
    [self addSubview:fourView];
    return fourView;
}
@end
