//
//  TXXLAlimanacSearchView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacSearchView.h"

@implementation TXXLAlmanacSearchView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor whiteColor];
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"吉日查询" font:18];
    [self addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(16);
        make.top.equalTo(ws);
        make.height.mas_equalTo(27);
    }];
    UIButton *marryBtn = [self customBtn:@"almanace_marry" title:@"嫁娶" flag:300];
    [self addSubview:marryBtn];
    [marryBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-10);
    }];
    UIButton *openBtn = [self customBtn:@"almanace_open" title:@"开市" flag:301];
    [self addSubview:openBtn];
    [openBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(marryBtn.mas_right);
        make.top.bottom.width.equalTo(marryBtn);
    }];
    
    UIButton *homeBtn = [self customBtn:@"almanace_home" title:@"入宅" flag:302];
    [self addSubview:homeBtn];
    [homeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(openBtn.mas_right);
        make.top.bottom.width.equalTo(openBtn);
    }];
    UIButton *allBtn = [self customBtn:@"almanace_all" title:@"全部" flag:303];
    [self addSubview:allBtn];
    [allBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(homeBtn.mas_right);
        make.top.bottom.width.equalTo(homeBtn);
        make.right.equalTo(ws);
    }];
}

- (UIButton *)customBtn:(NSString *)imageString title:(NSString *)title flag:(NSInteger)flag {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *iconImageView = [[UIImageView alloc]initWithImage:ImageNameInit(imageString)];
    [btn addSubview:iconImageView];
    [iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(btn);
        make.centerX.equalTo(btn);
    }];
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:title font:12];
    [btn addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(btn.mas_bottom).with.offset(-4);
        make.centerX.equalTo(btn);
    }];
    btn.tag = flag;
    [btn addTarget:self action:@selector(searchEventClick:) forControlEvents:UIControlEventTouchUpInside];
    return btn;
}
- (void)searchEventClick:(UIButton *)btn {
    if (self.clickBlock) {
        self.clickBlock(btn.tag - 300);
    }
}
@end
