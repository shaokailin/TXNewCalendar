//
//  TXXLMoreAlertView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLMoreAlertView.h"

@implementation TXXLMoreAlertView
{
    UIView *_contentView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = KColorRGBA(0, 0, 0, 0.5);
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    KViewRadius(contentView, 10.0);
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"为什么新历宜忌择日比其他日历准？" font:19];
    titleLbl.numberOfLines = 0;
    [contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(6);
        make.top.equalTo(contentView).with.offset(21);
        make.right.equalTo(contentView).with.offset(-12);
    }];
    
    UILabel *detail1Lbl = [TXXLViewManager customDetailLbl:@"市面上各日历宜忌择日流派众多且参差不齐，造成市场各宜忌各不相同，新历依据最传统算法，参考《钦定协纪辩方书》《玉匣记》《鳌头通书》等择日著作加入干支、神煞、建除等综合考虑而编写，并对部分学涩老旧用事通俗化以便今人使用。" font:14];
    detail1Lbl.numberOfLines = 0;
    [contentView addSubview:detail1Lbl];
    [detail1Lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLbl);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(11);
        
    }];
    
    UILabel *detail2Lbl = [TXXLViewManager customDetailLbl:@"现网络上很多黄历类软件的宜忌仅仅简单从别处抄袭而来，众多雷同而毫无出处，不可依赖，请认准天象新历品牌！" font:14];
    detail2Lbl.numberOfLines = 0;
    [contentView addSubview:detail2Lbl];
    [detail2Lbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(titleLbl);
        make.top.equalTo(detail1Lbl.mas_bottom).with.offset(18);
    }];
    
    UILabel *contactLbl = [TXXLViewManager customDetailLbl:nil font:14];
    NSString *contact = NSStringFormat(@"如有疑问\n欢迎加入我们的交流群\n%@讨论！",kCompanyContactQQ);
    NSMutableAttributedString *attributed = [[NSMutableAttributedString alloc]initWithString:contact];
    [attributed addAttribute:NSForegroundColorAttributeName value:KColorHexadecimal(kAPP_Main_Color, 1.0) range:NSMakeRange(contact.length - 3 - kCompanyContactQQ.length, kCompanyContactQQ.length)];
    contactLbl.attributedText = attributed;
    contactLbl.numberOfLines = 0;
    [contentView addSubview:contactLbl];
    [contactLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.bottom.equalTo(contentView.mas_bottom).with.offset(-18);
    }];
    [self addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(20);
        make.right.equalTo(ws).with.offset(-20);
        make.centerY.equalTo(ws);
        make.height.mas_equalTo(400);
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
