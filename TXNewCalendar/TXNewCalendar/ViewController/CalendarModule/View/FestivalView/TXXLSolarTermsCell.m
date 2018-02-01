//
//  TXXLSolarTermsCell.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSolarTermsCell.h"

@implementation TXXLSolarTermsCell
{
    UIImageView *_iconImageView;
    UILabel *_titleLbl;
    UILabel *_timeLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContentWithIcon:(NSString *)icon title:(NSString *)title time:(NSString *)time {
    _iconImageView.image = ImageNameInit(icon);
    _titleLbl.text = title;
    _timeLbl.text = time;
}
- (void)_layoutMainView {
    UIView *conView = [[UIView alloc]init];
    conView.backgroundColor = [UIColor whiteColor];
    KViewBoundsRadius(conView, 4);
    [self.contentView addSubview:conView];
    WS(ws)
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    _iconImageView = [[UIImageView alloc]init];
    [conView addSubview:_iconImageView];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(conView);
    }];
    UIView *titleView = [[UIView alloc]init];
    titleView.backgroundColor = KColorHexadecimal(0xf4babc, 1.0);
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    [titleView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleView).with.offset(4);
        make.centerX.equalTo(titleView);
    }];
    
    _timeLbl = [TXXLViewManager customTitleLbl:nil font:12];
    [titleView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(titleView).with.offset(-3);
        make.centerX.equalTo(titleView);
    }];
    
    [conView addSubview:titleView];
    [titleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(conView);
        make.height.mas_equalTo(38);
    }];
}
@end
