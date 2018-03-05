//
//  NSDate+Extend.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/9.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "NSDate+Extend.h"
static NSString *const kTIMEDEFAULTFORMATTER = @"yyyy-MM-dd";//时间转换默认的格式
static NSDateFormatter * _formatter = nil;
static NSCalendar * _calendar = nil;
@implementation NSDate (Extend)
+ (NSInteger)getDaysInYear:(NSInteger)year month:(NSInteger)month {
    if((month == 0)||(month == 1)||(month == 3)||(month == 5)||(month == 7)||(month == 8)||(month == 10)||(month == 12))
        return 31;
    if((month == 4)||(month == 6)||(month == 9)||(month == 11))
        return 30;
    if((year % 4 == 1)||(year % 4 == 2)||(year % 4 == 3))
    {
        return 28;
    }
    if(year % 400 == 0)
        return 29;
    if(year % 100 == 0)
        return 28;
    return 29;
}
//获取今天的日期
+ (NSDate *)getTodayDate {
    return [NSDate stringTransToDate:[[NSDate date] dateTransformToString:nil] withFormat:nil];
}
//获取明天的日期
+ (NSDate *)getTomorrowDate {
    return [NSDate dateWithTimeInterval:60 * 60 * 24 sinceDate:[NSDate getTodayDate]];
}
//判断是否是今天的
+(BOOL)isTimestampToToday:(NSTimeInterval)timeInterval
{
    if (timeInterval > 0) {
        NSDate *saveDate = [NSDate dateWithTimeIntervalSince1970:timeInterval];
        NSString *saveString = [saveDate dateTransformToString:kTIMEDEFAULTFORMATTER];
        NSString *currentString = [[NSDate date]dateTransformToString:kTIMEDEFAULTFORMATTER];
        if (![saveString isEqualToString:currentString]) {
            return NO;
        }else
        {
            return YES;
        }
    }else
    {
        return NO;
    }
}

//字符串转日期
+ (NSDate *)stringTransToDate:(NSString *)timeString withFormat:(NSString *)format
{
    if (KJudgeIsNullData(timeString)) {
        NSDate *currentDate = [NSDate date];
        NSDateFormatter * formatter = [currentDate setupFormatter];
        [formatter setDateFormat:[currentDate dateFormatString:format]];
        NSDate *date = [formatter dateFromString:timeString];
        return date;
    }
    return nil;
}
//日期转字符串
-(NSString *)dateTransformToString:(NSString *)format
{
    NSString *timeString = nil;
    if (self != nil) {
        [self setupFormatter];
        [_formatter setDateFormat:[self dateFormatString:format]];
        timeString = [_formatter stringFromDate:self];
    }
    return KNullTransformNumber(timeString);
}

- (NSString *)dateFormatString:(NSString *)format {
    return KJudgeIsNullData(format) ? format:kTIMEDEFAULTFORMATTER;
}

-(NSDateFormatter *)setupFormatter {
    if (_formatter == nil || [_formatter isKindOfClass:[NSNull class]]) {
        _formatter = [[NSDateFormatter alloc]init];
        [_formatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    }
    return _formatter;
}
#pragma mark -获取新历的数据
-(NSCalendar *)setupCalendar {
    if (_calendar == nil || [_calendar isKindOfClass:[NSNull class]]) {
        _calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        [_calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    }
    return _calendar;
}
- (NSInteger)getMonthDate {
    [self setupCalendar];
    if (self) {
        NSDateComponents *comps = [_calendar components:NSCalendarUnitMonth fromDate:self];
        return comps.month;
    }
    return 0;
}
- (NSInteger)getHourDate {
    [self setupCalendar];
    if (self) {
        NSDateComponents *comps = [_calendar components:NSCalendarUnitDay fromDate:self];
        return comps.day;
    }
    return 0;
}

- (NSString *)getWeekDate {
    [self setupCalendar];
    if (self) {
        NSDateComponents *comps = [_calendar components:NSCalendarUnitWeekday fromDate:self];
        return [[self class] weekForIndex:comps.weekday];
    }
    return nil;
}
- (NSInteger )getWeekIndex {
    [self setupCalendar];
    if (self) {
        NSDateComponents *comps = [_calendar components:NSCalendarUnitWeekday fromDate:self];
        return [[self class] weekIndexForIndex:comps.weekday];
    }
    return 0;
}
+ (NSInteger)weekIndexForIndex:(NSInteger)index {
    NSInteger week = 0;
    switch (index) {
        case 1:
            week = 7;
            break;
        case 2:
            week = 1;
            break;
        case 3:
            week = 2;
            break;
        case 4:
            week = 3;
            break;
        case 5:
            week = 4;
            break;
        case 6:
            week = 5;
            break;
        case 7:
            week = 6;
            break;
        default:
            break;
    }
    return week;
}
+ (NSString *)weekForIndex:(NSInteger)index {
    NSString *week = nil;
    switch (index) {
        case 1:
            week = @"星期天";
            break;
        case 2:
            week = @"星期一";
            break;
        case 3:
            week = @"星期二";
            break;
        case 4:
            week = @"星期三";
            break;
        case 5:
            week = @"星期四";
            break;
        case 6:
            week = @"星期五";
            break;
        case 7:
            week = @"星期六";
            break;
        default:
            break;
    }
    return week;
}
#pragma mark - 农历
//-(NSCalendar *)setupChinessCalendar {
//    if (_chinessCalendar == nil || [_chinessCalendar isKindOfClass:[NSNull class]]) {
//        _chinessCalendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
//        [_chinessCalendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
//        _chinessFormatter = [[NSDateFormatter alloc] init];
//        _chinessFormatter.calendar = _chinessCalendar;
//        _chinessFormatter.dateFormat = @"M";
//    }
//    return _chinessCalendar;
//}
//- (NSString *)getZodiac {
//    if (self) {
//        NSInteger year = [self getChinessYear];
//        if (year > 0) {
//            [self setupZodiacs];
//            NSInteger index = (year - 1) % _zodiacs.count;
//            return _zodiacs[index];
//        }
//    }
//    return nil;
//}
//- (NSString *)getChinessYearString {
//    if (self) {
//        NSInteger year = [self getChinessYear];
//        if (year > 0) {
//            [self setupHeavenlyStems];
//            [self setupEarthlyBranches];
//            NSInteger heavenlyStemIndex = (year - 1) % _heavenlyStems.count;
//            NSInteger earthlyBrancheIndex = (year - 1) % _earthlyBranches.count;
//            return NSStringFormat(@"%@%@",_heavenlyStems[heavenlyStemIndex],_earthlyBranches[earthlyBrancheIndex]);
//        }
//    }
//    return nil;
//}
//- (NSString *)getChineseMonthString {
//    if (self) {
//        NSInteger month = [self getChinessMonth];
//        if (month > 0) {
//            [self setupChineseMonth];
//            NSString *monthString = [_chinessFormatter stringFromDate:self];
//            if ([_chinessCalendar.veryShortMonthSymbols containsObject:monthString]) {
//                return _chineseMonths[month - 1];
//            }
//            // Leap month
//            monthString = [NSString stringWithFormat:@"闰%@", _chineseMonths[month - 1]];
//            return monthString;
//        }
//    }
//    return nil;
//}
//- (NSString *)calendarChineseString {
//    [self setupChinessCalendar];
//    NSInteger day = [self getChinessDay];
//    if (day != 1) {
//        return [self getChineseDayString];
//    }
//    return [self getChineseMonthString];
//}
//- (NSString *)getChineseDayString {
//    if (self) {
//        NSInteger day = [self getChinessDay];
//        if (day > 0) {
//            [self setupChineseDay];
//            return _chineseDays[day - 1];
//        }
//    }
//    return nil;
//}
//- (NSInteger)getChinessYear {
//    if (self) {
//        [self setupChinessCalendar];
//        NSDateComponents *comps = [_chinessCalendar components:NSCalendarUnitYear fromDate:self];
//        return comps.year;
//    }
//    return 0;
//}
//- (NSInteger)getChinessMonth {
//    if (self) {
//        [self setupChinessCalendar];
//        NSDateComponents *comps = [_chinessCalendar components:NSCalendarUnitMonth fromDate:self];
//        return comps.month;
//    }
//    return 0;
//}
//- (NSInteger)getChinessDay {
//    if (self) {
//        [self setupChinessCalendar];
//        NSDateComponents *comps = [_chinessCalendar components:NSCalendarUnitDay fromDate:self];
//        return comps.day;
//    }
//    return 0;
//}
//
//- (NSArray *)setupZodiacs {
//    if (_zodiacs == nil) {
//        _zodiacs = [NSArray arrayWithPlist:@"zodiacs"];
//    }
//    return _zodiacs;
//}
//- (NSArray *)setupChineseMonth {
//    if (_chineseMonths == nil) {
//        _chineseMonths = [NSArray arrayWithPlist:@"chineseMonth"];
//    }
//    return _chineseMonths;
//}
//- (NSArray *)setupChineseDay {
//    if (_chineseDays == nil) {
//        _chineseDays = [NSArray arrayWithPlist:@"chineseDay"];
//    }
//    return _chineseDays;
//}
//- (NSArray *)setupHeavenlyStems {
//    if (_heavenlyStems == nil) {
//        _heavenlyStems = [NSArray arrayWithPlist:@"heavenlyStems"];
//    }
//    return _heavenlyStems;
//}
//- (NSArray *)setupEarthlyBranches {
//    if (_earthlyBranches == nil) {
//        _earthlyBranches = [NSArray arrayWithPlist:@"earthlyBranches"];
//    }
//    return _earthlyBranches;
//}


@end
