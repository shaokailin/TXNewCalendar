//
//  TXSMWeekFortuneMessageView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneMessageView.h"
#import "TXSMFortuneNumberButton.h"
#import "UIImageView+WebCache.h"
#import "TXSMFortuneYearButton.h"
@implementation TXSMWeekFortuneMessageView
{
    NSInteger _type;
    UILabel *_titleLbl;
    UILabel *_timeLbl;
    UIImageView *_iconImgView;
    TXSMFortuneNumberButton *_loveBtn;
    TXSMFortuneNumberButton *_careerBtn;
    TXSMFortuneNumberButton *_healthBtn;
    TXSMFortuneNumberButton *_moneyBtn;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithName:(NSString *)name time:(NSString *)time {
//    _titleLbl.text = NSStringFormat(@"%@%@",name,[self returnTitleString]);
    _timeLbl.text = NSStringFormat(@"有效日期: %@",time);
}
- (void)setupImage:(NSString *)name {
    if (KJudgeIsNullData(name)) {
        _iconImgView.image = ImageNameInit(name);
    }else {
        _iconImgView.image = nil;
    }
}
- (void)setupContentWithScore:(NSDictionary *)dict {
    if (_type == 2) {
        [_loveBtn setupYearStar:[[dict objectForKey:@"love"]integerValue]];
        [_healthBtn setupYearStar:[[dict objectForKey:@"health"]integerValue]];
        [_careerBtn setupYearStar:[[dict objectForKey:@"work"]integerValue]];
        [_moneyBtn setupYearStar:[[dict objectForKey:@"fortune"]integerValue]];
    }else {
        _loveBtn.presentValueLbl.text = NSStringFormat(@"%d%%",[[dict objectForKey:@"love"]intValue] * 10);
        _healthBtn.presentValueLbl.text = NSStringFormat(@"%d%%",[[dict objectForKey:@"health"]intValue] * 10);
        _careerBtn.presentValueLbl.text = NSStringFormat(@"%d%%",[[dict objectForKey:@"work"]intValue] * 10);
        _moneyBtn.presentValueLbl.text = NSStringFormat(@"%d%%",[[dict objectForKey:@"fortune"]intValue] * 10);
    }
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 4.0);
    WS(ws)
//    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:18];
//    _titleLbl = titleLbl;
//    [self addSubview:titleLbl];
//    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(ws).with.offset(31);
//        make.centerX.equalTo(ws);
//    }];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    KViewBoundsRadius(iconImg, 215 / 2.0);
    _iconImgView = iconImg;
    [self addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(20);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(215, 215));
    }];
    
    _timeLbl = [TXXLViewManager customDetailLbl:nil font:12];
    [self addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(iconImg.mas_bottom).with.offset(12);
        make.centerX.equalTo(ws);
    }];
    
    CGFloat width = WIDTH_RACE_6S(82);
    CGFloat height = WIDTH_RACE_6S(55);
    CGFloat between = (SCREEN_WIDTH - width * 4 - 15 - 10) / 5.0;
    if (_type == 2) {
        _loveBtn = [[TXSMFortuneYearButton alloc]initWithType:0];
    }else {
        _loveBtn = [[TXSMFortuneNumberButton alloc]initWithType:0];
    }
    
    if (_type == 2) {
        _careerBtn = [[TXSMFortuneYearButton alloc]initWithType:1];
    }else {
        _careerBtn = [[TXSMFortuneNumberButton alloc]initWithType:1];
    }
    
    if (_type == 2) {
        _healthBtn = [[TXSMFortuneYearButton alloc]initWithType:2];
    }else {
        _healthBtn = [[TXSMFortuneNumberButton alloc]initWithType:2];
    }
    
    if (_type == 2) {
        _moneyBtn = [[TXSMFortuneYearButton alloc]initWithType:3];
    }else {
        _moneyBtn = [[TXSMFortuneNumberButton alloc]initWithType:3];
    }
    [self addSubview:_loveBtn];
    [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [self addSubview:_careerBtn];
    [_careerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 2 + width);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [self addSubview:_healthBtn];
    [_healthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 3 + width * 2);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    [self addSubview:_moneyBtn];
    [_moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 4 + width * 3);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
}
- (NSString *)returnTitleString {
    NSString *title = nil;
    switch (_type) {
        case 0:
            title = @"本周运势";
            break;
        case 1:
            title = @"本月运势";
            break;
        case 2:
            title = @"今年运势";
            break;
        default:
            break;
    }
    return title;
}
@end
