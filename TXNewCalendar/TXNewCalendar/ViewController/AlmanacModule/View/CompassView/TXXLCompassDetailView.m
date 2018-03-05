//
//  TXXLCompassDetailView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCompassDetailView.h"
@interface TXXLCompassDetailView ()<CLLocationManagerDelegate>
{
    UILabel *_directionLbl;
    UILabel *_detailLbl;
    NSInteger _currentSelect;
    CLLocationManager *_locationManager;
    BOOL _isStartHeading;
    
}
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSDictionary *position;
@property (nonatomic, weak) UIImageView *compassImageView;
@property (nonatomic, weak) UILabel *directionTitleLbl;
@end
@implementation TXXLCompassDetailView

- (instancetype)initWithPosition:(NSDictionary *)position {
    if (self = [super init]) {
        _position = position;
        [self _layoutMainView];
        [self addLocationManager];
    }
    return self;
}
//按钮事件
- (void)btnSelect:(UIButton *)btn {
    if (!btn.selected) {
        btn.selected = YES;
        btn.backgroundColor = KColorHexadecimal(kAPP_Main_Color, 1.0);
        if (_currentSelect != -1) {
            UIButton *otherBtn = [self viewWithTag:_currentSelect];
            otherBtn.selected = NO;
            otherBtn.backgroundColor = KColorHexadecimal(0xf4babc, 1.0);
        }
        _currentSelect  = btn.tag;
        self.directionTitleLbl.text = NSStringFormat(@"%@方位：",btn.titleLabel.text);
        [self changeSelect];
    }
}
//内容修改
- (void)changeSelect {
    _directionLbl.text = [self returnDirection];
    _detailLbl.text = [self returnIndexDetail];
}
#pragma mark 罗盘转动
#pragma mark - 手机方向监听
- (void)addLocationManager {
    if ([CLLocationManager headingAvailable]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = 100;
        _isStartHeading = YES;
        [_locationManager startUpdatingHeading];
    }else {
        [SKHUD showMessageInView:self withMessage:@"手机不支持方向功能,罗盘无法定位到当前方向"];
    }
    
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // 角度
    if (newHeading.headingAccuracy < 0) {
        return;
    }
    CLLocationDirection  theHeading = ((newHeading.trueHeading > 0) ?  newHeading.trueHeading : newHeading.magneticHeading);

//    CLLocationDirection angle = newHeading.magneticHeading;
    // 角度-> 弧度
    CGFloat radius = theHeading / 180.0 * M_PI;
    // 反向旋转图片(弧度)
    [self compassTranform:radius];
}
- (void)viewDidAppearStartHeading {
    if (_locationManager && !_isStartHeading) {
        [_locationManager startUpdatingHeading];
        _isStartHeading = YES;
    }
}
- (void)viewDidDisappearStopHeading {
    if (_locationManager && _isStartHeading) {
        [_locationManager stopUpdatingHeading];
        _isStartHeading = NO;
    }
}
//罗盘修改转动
- (void)compassTranform:(CGFloat)radius {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.compassImageView.transform = CGAffineTransformMakeRotation(-radius);
    } completion:nil];
}
#pragma mark -初始化界面
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIScrollView *contentView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    self.contentScrollView = contentView;
    [self addSubview:contentView];
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    CGFloat contentHeight = 35;
    _currentSelect = -1;
    UILabel *directionTitleLbl = [TXXLViewManager customTitleLbl:nil font:17];
    self.directionTitleLbl = directionTitleLbl;
    [contentView addSubview:directionTitleLbl];
    contentHeight += 20;
    [directionTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(10);
        make.top.equalTo(contentView).with.offset(35);
    }];
    _directionLbl = [TXXLViewManager customTitleLbl:nil font:17];
    [contentView addSubview:_directionLbl];
    [_directionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(directionTitleLbl.mas_right).with.offset(2);
        make.centerY.equalTo(directionTitleLbl);
    }];
    contentHeight += 30;
    UIImageView *compassImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"img_round")];
    self.compassImageView = compassImage;
    [contentView addSubview:compassImage];
    [compassImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(directionTitleLbl.mas_bottom).with.offset(30);
        make.left.equalTo(contentView).with.offset(25);
        make.width.mas_equalTo(SCREEN_WIDTH - 50);
        make.height.mas_equalTo(SCREEN_WIDTH - 50);
    }];
    contentHeight += (SCREEN_WIDTH - 50);
    UIButton *happyBtn = [self customBtn:@"喜神" flag:200];
    [contentView addSubview:happyBtn];
    UIButton *blissBtn = [self customBtn:@"福神" flag:201];
    [contentView addSubview:blissBtn];
    UIButton *moneyBtn = [self customBtn:@"财神" flag:202];
    [contentView addSubview:moneyBtn];
    UIButton *sunBtn = [self customBtn:@"阳贵" flag:203];
    [contentView addSubview:sunBtn];
    UIButton *lunarBtn = [self customBtn:@"阴贵" flag:204];
    [contentView addSubview:lunarBtn];
    CGFloat width = (SCREEN_WIDTH - 20 - 5 * 4) / 5.0;
    [happyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(10);
        make.top.equalTo(compassImage.mas_bottom).with.offset(40);
        make.height.mas_equalTo(width);
        make.width.mas_equalTo (width);
    }];
    [blissBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(happyBtn.mas_right).with.offset(5);
        make.top.width.bottom.equalTo(happyBtn);
    }];
    [moneyBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(blissBtn.mas_right).with.offset(5);
        make.top.width.bottom.equalTo(blissBtn);
    }];
    [sunBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(moneyBtn.mas_right).with.offset(5);
        make.top.width.bottom.equalTo(moneyBtn);
    }];
    [lunarBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(sunBtn.mas_right).with.offset(5);
        make.top.width.bottom.equalTo(sunBtn);
    }];
    contentHeight += (40 + width);

    _detailLbl = [TXXLViewManager customDetailLbl:nil font:12];
    _detailLbl.numberOfLines = 0;
    [contentView addSubview:_detailLbl];
    [_detailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 25);
        make.top.equalTo(happyBtn.mas_bottom).with.offset(30);
    }];
    [self btnSelect:happyBtn];
    contentHeight += (30 + 24 + 15);
    contentView.contentSize = CGSizeMake(SCREEN_WIDTH,contentHeight);
}

- (UIButton *)customBtn:(NSString *)title flag:(NSInteger)flag {
    UIButton *btn = [LSKViewFactory initializeButtonWithTitle:title nornalImage:nil selectedImage:nil target:self action:@selector(btnSelect:) textfont:17 textColor:KColorHexadecimal(kText_Title_Color, 1.0) backgroundColor:KColorHexadecimal(0xf4babc, 1.0) backgroundImage:nil];
    btn.tag = flag;
    CGFloat width = (SCREEN_WIDTH - 20 - 5 * 4) / 5.0;
    KViewRadius(btn, width / 2.0);
    KViewBorderLayer(btn, KColorHexadecimal(kText_Title_Color, 1.0), 1);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    return btn;
}
- (void)dealloc {
    if (_locationManager) {
        [_locationManager stopUpdatingHeading];
        _locationManager.delegate = nil;
    }
}
- (NSString *)returnIndexDetail {
    NSString *detail = nil;
    NSInteger index = _currentSelect - 200;
    switch (index) {
        case 0:
            detail = @"喜神所在方位有利于增强人的感情运势，对于谈恋爱、招桃花运、表白的人有较大的作用。";
            break;
        case 1:
            detail = @"福神能让幸福降临，福运绵长，吉星高照。";
            break;
        case 2:
            detail = @"财神主管神明，在财神方位打牌、打麻将。工商开门祭拜、求财的人可以增强财运。";
            break;
        case 3:
            detail = @"需要寻找帮助或者求人帮忙办事的时候，贵神方位容易找到相助的贵人，阳贵神在白天起作用。";
            break;
        case 4:
            detail = @"需要寻找帮助或者求人帮忙办事的时候，贵神方位容易找到相助的贵人，阳贵神在晚上起作用。";
            break;
        default:
            break;
    }
    return detail;
}
- (NSString *)returnDirection {
    NSString *direction = nil;
    NSInteger index = _currentSelect - 200;
    switch (index) {
        case 0:
            direction = [self.position objectForKey:@"xi_shen"];
            break;
        case 1:
            direction = [self.position objectForKey:@"fu_shen"];
            break;
        case 2:
            direction = [self.position objectForKey:@"cai_shen"];
            break;
        case 3:
            direction = [self.position objectForKey:@"yang_gui_ren"];
            break;
        case 4:
            direction = [self.position objectForKey:@"yin_gui_ren"];
            break;
        default:
            break;
    }
    return direction;
}
@end
