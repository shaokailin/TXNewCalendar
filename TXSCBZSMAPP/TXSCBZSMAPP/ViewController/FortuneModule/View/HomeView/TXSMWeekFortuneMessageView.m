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
- (void)setupContentWithImg:(NSString *)image name:(NSString *)name time:(NSString *)time {
    if (KJudgeIsNullData(image)) {
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        _iconImgView.image = nil;
    }
    _titleLbl.text = NSStringFormat(@"%@%@",name,[self returnTitleString]);
    _timeLbl.text = NSStringFormat(@"有效日期: %@",time);
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 4.0);
    WS(ws)
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:18];
    _titleLbl = titleLbl;
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(31);
        make.centerX.equalTo(ws);
    }];
    
    UIImageView *iconImg = [[UIImageView alloc]init];
    iconImg.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    KViewBoundsRadius(iconImg, 215 / 2.0);
    _iconImgView = iconImg;
    [self addSubview:iconImg];
    [iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom).with.offset(19);
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
    _loveBtn = [[TXSMFortuneNumberButton alloc]initWithType:0];
    [self addSubview:_loveBtn];
    [_loveBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    _careerBtn = [[TXSMFortuneNumberButton alloc]initWithType:1];
    [self addSubview:_careerBtn];
    [_careerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 2 + width);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    
    _healthBtn = [[TXSMFortuneNumberButton alloc]initWithType:2];
    [self addSubview:_healthBtn];
    [_healthBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws).with.offset(7.5 + between * 3 + width * 2);
        make.bottom.equalTo(ws).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(width, height));
    }];
    _moneyBtn = [[TXSMFortuneNumberButton alloc]initWithType:3];
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
            title = @"运势";
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
