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
    UILabel *_iconLbl;
    CGFloat _radius;
}
@property (nonatomic, weak) UIScrollView *contentScrollView;
@property (nonatomic, strong) NSDictionary *position;
@property (nonatomic, weak) UIView *compassView;
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
        [self changeSelect];
    }
}
//内容修改
- (void)changeSelect {
    _detailLbl.text = [self returnIndexDetail];
    NSString *title = [self returnTypeTitle];
    _iconLbl.text = title;
    CGFloat angle = [self returnAngelForDirection:[self returnDirection]];
    _iconLbl.transform = CGAffineTransformMakeRotation(angle / 180.0 * M_PI);
    _iconLbl.center = [self returnIconPointCenter:angle];
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
    [self changeCompassAngle:roundf(theHeading)];
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
- (void)changeCompassAngle:(CGFloat)angle {
    self.directionTitleLbl.text = NSStringFormat(@"%@:%.0f°",[self retuenPositionDirection:angle],angle);
    _directionLbl.text = [self returnDirectionToIndex:angle];
}
//罗盘修改转动
- (void)compassTranform:(CGFloat)radius {
    [UIView animateWithDuration:0.25 delay:0.0 options:UIViewAnimationOptionBeginFromCurrentState | UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        self.compassView.transform = CGAffineTransformMakeRotation(-radius);
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
    UILabel *directionTitleLbl = [TXXLViewManager customTitleLbl:nil font:15];
    self.directionTitleLbl = directionTitleLbl;
    [contentView addSubview:directionTitleLbl];
    contentHeight += 20;
    [directionTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(15);
        make.top.equalTo(contentView).with.offset(20);
    }];
    _directionLbl = [TXXLViewManager customTitleLbl:nil font:15];
    [contentView addSubview:_directionLbl];
    [_directionLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(directionTitleLbl);
        make.top.equalTo(directionTitleLbl.mas_bottom).with.offset(10);
    }];
    contentHeight += 30;
    _radius = SCREEN_WIDTH - 50 + 15;
    UIView *compassView = [[UIView alloc]init];
    self.compassView = compassView;
    [contentView addSubview:compassView];
    [compassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(directionTitleLbl.mas_bottom).with.offset(30 + 7.5);
        make.centerX.equalTo(contentView);
        make.width.mas_equalTo(self->_radius);
        make.height.mas_equalTo(self->_radius);
    }];
    UIImageView *compassImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"img_round")];
    self.compassImageView = compassImage;
    [compassView addSubview:compassImage];
    [compassImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(compassView);
        make.width.mas_equalTo(SCREEN_WIDTH - 65);
        make.height.mas_equalTo(SCREEN_WIDTH - 65);
    }];
    UIImageView *circleImgView = [[UIImageView alloc]initWithImage:ImageNameInit(@"redcircle")];
    [compassView addSubview:circleImgView];
    [circleImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(compassView);
        make.width.mas_equalTo(SCREEN_WIDTH - 50);
        make.height.mas_equalTo(SCREEN_WIDTH - 50);
    }];
    _iconLbl = [LSKViewFactory initializeLableWithText:nil font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(0xc24643, 1.0)];
    KViewBoundsRadius(_iconLbl, 15 / 2.0);
    _iconLbl.frame = CGRectMake(0,0, 15, 15);
    _iconLbl.center = CGPointMake(_radius / 2.0 + 120.208153 ,_radius / 2.0 - 120.208153);
    [compassView addSubview:_iconLbl];
    
    UIImageView *tenImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"tenimage")];
    [contentView addSubview:tenImg];
    [tenImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(compassView);
        make.width.height.mas_equalTo(compassImage);
    }];
    

    contentHeight += (SCREEN_WIDTH - 50 + 15);
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
        make.top.equalTo(compassView.mas_bottom).with.offset(40);
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

- (NSString *)retuenPositionDirection:(CGFloat)angle {
    NSString *direction = nil;
    if (angle >= 23 && angle <= 67) {
        direction = @"东北";
    }else if (angle >= 68 && angle <= 112){
        direction = @"东";
    }else if (angle >= 113 && angle <= 157){
        direction = @"东南";
    }else if (angle >= 158 && angle <= 202){
        direction = @"南";
    }else if (angle >= 203 && angle <= 247){
        direction = @"西南";
    }else if (angle >= 248 && angle <= 292){
        direction = @"西";
    }else if (angle >= 293 && angle <= 337){
        direction = @"西北";
    }else {
        direction = @"北";
    }
    return direction;
}
- (NSString *)returnDirectionToIndex:(CGFloat)angle {
    NSString *direction = nil;
    if (angle >= 8 && angle <= 22) {
        direction = @"坐子向午";
    }else if (angle >= 23 && angle <= 37) {
        direction = @"坐丑向未";
    }else if (angle >= 38 && angle <= 51) {
        direction = @"坐艮向坤";
    }else if (angle >= 52 && angle <= 67) {
        direction = @"坐寅向申";
    }else if (angle >= 68 && angle <= 81) {
        direction = @"坐甲向庚";
    }else if (angle >= 82 && angle <= 96) {
        direction = @"坐卯向酉";
    }else if (angle >= 97 && angle <= 112) {
        direction = @"坐乙向辛";
    }else if (angle >= 113 && angle <= 126) {
        direction = @"坐辰向戌";
    }else if (angle >= 127 && angle <= 141) {
        direction = @"坐巽向乾";
    }else if (angle >= 142 && angle <= 157) {
        direction = @"坐巳向亥";
    }else if (angle >= 158 && angle <= 171) {
        direction = @"坐丙向壬";
    }else if (angle >= 172 && angle <= 186) {
        direction = @"坐午向子";
    }else if (angle >= 187 && angle <= 202) {
        direction = @"坐丁向癸";
    }else if (angle >= 203 && angle <= 216) {
        direction = @"坐未向丑";
    }else if (angle >= 217 && angle <= 231) {
        direction = @"坐坤向艮";
    }else if (angle >= 232 && angle <= 247) {
        direction = @"坐申向寅";
    }else if (angle >= 248 && angle <= 261) {
        direction = @"坐庚向甲";
    }else if (angle >= 262 && angle <= 276) {
        direction = @"坐酉向卯";
    }else if (angle >= 277 && angle <= 292) {
        direction = @"坐辛向乙";
    }else if (angle >= 293 && angle <= 307) {
        direction = @"坐戌向辰";
    }else if (angle >= 308 && angle <= 321) {
        direction = @"坐乾向巽";
    }else if (angle >= 322 && angle <= 337) {
        direction = @"坐亥向巳";
    }else if (angle >= 338 && angle <= 351) {
        direction = @"坐壬向丙";
    }else {
        direction = @"坐子向午";
    }
    return direction;
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
- (NSString *)returnTypeTitle {
    NSString *title = nil;
    NSInteger index = _currentSelect - 200;
    switch (index) {
        case 0:
            title = @"喜";
            break;
        case 1:
            title = @"福";
            break;
        case 2:
            title = @"财";
            break;
        case 3:
            title = @"阳";
            break;
        case 4:
            title = @"阴";
            break;
        default:
            break;
    }
    return title;
}
- (CGFloat)returnAngelForDirection:(NSString *)title {
    CGFloat angel = 0;
    if ([title isEqualToString:@"北"] || [title isEqualToString:@"正北"]) {
        angel = 0;
    }else if ([title isEqualToString:@"东北"]) {
        angel = 45;
    }else if ([title isEqualToString:@"东"] || [title isEqualToString:@"正东"]) {
        angel = 90;
    }else if ([title isEqualToString:@"东南"]) {
        angel = 135;
    }else if ([title isEqualToString:@"南"] || [title isEqualToString:@"正南"]) {
        angel = 180;
    }else if ([title isEqualToString:@"西南"]) {
        angel = 225;
    }else if ([title isEqualToString:@"西"] || [title isEqualToString:@"正西"]) {
        angel = 270;
    }else {
        angel = 315;
    }
    return angel;
}
- (CGPoint )returnIconPointCenter:(CGFloat)angel {
    if (angel == 0) {
        return CGPointMake(_radius / 2.0 , 7.5);
    }else if (angel == 90){
        return CGPointMake(_radius - 7.5 , _radius / 2.0);
    }else if (angel == 180) {
        return CGPointMake(_radius / 2.0 , _radius - 7.5);
    }else if (angel == 270) {
        return CGPointMake(7.5 ,_radius / 2.0);;
    }else {
        CGFloat radius = SCREEN_WIDTH - 50;
        CGFloat pointX = sqrt((pow(radius / 2.0, 2) / 2.0));
        if (angel == 45) {
            return CGPointMake(_radius / 2.0 + pointX ,_radius / 2.0 - pointX);
        }else if (angel == 135) {
            return CGPointMake(_radius / 2.0 + pointX  ,_radius / 2.0 + pointX);
        }else if (angel == 315) {
            return CGPointMake(_radius / 2.0 - pointX  ,_radius / 2.0 - pointX);
        }else {
            return CGPointMake(_radius / 2.0 - pointX ,_radius / 2.0 + pointX);
        }
    }
    
}
@end
