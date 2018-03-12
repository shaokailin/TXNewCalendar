//
//  TXSMWeekFortuneButtonView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneButtonView.h"
#import "UIButton+Extend.h"
@implementation TXSMWeekFortuneButtonView
{
    NSInteger _type;
}
- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)eventClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn.tag - 100);
    }
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 4.0);
    
    UIButton *loveBtn = nil;
    UIButton *jobBtn = nil;
    UIButton *compassBtn = nil;
    UIButton *moneyBtn = nil;
    UIButton *healthBtn = nil;
    if (_type == 0 || _type == 1) {
        loveBtn = [self custonButtonViewWithImg:@"love_icon" name:@"爱情" flag:100 color:KColorHexadecimal(0x1e9dff, 1.0)];
        [self addSubview:loveBtn];
        if (_type == 1) {
            compassBtn = [self custonButtonViewWithImg:@"study" name:@"学习" flag:102 color:KColorHexadecimal(0x74b3d1, 1.0)];
            [self addSubview:compassBtn];
        }else {
            compassBtn = [self custonButtonViewWithImg:@"compass_icon" name:@"指南" flag:102 color:KColorHexadecimal(0x33b099, 1.0)];
            [self addSubview:compassBtn];
        }
    }else if (_type == 2){
        loveBtn = [self custonButtonViewWithImg:@"allMessage" name:@"整体" flag:100 color:KColorHexadecimal(0x475dcf, 1.0)];
        [self addSubview:loveBtn];
        compassBtn = [self custonButtonViewWithImg:@"love_icon" name:@"爱情" flag:102 color:KColorHexadecimal(0x1e9dff, 1.0)];;
        [self addSubview:compassBtn];
    }
    jobBtn = [self custonButtonViewWithImg:@"job_icon" name:@"工作" flag:101 color:KColorHexadecimal(0xe25a80, 1.0)];
    [self addSubview:jobBtn];
    moneyBtn = [self custonButtonViewWithImg:@"money_icon" name:@"财运" flag:103 color:KColorHexadecimal(0xcb9866, 1.0)];
    [self addSubview:moneyBtn];
    healthBtn = [self custonButtonViewWithImg:@"health_icon" name:@"健康" flag:104 color:KColorHexadecimal(0x3c90c8, 1.0)];
    [self addSubview:healthBtn];
    
    WS(ws)
    [loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(ws);
    }];
    
    [jobBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(loveBtn);
        make.left.equalTo(loveBtn.mas_right);
    }];
    
    [compassBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(jobBtn);
        make.left.equalTo(jobBtn.mas_right);
    }];
    
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(compassBtn);
        make.left.equalTo(compassBtn.mas_right);
    }];
    
    [healthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.width.equalTo(moneyBtn);
        make.left.equalTo(moneyBtn.mas_right);
        make.right.equalTo(ws);
    }];
    
}
- (UIButton *)custonButtonViewWithImg:(NSString *)img name:(NSString *)name flag:(NSInteger)flag color:(UIColor *)color {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:name nornalImage:img selectedImage:nil target:self action:@selector(eventClick:) textfont:12 textColor:color backgroundColor:nil backgroundImage:nil];
    btn.tag = flag;
    [btn setVerticalLayoutWithSpace:flag == 104? 18:12];
    return btn;
}
@end
