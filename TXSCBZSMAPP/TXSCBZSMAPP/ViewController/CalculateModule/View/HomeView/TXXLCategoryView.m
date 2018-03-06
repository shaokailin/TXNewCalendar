//
//  TXXLCategoryView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCategoryView.h"
#import "UIImageView+WebCache.h"
@implementation TXXLCategoryView
{
    NSInteger _hasViewCount;
    CGFloat _btnWidth;
    CGFloat _btnHeight;
    CGFloat _heightTop;
    CGFloat _heightBotton;
}
- (instancetype)init {
    if (self = [super init]) {
        _hasViewCount = 0;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _hasViewCount = 0;
    _btnWidth = SCREEN_WIDTH / 4.0;
    _btnHeight = 158 / 2.0;
    _heightTop = 35 / 2.0;
    _heightBotton = 17;
}
- (void)setupCategoryBtnArray:(NSArray *)array {
    NSInteger dataCount = KJudgeIsArrayAndHasValue(array)?array.count:0;
    NSInteger maxCount = MAX(_hasViewCount, array.count);
    NSInteger row = ceil(maxCount / 4.0);
    NSInteger lastMaxCount = maxCount % 4 == 0?4:maxCount % 4;
    for (int i = 0; i < maxCount; i++) {
        NSInteger max = i == row - 1? lastMaxCount:4;
        for (int j = 0; j < max; j ++) {
            NSInteger flag = i * 4 + j;
            UIButton *btn = [self viewWithTag:300 + flag];
            if (flag < dataCount) {
                if (!btn) {
                    btn = [self customBtnWithFlag:flag];
                    [self addSubview:btn];
                }
                btn.frame = CGRectMake(_btnWidth * j, _heightTop + (_heightTop + _btnHeight) * i, _btnWidth, _btnHeight);
                UILabel *titleLbl = [btn viewWithTag:500 + flag];
                UIImageView *iconImage = [btn viewWithTag:400 + flag];
                NSDictionary *contentDict = [array objectAtIndex:flag];
                NSString *title = [contentDict objectForKey:@"title"];
                NSString *image = [contentDict objectForKey:@"image"];
                titleLbl.text = title;
                if (KJudgeIsNullData(image)) {
                    [iconImage sd_setImageWithURL:[NSURL URLWithString:image]];
                }
            }else {
                if (btn) {
                    [btn removeFromSuperview];
                }
            }
        }
    }
    _hasViewCount = dataCount;
}
- (UIButton *)customBtnWithFlag:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *iconImageView = [[UIImageView alloc]init];
    iconImageView.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
    iconImageView.tag = 400 + flag;
    KViewBoundsRadius(iconImageView, 30);
    [btn addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn);
        make.centerX.equalTo(btn);
        make.size.mas_equalTo(CGSizeMake(60,60));
    }];
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:12];
    titleLbl.textAlignment = 1;
    titleLbl.tag = 500 + flag;
    [btn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(btn).with.offset(5);
        make.right.equalTo(btn).with.offset(-5);
        make.bottom.equalTo(btn);
    }];
    btn.tag = 300 +flag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)btnClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn.tag - 300);
    }
}
- (CGFloat)returnHeight {
    NSInteger row = ceil(_hasViewCount / 4.0);
    if (_hasViewCount > 0) {
        return (_btnHeight + _heightTop) * row + _heightBotton;
    }else {
        return 0;
    }
}
@end
