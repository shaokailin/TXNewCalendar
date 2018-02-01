//
//  TXXLAlmanacMainView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacMainView.h"
#import "TXXLAlmanacDateView.h"
#import "TXXLAlmanacMessageView.h"
#import "TXXLAlmanacHoursView.h"
#import "NSTimer+Extend.h"
#import <CoreLocation/CoreLocation.h>
#import "TXXLAlmanacHomeModel.h"
@interface TXXLAlmanacMainView ()<CLLocationManagerDelegate>
{
    NSInteger _changeDateEventCount;
    BOOL _isStartHeading;
    NSInteger _currentIndexHour;
    NSTimer *_hourTimer;
    CLLocationManager *_locationManager;
    NSInteger _timerBetween;
}
@property (nonatomic, weak) TXXLAlmanacDateView *dateView;
@property (nonatomic, weak) TXXLAlmanacMessageView *messageView;
@property (nonatomic, weak) TXXLAlmanacHoursView *hoursView;
@end
@implementation TXXLAlmanacMainView

- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        [self _layoutMainView];
        [self setupDefaultValue];
        //监听时间变化
        [self registerTimeChange];
        [self addSwipeGestureRecognizer];
        [self addLocationManager];
    }
    return self;
}
#pragma mark - 手机方向监听
- (void)addLocationManager {
    if ([CLLocationManager headingAvailable]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
    }else {
        [SKHUD showMessageInView:self withMessage:@"手机不支持方向功能,罗盘无法定位到当前方向"];
    }
}
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    // 角度
    if (newHeading.headingAccuracy < 0) {
        return;
    }
    CLLocationDirection angle = newHeading.magneticHeading;
    // 角度-> 弧度
    double radius = angle * M_PI / 180.0 ;
    // 反向旋转图片(弧度)
    [self.messageView compassTranform:radius];
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
#pragma mark - 填充内容数据
- (void)setupMessageContent:(TXXLAlmanacHomeModel *)model {
    [self.dateView setupChinessDateData:model.jinian week:model.week shengxiao:model.shengxiao nongli:model.nongli];
    [self.hoursView setupContentWithHours:model.h_detail];
    [self.messageView setupContentMessage:model];
}
#pragma mark -手势
- (void)addSwipeGestureRecognizer {
    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    left.direction=UISwipeGestureRecognizerDirectionLeft;
    [self addGestureRecognizer:left];
    
    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipes:)];
    right.direction=UISwipeGestureRecognizerDirectionRight;
    [self addGestureRecognizer:right];
}
-(void)handleSwipes:(UISwipeGestureRecognizer *)recognizer {
    if(recognizer.direction==UISwipeGestureRecognizerDirectionLeft){
        [self changeDate:DateChangeType_Next];
    }
    if (recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        [self changeDate:DateChangeType_Prev];
    }
}
#pragma mark - 监听系统时间变化
- (void)registerTimeChange {
    //系统时间改变或者新的一天到了
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(significantTimeChange) name:UIApplicationSignificantTimeChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(significantTimeChange) name:NSSystemClockDidChangeNotification object:nil];
    //地区区域改变的时候
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(currentLocaleDidChange) name:NSSystemTimeZoneDidChangeNotification object:nil];
}
- (void)significantTimeChange {
    LSKLog(@"1")
}
- (void)currentLocaleDidChange {
    
}
#pragma mark - 回调事件
//时间点击修改时间
- (void)changeDate:(DateChangeType)type {
    if (type == 0) {//前一个日期
        _changeDateEventCount --;
        _currentDate = [_currentDate dateByAddingTimeInterval:-(60 * 60 * 24)];
    }else {
        _changeDateEventCount ++;
        _currentDate = [_currentDate dateByAddingTimeInterval:60 * 60 * 24];
    }
    if (self.timeBlock) {
        self.timeBlock(type == 0? DirectionType_Right:DirectionType_Left,_currentDate);
    }
    [self changeDateEvent];
}
//日期修改的时候进行修改内容时间
- (void)changeDateEvent {
    [self.dateView setupDateContent:_currentDate];
    [self.messageView setupNilContent];
    if (_changeDateEventCount != 0) {
        [self.hoursView currentHourChange:-1];
    }else {
        [self.hoursView currentHourChange:_currentIndexHour];
    }
}
//信息的点击事件
- (void)messageViewClickEvent:(MessageEventType) type {
    if (self.clickBlock) {
        if (type == MessageEventType_Compass) {
            self.clickBlock(EventType_Compass);
        }else {
            self.clickBlock(EventType_Detail);
        }
    }
}
//时辰的点击事件
- (void)hourViewClickEvent {
    if (self.clickBlock) {
        self.clickBlock(EventType_Hours);
    }
}
#pragma mark - 初始化默认值
- (void)setupDefaultValue {
    _currentDate = [NSDate date];
    _changeDateEventCount = 0;
    _currentIndexHour = -1;
    [self setupTimeHourDafaultValue];
    [self changeDateEvent];
}
#pragma mark- 时辰设置
- (void)setupTimeHourDafaultValue {
    [self.hoursView setupDefaultData];
    [self setupCurrentHour];
}
//解析出时间差
- (void)setupCurrentHour {
    NSString *hoursString = [[NSDate date] dateTransformToString:@"HH-mm-ss"];
    NSArray *hourArray = [hoursString componentsSeparatedByString:@"-"];
    NSInteger hourIndex = [self returnHourIndex:[[hourArray objectAtIndex:0] integerValue]];
//    hourIndex = _currentIndexHour + 1;
    if (hourIndex != _currentIndexHour) {
        _currentIndexHour = hourIndex;
        if (_changeDateEventCount == 0) {
            [self.hoursView currentHourChange:_currentIndexHour];
        }
    }
    _timerBetween = (59 - [[hourArray objectAtIndex:1] integerValue]) * 60 + (60 - [[hourArray objectAtIndex:2]integerValue]);
    [self addHourTimer];
}
- (void)addHourTimer {
    if (!_hourTimer) {
        @weakify(self)
        _hourTimer = [NSTimer initTimerWithTimeInterval:_timerBetween block:^(NSTimer *timer) {
            @strongify(self)
            [self changeHourState];
        } repeats:NO runModel:NSRunLoopCommonModes];;
    }
}
- (void)changeHourState {
    _hourTimer = nil;
    [self setupCurrentHour];
}
#pragma mark -初始化主界面
- (void)_layoutMainView {
    WS(ws)
    TXXLAlmanacDateView *dateView = [[TXXLAlmanacDateView alloc]init];
    dateView.changeDateBlock = ^(DateChangeType type) {
        [ws changeDate:type];
    };
    self.dateView = dateView;
    [self addSubview:dateView];
    [dateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(ws);
        make.height.mas_equalTo(166);
    }];
    TXXLAlmanacMessageView *messageView = [[TXXLAlmanacMessageView alloc]init];
    self.messageView = messageView;
    messageView.clickBlock = ^(MessageEventType type) {
        [ws messageViewClickEvent:type];
    };
    [self addSubview:messageView];
    [messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.right.equalTo(dateView);
        make.top.equalTo(dateView.mas_bottom).with.offset(1);
        make.height.mas_equalTo(277);
    }];
    TXXLAlmanacHoursView *hoursView = [[TXXLAlmanacHoursView alloc]init];
    hoursView.clickBlock = ^(NSInteger type) {
        [ws hourViewClickEvent];
    };
    self.hoursView = hoursView;
    [self addSubview:hoursView];
    [hoursView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws);
        make.right.equalTo(dateView);
        make.top.equalTo(messageView.mas_bottom).with.offset(1);
        make.height.mas_equalTo(70);
    }];
}
- (void)dealloc {
    [_locationManager stopUpdatingHeading];
    _locationManager.delegate = nil;
}
- (NSInteger)returnHourIndex:(NSInteger)hour {
    switch (hour) {
        case 23:
        case 0:
            return 0;
            break;
        case 1:
        case 2:
            return 1;
            break;
        case 3:
        case 4:
            return 2;
            break;
        case 5:
        case 6:
            return 3;
            break;
        case 7:
        case 8:
            return 4;
            break;
        case 9:
        case 10:
            return 5;
            break;
        case 11:
        case 12:
            return 6;
            break;
        case 14:
        case 13:
            return 7;
            break;
        case 16:
        case 15:
            return 8;
            break;
        case 17:
        case 18:
            return 9;
            break;
        case 19:
        case 20:
            return 10;
            break;
        default:
            return 11;
            break;
    }
}
@end
