//
//  TXSMShareView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMShareView.h"
#import "UIButton+Extend.h"
static CGFloat kContentViewHeight = 203;
@implementation TXSMShareView
{
    UIView *_contentView;
    BOOL isShow;
    CGFloat _tabbarHeight;
    UIView *_bgView;
}
- (instancetype)initWithTabbar:(CGFloat)height {
    if (self = [super init]) {
        _tabbarHeight = height;
        [self _layoutMainView];
    }
    return self;
}
+ (BOOL)isHasInstallWx {
    return YES;
}
+ (BOOL)isHasInstallQQ {
    return YES;
}
- (void)showInView {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    if (!isShow) {
        self.hidden = NO;
        [UIView animateWithDuration:0.25 animations:^{
            _bgView.alpha = 1;
            _contentView.frame = CGRectMake(0, SCREEN_HEIGHT - kContentViewHeight - _tabbarHeight , SCREEN_WIDTH, kContentViewHeight);
        }];
    }
}
- (void)sureSelectClick:(UIButton *)btn {
    if (self.shareBlock) {
        self.shareBlock(btn.tag - 300);
    }
    [self cancleSelectedClick];
}
- (void)cancleSelectedClick {
    [UIView animateWithDuration:0.25 animations:^{
        _bgView.alpha = 0;
        _contentView.frame = CGRectMake(0, CGRectGetHeight(self.frame), SCREEN_WIDTH, kContentViewHeight);
    }completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIView *bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = KColorRGBA(0, 0, 0, 0.5);
    UITapGestureRecognizer *cancleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(cancleSelectedClick)];
    [bgView addGestureRecognizer:cancleTap];
    bgView.alpha = 0;
    _bgView = bgView;
    [self addSubview:bgView];
    UIView *contentView = [[UIView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, kContentViewHeight)];
    contentView.backgroundColor = KColorHexadecimal(0xf6f6f6, 1.0);
    _contentView = contentView;
    [self addSubview:contentView];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"选择要分享到的平台" font:16 textColor:KColorHexadecimal(0x727272, 1.0) textAlignment:1 backgroundColor:nil];
    [contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(contentView);
        make.height.mas_equalTo(56);
    }];
    CGFloat topHeight = 56;
    CGFloat width = 60;
    CGFloat betweenWidth = (SCREEN_WIDTH - width * 4) / 5.0;
    CGFloat height = 80;
    NSInteger i = -1;
    if ([WXApi isWXAppInstalled]) {
        i++;
        UIButton *wxBtn = [self customBtnView:@"wx_icon" flag:300 title:@"微信"];
        wxBtn.frame = CGRectMake([self returnPoint:i between:betweenWidth], topHeight, width, height);
        [contentView addSubview:wxBtn];
        i++;
        UIButton *wxSpaceBtn = [self customBtnView:@"wxspace_icon" flag:301 title:@"朋友圈"];
        wxSpaceBtn.frame = CGRectMake([self returnPoint:i between:betweenWidth], topHeight, width, height);
        [contentView addSubview:wxSpaceBtn];
    }
    if (![TencentOAuth iphoneQQInstalled]) {
        i ++;
        UIButton *qqBtn = [self customBtnView:@"qq_icon" flag:302 title:@"QQ"];
        qqBtn.frame = CGRectMake([self returnPoint:i between:betweenWidth], topHeight, width, height);
        [contentView addSubview:qqBtn];
        i ++;
        UIButton *qqSpaceBtn = [self customBtnView:@"qqspace_icon" flag:303 title:@"空间"];
        qqSpaceBtn.frame = CGRectMake([self returnPoint:i between:betweenWidth], topHeight, width, height);
        [contentView addSubview:qqSpaceBtn];
    }
    UIButton *cancleBtn = [LSKViewFactory initializeButtonWithTitle:@"取消" target:self action:@selector(cancleSelectedClick) textfont:18 textColor:KColorHexadecimal(kText_Title_Color, 1.0)];
    cancleBtn.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:cancleBtn];
    [cancleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(contentView);
        make.height.mas_equalTo(49);
    }];
}
- (CGFloat)returnPoint:(NSInteger)index between:(CGFloat)between {
    return between * (index + 1) + 60 * index;
}
- (UIButton *)customBtnView:(NSString *)imageName flag:(NSInteger)flag title:(NSString *)title {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:imageName selectedImage:nil target:self action:@selector(sureSelectClick:) textfont:14 textColor:KColorHexadecimal(0x727272, 1.0) backgroundColor:nil backgroundImage:nil];
    btn.tag = flag;
    [btn setVerticalLayoutWithSpace:5];
    return btn;
}
@end
