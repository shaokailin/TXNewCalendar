//
//  TXXLSuitAvoidNatigationView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidNatigationView.h"

@implementation TXXLSuitAvoidNatigationView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    KViewBorderLayer(self, [UIColor whiteColor], 1.0);
    CGFloat height = CGRectGetHeight(self.bounds);
    KViewRadius(self, height / 2.0);
    CGFloat width = CGRectGetWidth(self.bounds) / 2.0;
    UIButton *leftBtn = [self customBtn:@"宜" flag:200 height:height];
    leftBtn.frame = CGRectMake(0, 0, width, height);
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [self customBtn:@"忌" flag:201 height:height];
    rightBtn.frame = CGRectMake(width, 0, width, height);
    [self addSubview:rightBtn];
    
    [self navigationClick:leftBtn];
}
- (UIButton *)customBtn:(NSString *)title flag:(NSInteger)flag height:(CGFloat)height {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title target:self action:@selector(navigationClick:) textfont:15 textColor:[UIColor whiteColor]];
    btn.tag = flag;
    [btn setTitleColor:KColorHexadecimal(kAPP_Main_Color, 1.0) forState:UIControlStateSelected];
    KViewRadius(btn, height / 2.0);
    return btn;
}
- (void)navigationClick:(UIButton *)btn {
    if (!btn.selected) {
        if (self.navigationBlock) {
            self.navigationBlock(btn.tag - 200);
        }
        btn.selected = YES;
        btn.backgroundColor = [UIColor whiteColor];
        UIButton *otherBtn = [self viewWithTag:btn.tag - 200 == 0 ? 201:200];
        otherBtn.selected = NO;
        otherBtn.backgroundColor = [UIColor clearColor];
    }
}
@end
