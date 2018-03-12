//
//  TXSMWeekFortuneAlertView.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneAlertView.h"

@implementation TXSMWeekFortuneAlertView
{
    UIView *_contentView;
}
- (instancetype)initWithString:(NSString *)content {
    if (self = [super init]) {
        [self _layoutMainView:content];
    }
    return self;
}
- (void)_layoutMainView:(NSString *)content {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = KColorRGBA(0, 0, 0, 0.5);
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    UIView *titleBgView = [[UIView alloc]init];
    titleBgView.backgroundColor = KColorHexadecimal(0xececec, 1.0);
    KViewRadius(titleBgView, 2.0);
    [contentView addSubview:titleBgView];
    
    CGFloat contentHeight = [content calculateTextHeight:14 width:SCREEN_WIDTH - 30 - 34];
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:content font:14];
    titleLbl.numberOfLines = 0;
    [titleBgView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleBgView).with.offset(17);
        make.top.equalTo(titleBgView).with.offset(17);
        make.right.equalTo(titleBgView).with.offset(-17);
    }];
    
    [titleBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(contentView);
        make.height.mas_equalTo(contentHeight + 34);
    }];
    contentHeight += 34;
    contentHeight += 20;
    
    UIButton *button = [LSKViewFactory initializeButtonNornalImage:@"close" selectedImage:nil target:self action:@selector(hidenView)];
    [contentView addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleBgView.mas_bottom).with.offset(20);
        make.centerX.equalTo(titleBgView);
        make.size.mas_equalTo(CGSizeMake(30, 30));
    }];
    [self addSubview:contentView];
    contentHeight += 30;
    contentHeight += 15;
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(17);
        make.right.equalTo(ws).with.offset(-17);
        make.centerY.equalTo(ws);
        make.height.mas_equalTo(contentHeight);
    }];
    UITapGestureRecognizer *hidenTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hidenView)];
    [self addGestureRecognizer:hidenTap];
}
- (void)hidenView {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (void)show {
    self.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}
@end
