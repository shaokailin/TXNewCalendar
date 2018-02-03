//
//  TXXLCalendarView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalendarView.h"
#import "FSCalendar.h"
#import <EventKit/EventKit.h>
@interface TXXLCalendarView ()<FSCalendarDelegate,FSCalendarDataSource,FSCalendarDelegateAppearance>
{
    FSCalendar *_calendarView;
    NSDate *_minimumDate;
    NSDate *_maximumDate;
    
}
@property (strong, nonatomic) NSCalendar *chineseCalendar;
@property (strong, nonatomic) NSArray<EKEvent *> *events;
@end
@implementation TXXLCalendarView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)selectDate:(NSDate *)date {
    [_calendarView selectDate:date];
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    self.chineseCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierChinese];
    _calendarView = [[FSCalendar alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 304)];
    _calendarView.delegate = self;
    _calendarView.dataSource = self;
    _calendarView.weekdayHeight = 29;
    _calendarView.placeholderType = FSCalendarPlaceholderTypeFillHeadTail;
    _calendarView.headerHeight = 0;
    _calendarView.locale = [NSLocale localeWithLocaleIdentifier:@"zh-CN"];
    
    _calendarView.appearance.weekdayFont = FontNornalInit(9);
    _calendarView.appearance.titleFont = FontNornalInit(20);
    _calendarView.appearance.subtitleFont = FontNornalInit(9);
    _calendarView.appearance.borderRadius = 0.1;
    _calendarView.appearance.titleOffset = CGPointMake(0, 2);
    _calendarView.appearance.subtitleOffset = CGPointMake(0, 8);
    _calendarView.appearance.borderSelectionColor = KColorHexadecimal(kAPP_Main_Color, 1.0);
    _calendarView.appearance.selectionColor = [UIColor clearColor];
    _calendarView.appearance.titleSelectionColor = KColorHexadecimal(kAPP_Main_Color, 1.0);
    _calendarView.appearance.subtitleSelectionColor = KColorHexadecimal(kAPP_Main_Color, 1.0);
    _calendarView.appearance.weekdayTextColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _calendarView.appearance.titleDefaultColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _calendarView.appearance.subtitleDefaultColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _calendarView.appearance.titlePlaceholderColor = KColorHexadecimal(0xb7b7b7, 1.0);
    _calendarView.appearance.subtitlePlaceholderColor = KColorHexadecimal(0xb7b7b7, 1.0);
    _calendarView.appearance.titleTodayColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _calendarView.appearance.subtitleTodayColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _calendarView.appearance.todayColor = [UIColor clearColor];
    _calendarView.appearance.caseOptions = FSCalendarCaseOptionsWeekdayUsesDefaultCase;
    _calendarView.appearance.headerMinimumDissolvedAlpha = 0.0;
    [self addSubview:_calendarView];
    
//    [self getCalendar];
}
- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition {
    if (monthPosition == FSCalendarMonthPositionNext || monthPosition == FSCalendarMonthPositionPrevious) {
        [calendar setCurrentPage:date animated:YES];
    }
    if (self.dateBlock) {
        self.dateBlock(date);
    }
}
- (void)calendarCurrentPageDidChange:(FSCalendar *)calendar {
//    [self getCalendar];
}
- (NSString *)calendar:(FSCalendar *)calendar subtitleForDate:(NSDate *)date {
    EKEvent *event = [self eventsForDate:date].firstObject;
    if (event) {
        return event.title; // 春分、秋分、儿童节、植树节、国庆节、圣诞节...
    }
    return [date calendarChineseString];
}
//- (NSInteger)calendar:(FSCalendar *)calendar numberOfEventsForDate:(NSDate *)date {
//}
- (void)calendar:(FSCalendar *)calendar boundingRectWillChange:(CGRect)bounds animated:(BOOL)animated {
    CGFloat height = CGRectGetHeight(_calendarView.frame);
    if (height != CGRectGetHeight(bounds)) {
        if (self.frameBlock) {
            self.frameBlock(height, CGRectGetHeight(bounds));
        }
        _calendarView.frame = bounds;
    }
}
- (void)getCalendar {
    @weakify(self)
    EKEventStore *store = [[EKEventStore alloc] init];
    [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
        @strongify(self)
        if(granted) {
            NSDate *startDate = self->_minimumDate; // 开始日期
            NSDate *endDate = self->_maximumDate; // 截止日期
            NSPredicate *fetchCalendarEvents = [store predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
            NSArray<EKEvent *> *eventList = [store eventsMatchingPredicate:fetchCalendarEvents];
            NSArray<EKEvent *> *events = [eventList filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable event, NSDictionary<NSString *,id> * _Nullable bindings) {
                return event.calendar.subscribed;
            }]];
            self.events = events;
        }
    }];
}
// 某个日期的所有事件
- (NSArray<EKEvent *> *)eventsForDate:(NSDate *)date
{
    NSArray<EKEvent *> *filteredEvents = [self.events filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(EKEvent * _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject.occurrenceDate isEqualToDate:date];
    }]];
    return filteredEvents;
}
@end
