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
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _hasViewCount = 0;
    _btnWidth = (SCREEN_WIDTH - 2) / 2.0;
    _btnHeight = 96;
    _heightTop = 1;
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
                btn.frame = CGRectMake((_btnWidth + _heightTop) * j ,(_heightTop + _btnHeight) * i, _btnWidth, _btnHeight);
                NSDictionary *contentDict = [array objectAtIndex:flag];
                NSString *title = [contentDict objectForKey:@"title"];
                NSString *detail = [contentDict objectForKey:@"description"];
                NSString *image = [contentDict objectForKey:@"image"];
                [btn setupTitle:title detail:detail img:image];
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
        self.clickBlock(btn.tag - 200);
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
    return _btnHeight * row + (row - 1) * _heightTop;
}

@end
