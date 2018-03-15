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
#import "TXXLBottonAdView.h"
#import "TXSMCalculateNoticeView.h"
#import "TXSMCalculateHotTitleView.h"
@interface TXSMCalculateHomeHeaderView ()
{
    CGFloat _bannerHeight;
    CGFloat _middleHeight;
    CGFloat _bottonHeight;
}
@property (nonatomic, weak) UIView *bottonContentView;
@property (nonatomic, weak) LSKBarnerScrollView *bannerScrollerView;
@property (nonatomic, weak) TXXLCategoryView *categoryView;
@property (nonatomic, weak) TXSMCalculateNoticeView *noticeView;
@property (nonatomic, weak) TXSMCalculateHotTitleView *hotTitleView;
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
- (void)noticeClickWithType:(NSInteger)type {
    //0 最新 1热门
    [self eventClickWithKey:kCalculateNoticeId index:type];
}
- (void)bottonActionClick:(NSInteger)type index:(NSInteger)index {
    NSString *key = nil;
    if (type == 0) {
        key = kCalculateFeelingId;
    }else if (type == 1) {
        key = kCalculateFortuneId;
    }else {
        key = kCalculateUnbindNameId;
    }
    [self eventClickWithKey:key index:index];
}
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
#pragma mark - 数据填充
- (void)setupContent:(NSDictionary *)dict {
    if ([dict isKindOfClass:[NSDictionary class]]) {
        CGFloat contentHeight = _bannerHeight;
        NSArray *bannerArray = [dict objectForKey:kCalculateBannerId];
        [self.bannerScrollerView setupBannarContentWithUrlArray:bannerArray];
        NSArray *navigationArr = [dict objectForKey:kCalculateNavigationId];
        [self.categoryView setupCategoryBtnArray:navigationArr];
        CGFloat height = [self.categoryView returnHeight];
        self.categoryView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, height);
        contentHeight += height;
        NSArray *noticeArray = [dict objectForKey:kCalculateNoticeId];
        if (KJudgeIsArrayAndHasValue(noticeArray)) {
            contentHeight += 1;
            self.noticeView.hidden = NO;
            self.noticeView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, _middleHeight);
            NSString *newTitle = nil;
            NSString *hotTitle = nil;
            newTitle = [[noticeArray objectAtIndex:0]objectForKey:@"title"];
            if (noticeArray.count > 1) {
                hotTitle = [[noticeArray objectAtIndex:1]objectForKey:@"title"];
            }
            [self.noticeView setupContentWithNew:newTitle hot:hotTitle];
            contentHeight += _middleHeight;
        }
        contentHeight += 2.5;
        CGFloat bottonPoint = contentHeight;
        NSArray *feeling = [dict objectForKey:kCalculateFeelingId];
        TXXLBottonAdView *feelingView = [self viewWithTag:600];
        if (KJudgeIsArrayAndHasValue(feeling)) {
            self.bottonContentView.hidden = NO;
            if (feelingView == nil) {
                feelingView = [self customBottonViewWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH , _bottonHeight) flag:600];
            }
            [feelingView setupContentWithData:feeling];
            contentHeight += _bottonHeight;
        }else if(feelingView) {
            [feelingView removeFromSuperview];
        }
        NSArray *fortune = [dict objectForKey:kCalculateFortuneId];
        TXXLBottonAdView *fortuneView = [self viewWithTag:601];
        if (KJudgeIsArrayAndHasValue(fortune)) {
            self.bottonContentView.hidden = NO;
            if (fortuneView == nil) {
                fortuneView = [self customBottonViewWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH , _bottonHeight) flag:601];
            }
            [fortuneView setupContentWithData:fortune];
            contentHeight += _bottonHeight;
        }else if(fortuneView) {
            [fortuneView removeFromSuperview];
        }
        NSArray *name = [dict objectForKey:kCalculateUnbindNameId];
        TXXLBottonAdView *nameView = [self viewWithTag:602];
        if (KJudgeIsArrayAndHasValue(name)) {
            self.bottonContentView.hidden = NO;
            if (nameView == nil) {
                nameView = [self customBottonViewWithFrame:CGRectMake(0, contentHeight, SCREEN_WIDTH , _bottonHeight) flag:602];
            }
            [nameView setupContentWithData:name];
            contentHeight += _bottonHeight;
        }else if(nameView) {
            [nameView removeFromSuperview];
        }
        CGFloat middleHeight = contentHeight - bottonPoint;
        if (middleHeight > 0) {
            self.bottonContentView.frame = CGRectMake(0, bottonPoint + 5, SCREEN_WIDTH , middleHeight - 5);
        }
        NSArray *adArray = [dict objectForKey:kCalculateAdId];
        if (KJudgeIsArrayAndHasValue(adArray)) {
            self.hotTitleView.frame = CGRectMake(0, contentHeight, SCREEN_WIDTH, 70);
            contentHeight += 70;
        }
        contentHeight += 1;
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
- (TXXLBottonAdView *)customBottonViewWithFrame:(CGRect)frame flag:(NSInteger)flag {
    TXXLBottonAdView *bottonView = [[TXXLBottonAdView alloc]init];
    bottonView.frame = frame;
    bottonView.flag = flag;
    WS(ws)
    bottonView.clickBlock = ^(NSInteger flag, NSInteger type) {
        [ws bottonActionClick:flag index:type];
    };
    [self addSubview:bottonView];
    return bottonView;
}
- (void)_layoutMainView {
    _middleHeight = 172 / 2.0;
    _bottonHeight = WIDTH_RACE_6S(210) + 47;
    _bannerHeight = WIDTH_RACE_6S(180);
}
- (UIView *)bottonContentView {
    if (!_bottonContentView) {
        UIView *bottonView = [[UIView alloc]initWithFrame:CGRectZero];
        bottonView.backgroundColor = [UIColor whiteColor];
        _bottonContentView = bottonView;
        [self addSubview:bottonView];
    }
    return _bottonContentView;
}
- (TXSMCalculateNoticeView *)noticeView {
    if (!_noticeView) {
        WS(ws)
        TXSMCalculateNoticeView *noticeView = [[TXSMCalculateNoticeView alloc]init];
        noticeView.frame = CGRectMake(0, _bannerHeight, SCREEN_WIDTH, _middleHeight);
        noticeView.noticeBlock = ^(NSInteger type) {
            [ws noticeClickWithType:type];
        };
        _noticeView = noticeView;
        [self addSubview:noticeView];
        noticeView.hidden = YES;
    }
    return _noticeView;
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
        WS(ws)
        TXXLCategoryView *categoryView = [[TXXLCategoryView alloc]init];
        _categoryView = categoryView;
        categoryView.clickBlock = ^(NSInteger index) {
            [ws navigationClick:index];
        };
        [self addSubview:categoryView];
        CGFloat height = [categoryView returnHeight];
        categoryView.frame = CGRectMake(0, _bannerHeight, SCREEN_WIDTH, height);
    }
    return _categoryView;
}
- (TXSMCalculateHotTitleView *)hotTitleView {
    if (!_hotTitleView) {
        TXSMCalculateHotTitleView *hotView = [[TXSMCalculateHotTitleView alloc]initWithFrame:CGRectZero];
        _hotTitleView = hotView;
        [self addSubview:hotView];
    }
    return _hotTitleView;
}
@end
