//
//  TXXLCompassView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCompassView.h"

@implementation TXXLCompassView
{
    UIImageView *_compassImageView;
    UILabel *_moneyLbl;
    UILabel *_luckLbl;
    UILabel *_happyLbl;
    UILabel *_liveLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithMoney:(NSString *)money happy:(NSString *)happy
                         luck:(NSString *)luck live:(NSString *)live {
    _moneyLbl.text = money;
    _happyLbl.text = happy;
    _luckLbl.text = luck;
    _liveLbl.text = live;
}
- (void)compassTranform:(double)radius {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        _compassImageView.transform = CGAffineTransformMakeRotation(-radius);
    } completion:nil];
    
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _compassImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"almanace_compass")];
    [self addSubview:_compassImageView];
    WS(ws)
    [_compassImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *luckIconLbl = [TXXLViewManager customTitleLbl:@"福" font:11];
    KViewBoundsRadius(luckIconLbl, 19 / 2.0);
    KViewBorderLayer(luckIconLbl, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    luckIconLbl.textAlignment = 1;
    [self addSubview:luckIconLbl];
    [luckIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(10);
        make.bottom.equalTo(ws).with.offset(-4);
        make.size.mas_equalTo(CGSizeMake(19, 19));
    }];
    _luckLbl = [TXXLViewManager customTitleLbl:nil font:10];
    [self addSubview:_luckLbl];
    [_luckLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(luckIconLbl.mas_right).with.offset(15);
        make.centerY.equalTo(luckIconLbl);
    }];
    
    UILabel *moneyIconLbl = [TXXLViewManager customTitleLbl:@"财" font:11];
    KViewBoundsRadius(moneyIconLbl, 19 / 2.0);
    KViewBorderLayer(moneyIconLbl, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    moneyIconLbl.textAlignment = 1;
    [self addSubview:moneyIconLbl];
    [moneyIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.left.equalTo(luckIconLbl);
        make.bottom.equalTo(luckIconLbl.mas_top).with.offset(-5);
    }];
    _moneyLbl = [TXXLViewManager customTitleLbl:nil font:10];
    [self addSubview:_moneyLbl];
    [_moneyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyIconLbl.mas_right).with.offset(15);
        make.centerY.equalTo(moneyIconLbl);
    }];
    UILabel *happyLbl = [TXXLViewManager customTitleLbl:nil font:10];
    _happyLbl = happyLbl;
    [self addSubview:happyLbl];
    [happyLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).with.offset(-10);
        make.centerY.equalTo(moneyIconLbl);
    }];
    
    UILabel *happyIconLbl = [TXXLViewManager customTitleLbl:@"喜" font:11];
    KViewBoundsRadius(happyIconLbl, 19 / 2.0);
    KViewBorderLayer(happyIconLbl, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    happyIconLbl.textAlignment = 1;
    [self addSubview:happyIconLbl];
    [happyIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(happyLbl.mas_left).with.offset(-15);
        make.centerY.width.height.equalTo(moneyIconLbl);
    }];
    UILabel *liveLbl = [TXXLViewManager customTitleLbl:nil font:10];
    _liveLbl = liveLbl;
    [self addSubview:liveLbl];
    [liveLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.mas_right).with.offset(-10);
        make.centerY.equalTo(luckIconLbl);
    }];
    
    UILabel *liveIconLbl = [TXXLViewManager customTitleLbl:@"生" font:11];
    KViewBoundsRadius(liveIconLbl, 19 / 2.0);
    KViewBorderLayer(liveIconLbl, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    liveIconLbl.textAlignment = 1;
    [self addSubview:liveIconLbl];
    [liveIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(liveLbl.mas_left).with.offset(-15);
        make.centerY.width.height.equalTo(luckIconLbl);
    }];
    
}

@end
