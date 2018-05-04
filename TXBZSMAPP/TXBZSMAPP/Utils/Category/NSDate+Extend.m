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
-(NSInteger)getXingzuo {
    [self setupCalendar];
    NSDateComponents *comps = [_calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger i_month = comps.month;
    NSInteger i_day = comps.day;
    NSInteger index = 0;
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                index = 10;
            }
            if(i_day>=1 && i_day<=19){
                index = 9;
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                index = 10;
            }
            if(i_day>=19 && i_day<=31){
                index = 11;
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                index = 11;
            }
            if(i_day>=21 && i_day<=31){
                index = 0;
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                index = 0;
            }
            if(i_day>=20 && i_day<=31){
                index = 1;
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                index = 1;
            }
            if(i_day>=21 && i_day<=31){
                index = 2;
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                index = 2;
            }
            if(i_day>=22 && i_day<=31){
                index = 3;
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                index = 3;
            }
            if(i_day>=23 && i_day<=31){
                index = 4;
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                index = 4;
            }
            if(i_day>=23 && i_day<=31){
                index = 5;
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                index = 5;
            }
            if(i_day>=23 && i_day<=31){
                index = 6;
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                index = 6;
            }
            if(i_day>=24 && i_day<=31){
                index = 7;
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                index = 7;
            }
            if(i_day>=22 && i_day<=31){
                index = 8;
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                index = 8;
            }
            if(i_day>=21 && i_day<=31){
                index = 9;
            }
            break;
    }
    return index;
}
@end
