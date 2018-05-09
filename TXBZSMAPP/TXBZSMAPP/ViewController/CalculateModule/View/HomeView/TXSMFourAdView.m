//
//  TXSMFourAdView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFourAdView.h"
#import "TXSMFourButton.h"
@implementation TXSMFourAdView
{
    NSInteger _hasViewCount;
    CGFloat _btnWidth;
    CGFloat _btnHeight;
    CGFloat _heightTop;
}
@synthesize clickBlock;
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        [self _layoutMainView:type];
    }
    return self;
}
- (void)_layoutMainView:(NSInteger)type {
    _hasViewCount = 0;
    _btnWidth = WIDTH_RACE_6S(175);
    _btnHeight = WIDTH_RACE_6S(95);
    _heightTop = 5;
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:[self returnTitle:type] font:15];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(7);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(33);
    }];
}
- (NSString *)returnTitle:(NSInteger)type {
    NSString *title = nil;
    switch (type) {
        case 0:
        {
            title = @"精选测算";
        }
            break;
        case 1:
        {
            title = @"综合测算";
        }
            break;
            
        default:
            break;
    }
    return title;
}
- (void)setupCategoryBtnArray:(NSArray *)array {
    NSInteger dataCount = KJudgeIsArrayAndHasValue(array)?array.count:0;
    NSInteger maxCount = MAX(_hasViewCount, array.count);
    NSInteger row = ceil(maxCount / 2.0);
    NSInteger lastMaxCount = maxCount % 2 == 0?2:maxCount % 2;
    for (int i = 0; i < maxCount; i++) {
        NSInteger max = i == row - 1? lastMaxCount:2;
        for (int j = 0; j < max; j ++) {
            NSInteger flag = i * 2 + j;
            TXSMFourButton *btn = [self viewWithTag:200 + flag];
            if (flag < dataCount) {
                if (!btn) {
                    btn = [self customButtnView:flag];
                    [self addSubview:btn];
                }
                btn.frame = CGRectMake(10 + (_btnWidth + _heightTop) * j , 40 + (_heightTop + _btnHeight) * i, _btnWidth, _btnHeight);
                NSDictionary *contentDict = [array objectAtIndex:flag];
                NSString *image = [contentDict objectForKey:@"image"];
                [btn setupImg:image];
            }else {
                if (btn) {
                    [btn removeFromSuperview];
                }
            }
        }
    }
    _hasViewCount = dataCount;
}
- (void)btnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(self.key,btn.tag - 200);
    }
}
- (TXSMFourButton *)customButtnView:(NSInteger)flag {
    TXSMFourButton *btn = btn = [[TXSMFourButton alloc]init];
    btn.tag = flag + 200;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}

- (CGFloat)returnHeight {
    NSInteger row = ceil(_hasViewCount / 2.0);
    return _btnHeight * row + (row - 1) * _heightTop + 40;
}

@end
