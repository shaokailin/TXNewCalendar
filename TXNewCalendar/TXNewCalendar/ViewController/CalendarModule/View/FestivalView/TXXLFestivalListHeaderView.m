//
//  TXXLFestivalListHeaderView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLFestivalListHeaderView.h"

@implementation TXXLFestivalListHeaderView
{
    UIView *_lineView;
    NSInteger _currentIndex;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)changeShowType:(UIButton *)btn {
    if (!btn.selected) {
        UIButton *otherBtn = [self viewWithTag:200 + _currentIndex];
        otherBtn.selected = NO;
        _currentIndex = btn.tag - 200;
        btn.selected = YES;
        if (self.clickBlock) {
            self.clickBlock(_currentIndex);
        }
        [self changeLineFrame:btn];
    }
}
- (void)changeLineFrame:(UIButton *)btn {
    CGFloat width = [btn.titleLabel.text calculateTextWidth:12] + 10;
    CGFloat btnWidth = SCREEN_WIDTH / 3.0;
    [UIView animateWithDuration:0.25 animations:^{
        _lineView.frame = CGRectMake(btnWidth * _currentIndex + (btnWidth - width) /  2.0, 39, width, 1);
    }];
}
- (void)_layoutMainView {
    _currentIndex = 0;
    self.backgroundColor = [UIColor whiteColor];
    UIButton *leftBtn = [self customBtn:@"大众节气" flag:200];
    leftBtn.selected = YES;
    [self addSubview:leftBtn];
    
    UIButton *middleBtn = [self customBtn:@"二十四节气" flag:201];
    [self addSubview:middleBtn];
    
    UIButton *rightBtn = [self customBtn:@"节假日" flag:202];
    [self addSubview:rightBtn];
    
    UIView *lineView1 = [[UIView alloc]init];
    lineView1.backgroundColor = KColorHexadecimal(0xd3d3d3, 1.0);
    [self addSubview:lineView1];
    WS(ws)
    [lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(ws);
        make.height.mas_equalTo(1);
    }];
    
    [leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(ws);
        make.bottom.equalTo(lineView1.mas_top);
    }];
    [middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(leftBtn);
        make.left.equalTo(leftBtn.mas_right);
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(middleBtn);
        make.left.equalTo(middleBtn.mas_right);
        make.right.equalTo(ws);
    }];
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 39, 40, 1)];
    _lineView.backgroundColor = KColorHexadecimal(kAPP_Main_Color, 1.0);
    
    [self addSubview:_lineView];
    
    [self changeLineFrame:leftBtn];
}
- (UIButton *)customBtn:(NSString *)title flag:(NSInteger)flag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title target:self action:@selector(changeShowType:) textfont:12 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    btn.tag = flag;
    [btn setTitleColor:KColorHexadecimal(kAPP_Main_Color, 1.0) forState:UIControlStateSelected];
    return btn;
}
@end
