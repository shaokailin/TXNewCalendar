//
//  TXXLMiddelAdView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLMiddelAdView.h"
#import "SCAdView.h"
@interface TXXLMiddelAdView()<SCAdViewDelegate>
{
    UILabel *_titleLbl;
    UILabel *_englishLbl;
    SCAdView *_adView;
}
@end
@implementation TXXLMiddelAdView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _latoutMainView];
    }
    return self;
}
- (void)setupContentWithTitle:(NSString *)title english:(NSString *)english dataArray:(NSArray *)data {
    _titleLbl.text = title;
    _englishLbl.text = english;
    [_adView reloadWithDataArray:data];
}
#pragma mark -delegate

-(void)sc_didClickAd:(id)adModel{
    
}
-(void)sc_scrollToIndex:(NSInteger)index{
    NSLog(@"sc_scrollToIndex-->%ld",index);
}
- (void)_latoutMainView {
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:15];
    _titleLbl.textAlignment = 1;
    _titleLbl.frame = CGRectMake(10, 0, CGRectGetWidth(self.frame) - 20, 16);
    [self addSubview:_titleLbl];
    
    _englishLbl = [TXXLViewManager customDetailLbl:nil font:12];
    _englishLbl.textAlignment = 1;
    _englishLbl.frame = CGRectMake(10, 23, CGRectGetWidth(self.frame) - 20, 13);
    [self addSubview:_englishLbl];
    SCAdView *adView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = @[];
        builder.viewFrame = (CGRect){WIDTH_RACE_6S(25),46,SCREEN_WIDTH - WIDTH_RACE_6S(50),WIDTH_RACE_6S(220)};
        builder.adItemSize = (CGSize){WIDTH_RACE_6S(108),WIDTH_RACE_6S(142)};
        builder.minimumLineSpacing = 0;
        builder.secondaryItemMinAlpha = 1;
        builder.threeDimensionalScale = 1.4;
        builder.itemCellNibName = @"TXXLCalculateAdCell";
    }];
    adView.backgroundColor = [UIColor whiteColor];
    adView.delegate = self;
    _adView = adView;
    [self addSubview:adView];
}
@end
