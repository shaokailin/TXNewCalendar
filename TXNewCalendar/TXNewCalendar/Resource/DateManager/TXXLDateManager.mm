//
//  TXXLDateManager.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLDateManager.h"
#import "SynthesizeSingleton.h"
#import "TXXLDBManager.h"
const  int START_YEAR =1901;
const  int END_YEAR   =3000;
@interface TXXLDateManager ()
{
    NSCalendar * _chinessCalendar;
    NSDateFormatter * _chinessFormatter;
    NSCalendar *_localeCalendar;
}
@property (strong ,nonatomic)TXXLDBManager *dbManager;
@property (nonatomic, strong)NSDictionary *lunDic;
@property (nonatomic, strong)NSArray *zodiacs;//12生肖
@property (nonatomic, strong)NSArray *chineseMonths;//中国的农历月份
@property (nonatomic, strong)NSArray *chineseDays;//中国的农历天数
@property (nonatomic, strong)NSArray *heavenlyStems;//天干
@property (nonatomic, strong)NSArray *earthlyBranches;//地支
@property (nonatomic, strong)NSArray *solartermArray;//24节气
@property (nonatomic, strong)NSDictionary *chineseHoliDay;//中国节假日
@property (nonatomic, strong)NSDictionary *publicHoliDay;//中国节假日
@property (nonatomic, copy, readwrite) NSDate *springStartDate;
@property (nonatomic, assign) NSInteger chinesSYear;//系统获取的
@property (nonatomic, strong) NSMutableArray *solartermDateArray;
@property (nonatomic, assign) NSInteger solartermDateYear;
@property (nonatomic, assign) NSInteger monthDiZhi;
@end
@implementation TXXLDateManager
SYNTHESIZE_SINGLETON_CLASS(TXXLDateManager);
- (instancetype)init {
    if (self = [super init]) {
        _chinessCalendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
        [_chinessCalendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
        _localeCalendar =  [NSCalendar currentCalendar];
        [_localeCalendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
        _chinessFormatter = [[NSDateFormatter alloc] init];
        _chinessFormatter.calendar = _chinessCalendar;
        _chinessFormatter.dateFormat = @"M";
        _chinesSYear = -1;
        _chineseYear = -1;
        _chineseDay = -1;
        _chineseMonth = -1;
        _monthDiZhi = -1;
        _year = -1;
        _day = -1;
        _month = -1;
    }
    return self;
}
- (NSArray *)getHolidayList:(BOOL)isFive {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:5];
    NSDate *searchDate1 = [NSDate stringTransToDate:[_searchDate dateTransformToString:kCalendarFormatter] withFormat:kCalendarFormatter];
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    for (int i = 0; i < 366; i++) {
        NSDate *date = [searchDate1 dateByAddingTimeInterval:(60 * 60 * 24) * i];
        NSDateComponents *comps = [_chinessCalendar components:unitFlags fromDate:date];
        NSString *chinessString = NSStringFormat(@"%ld-%ld",(long)comps.month,(long)comps.day);
        if ([self.chineseHoliDay.allKeys containsObject:chinessString]) {
            NSString *title = [self.chineseHoliDay objectForKey:chinessString];
            [array addObject:@{@"title":title,@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
            if (array.count == 5 && isFive) {
                break;
            }
        }
        NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:date];
        NSString *dataString = NSStringFormat(@"%zd-%zd",localeComp.month,localeComp.day);
        if([self.lunDic.allKeys containsObject:dataString]){
            if ([self.lunDic.allKeys containsObject:dataString]) {
                NSString *title = [self.lunDic objectForKey:dataString];
                [array addObject:@{@"title":title,@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                if (array.count == 5 && isFive) {
                    break;
                }
            }else {
                //母亲节
                localeComp.month = 5;
                localeComp.day = 1;
                NSInteger week_now =   [[_localeCalendar dateFromComponents:localeComp] getWeekIndex]-1;
                NSString *motherDayStr = [NSString stringWithFormat:@"5-%zd", week_now == 0 ? 8 : 15 -week_now];
                if ([motherDayStr isEqualToString:dataString]) {
                    [array addObject:@{@"title":@"母亲节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                }else {
                    //父亲节
                    localeComp.month = 6;
                    NSInteger week_now2 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
                    NSString *fatherDayStr = [NSString stringWithFormat:@"6-%zd", week_now2 == 0 ? 1 : 22 -week_now2];
                    if ([fatherDayStr isEqualToString:dataString]) {
                        [array addObject:@{@"title":@"父亲节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                    }else {
                        //感恩节
                        localeComp.month = 11;
                        NSInteger week_now3 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
                        NSInteger thanksgivingDayDay = (4 >= week_now3) ? ((4 - week_now3) + 22) : (28 - (week_now3 - 5));
                        NSString *thanksgivingDayStr = [NSString stringWithFormat:@"11-%zd",thanksgivingDayDay];
                        if ([thanksgivingDayStr isEqualToString:dataString]) {
                            [array addObject:@{@"title":@"感恩节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                        }
                    }
                }
                if (array.count == 5 && isFive) {
                    break;
                }
            }
        }
    }
    return array;
}
//获取日期节日
- (NSString *)getHasHolidayString {
    NSString *dataString = NSStringFormat(@"%zd-%zd",_month,_day);
    if ([self.lunDic.allKeys containsObject:dataString]) {
        return [self.lunDic objectForKey:dataString];
    }
    NSString *chinessString = NSStringFormat(@"%zd-%zd",_chineseMonth,_chineseDay);
    if ([self.chineseHoliDay.allKeys containsObject:chinessString]) {
        return [self.chineseHoliDay objectForKey:chinessString];
    }
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:_searchDate];
    //母亲节
    localeComp.month = 5;
    localeComp.day = 1;
    NSInteger week_now = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex]-1;
    NSString *motherDayStr = [NSString stringWithFormat:@"5-%zd", week_now == 0 ? 8 : 15 -week_now];
    if ([motherDayStr isEqualToString:dataString]) {
        return @"母亲节";
    }else {
        //父亲节
        localeComp.month = 6;
        NSInteger week_now2 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
        NSString *fatherDayStr = [NSString stringWithFormat:@"6-%zd", week_now2 == 0 ? 1 : 22 -week_now2];
        if ([fatherDayStr isEqualToString:dataString]) {
            return @"父亲节";
        }else {
            //感恩节
            localeComp.month = 11;
            NSInteger week_now3 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
            NSInteger thanksgivingDayDay = (4 >= week_now3) ? ((4 - week_now3) + 22) : (28 - (week_now3 - 5));
            NSString *thanksgivingDayStr = [NSString stringWithFormat:@"11-%zd",thanksgivingDayDay];
            if ([thanksgivingDayStr isEqualToString:dataString]) {
                return @"感恩节";
              }
            }
        }
    return [self solartermFromDate:_searchDate];
}
- (void)getSolartermDateListWithYear:(NSInteger)year {
    if (_solartermDateYear == year) {
        return;
    }
    [self.solartermDateArray removeAllObjects];
    for (int i = 0; i < 24; i++) {
        _solartermDateYear = year;
        [self.solartermDateArray addObject:[self getSolartermDateWithYear:year index:i]];
    }
}
- (NSMutableArray *)solartermDateArray {
    if (!_solartermDateArray) {
        _solartermDateArray = [NSMutableArray array];
    }
    return _solartermDateArray;
}
- (NSDate *)getSolartermDateWithYear:(NSInteger)year index:(NSInteger)index {
    NSString *patch = [[NSBundle mainBundle]pathForResource:NSStringFormat(@"%zd",index) ofType:@"dat"];
    NSString *content = [NSString stringWithContentsOfFile:patch encoding:NSUTF8StringEncoding error:nil];
    NSArray *data = [content componentsSeparatedByString:@"\r\n"];
    NSInteger index1 = year - START_YEAR + 1;
    NSString *dateString = [data objectAtIndex:index1];
    NSArray *dateArray = [dateString componentsSeparatedByString:@":"];
    dateString = NSStringFormat(@"%@:%@",[dateArray objectAtIndex:0],[dateArray objectAtIndex:1]);
    NSDate *date = [NSDate stringTransToDate:dateString withFormat:@"yyyy-MM-dd HH:mm"];
    return date;
}
#pragma mark 节气
- (NSString *)solartermFromDate:(NSDate *)date {
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:_searchDate];
    NSInteger year = localeComp.year;
    NSInteger month = localeComp.month * 2;
    NSInteger day = localeComp.day;
    NSInteger index = month - 2;
    NSDate *firstDate = [self getSolartermDateWithYear:year index:index];
    NSDateComponents *firstComp = [_localeCalendar components:NSCalendarUnitDay fromDate:firstDate];
    if (firstComp.day != day) {
        index = month - 1;
        NSDate *lastDate = [self getSolartermDateWithYear:year index:index];
        NSDateComponents *lastComp = [_localeCalendar components:NSCalendarUnitDay fromDate:lastDate];
        if (lastComp.day != day) {
            index = -1;
        }
    }
    if (index != -1) {
        NSDictionary *dict = [self.solartermArray objectAtIndex:index];
        return [dict objectForKey:@"title"];
    }else {
        return nil;
    }
}
#pragma mark -获取天干地支 年柱
- (NSInteger)getHeavenlyStems {
    NSInteger index = (_year - 3) % 10;
    index += [self compareSringStartDate];
    if (index < 0) {
        index = 9;
    }
    index -= 1;
    if (index < 0) {
        index = 9;
    }
    return index;
}
- (NSInteger)getEarthlyBranches {
    NSInteger index = (_year - 3) % 12;
    index += [self compareSringStartDate];
    if (index < 0) {
        index = 11;
    }
    index -= 1;
    if (index < 0) {
        index = 11;
    }
    return index;
}
//大于12 上一年  小于12为新
- (NSInteger)compareSringStartDate {
    NSComparisonResult res = [_searchDate compare:self.springStartDate];
    if (res < 0) {
        return -1;
    }else {
        return 0;
    }
//    unsigned unitFlags = NSCalendarUnitHour|NSCalendarUnitMonth|NSCalendarUnitDay;
//    NSDateComponents *searchComp = [_localeCalendar components:unitFlags fromDate:_searchDate];
//    NSInteger currentMonth = searchComp.month;
//    NSInteger currentDay = searchComp.day;
//
//    NSDateComponents *dateComp = [_localeCalendar components:unitFlags fromDate:self.springStartDate];
//    NSInteger dateMonth = dateComp.month;
//    NSInteger dateDay = dateComp.day;
//
//    if (currentMonth > dateMonth) {
//        return 0;
//    }else if (currentMonth < dateMonth) {
//        return -1;
//    }else {
//        if (currentDay > dateDay) {
//            return 0;
//        }else if (currentDay < dateDay) {
//            return -1;
//        }else {
//            if (dateComp.hour > 12) {
//                return -1;
//            }
//        }
//    }
    return 0;
}
#pragma mark -获取天干地支 月柱
- (NSString *)getGanzhiMouth{
    NSDictionary * mouthDizhi = @{
                                  @"甲&己":@[@"丙寅",@"丁卯",@"戊辰",@"己巳",@"庚午",@"辛未",@"壬申",@"癸酉",@"甲戌",@"乙亥",@"丙子",@"丁丑"],
                                  @"乙&庚":@[@"戊寅",@"己卯",@"庚辰",@"辛巳",@"壬午",@"癸未",@"甲申",@"乙酉",@"丙戌",@"丁亥",@"戊子",@"己丑"],
                                  @"丙&辛":@[@"庚寅",@"辛卯",@"壬辰",@"癸巳",@"甲午",@"乙未",@"丙申",@"丁酉",@"戊戌",@"己亥",@"庚子",@"辛丑"],
                                  @"丁&壬":@[@"壬寅",@"癸卯",@"甲辰",@"乙巳",@"丙午",@"丁未",@"戊申",@"己酉",@"庚戌",@"辛亥",@"壬子",@"癸丑"],
                                  @"戊&癸":@[@"甲寅",@"乙卯",@"丙辰",@"丁巳",@"戊午",@"己未",@"庚申",@"辛酉",@"壬戌",@"癸亥",@"甲子",@"乙丑"]
                                  };
    NSString * year_ganzhi = [self tgdzString];
    NSInteger mouth_zhi_index = self.monthDiZhi;
    NSArray * dizhi_arr = [mouthDizhi allKeys];
    NSString * mouth_ganzhi;
    for (NSString * str in dizhi_arr) {
        if ([str containsString:[year_ganzhi substringToIndex:1]]) {
            NSArray * arr = [mouthDizhi objectForKey:str];
            mouth_ganzhi = arr[mouth_zhi_index];
        }
    }
    return mouth_ganzhi;
}
- (NSInteger)mouthZhiIndex{
    [self getSolartermDateListWithYear:_year];
    int index = -1;
    for (int i  = 0;i < self.solartermDateArray.count ;i++) {
        NSDate *date = self.solartermDateArray[i];
        NSDate *date1 = [NSDate stringTransToDate:[date dateTransformToString:@"yyyy-MM-dd HH:mm"] withFormat:@"yyyy-MM-dd HH:mm"];
        NSComparisonResult res = [_searchDate compare:date1];
        if (res >= 0) {
            index ++;
        }else {
            break;
        }
    }
    NSInteger zhi_id = 0;
    if (index <= 1) {
        zhi_id =  1;
    }else if (index <= 3) {
        zhi_id =   2;
    }else if (index <= 5) {
        zhi_id =   3;
    }else if (index <= 7) {
        zhi_id =   4;
    }else if (index <= 9) {
        zhi_id =   5;
    }else if (index <= 11) {
        zhi_id =   6;
    }else if (index <= 13) {
        zhi_id =   7;
    }else if (index <= 15) {
        zhi_id =  8;
    }else if (index <= 17) {
        zhi_id =   9;
    }else if (index <= 19) {
        zhi_id =   10;
    }else if (index <= 21) {
        zhi_id =   11;
    }else {
        zhi_id =  0;
    }
//    if (zhi_id == 0) {
//        zhi_id = 10;
//    }
//    NSInteger zhi_id = index / 2;
    if (zhi_id == 0) {
        zhi_id = 10;
    }else if (zhi_id == 1){
        zhi_id = 11;
    }else{
        zhi_id = zhi_id-2;
    }
    return zhi_id;
}
#pragma mark - 日干支
- (NSString *)getGanzhiDay{
    if (!_dtgdzString) {
        
        NSInteger y = _year % 100 + 100;
        NSInteger m = _month;
        NSInteger d = _day;
        
        NSInteger gan_index = y*5 + y/4 + 9 + d;
        if (m%2 == 0) {
            gan_index = gan_index + 30;
        }
        NSInteger offset = 0;
        if(m == 1 || m == 2){
            offset = m;
            if(y%4 == 0){
                offset--;
            }
        }else if (m == 4||m == 5) {
            offset = 1;
        }else if(m == 6||m == 7){
            offset = 2;
        }else if (m == 8){
            offset = 3;
        }else if(m == 9||m == 10){
            offset = 4;
        }else if (m == 11||m == 12){
            offset = 5;
        }
        gan_index = gan_index + offset;
        gan_index = gan_index % 60;
        if (gan_index == 0) {
            gan_index = 59;
        }else{
            gan_index--;
        }
        NSArray *ganzhi_Arr = [NSArray arrayWithPlist:@"chineseYear"];
        _dtgdzString = ganzhi_Arr[gan_index];
    }
    return _dtgdzString;
}
#pragma mark - 时干支
- (NSString *)getLunarTianganHour:(NSString *)dizhi{
    NSString *dayT = [[self getGanzhiDay]substringToIndex:1];
    NSDictionary *of = nil;
    if ([@[@"甲",@"己"] containsObject:dayT]) {
        of = @{ @"子" : @"甲",@"丑" : @"乙",@"寅" : @"丙",@"卯" : @"丁",@"辰":@"戊", @"巳":@"己", @"午":@"庚" ,@"未" : @"辛",@"申" : @"壬",@"酉" : @"癸",@"戌" : @"甲",@"亥" : @"乙"};
    }else if ([@[@"乙",@"庚"] containsObject:dayT]) {
        of = @{ @"子" : @"丙",@"丑" : @"丁",@"寅" : @"戊",@"卯" : @"己",@"辰":@"庚", @"巳":@"辛", @"午":@"壬" ,@"未" : @"癸",@"申" : @"甲",@"酉" : @"乙",@"戌" : @"丙",@"亥" : @"丁"};
    }else if ([@[@"丙",@"辛"] containsObject:dayT]) {
        of = @{ @"子":@"戊", @"丑":@"己", @"寅":@"庚", @"卯":@"辛", @"辰":@"壬", @"巳":@"癸", @"午":@"甲" , @"未":@"乙", @"申":@"丙", @"酉":@"丁", @"戌":@"戊", @"亥":@"己"};
    }else if ([@[@"丁",@"壬"] containsObject:dayT]) {
        of = @{ @"子":@"庚", @"丑":@"辛", @"寅":@"壬", @"卯":@"癸", @"辰":@"甲", @"巳":@"乙", @"午":@"丙" , @"未":@"丁", @"申":@"戊", @"酉":@"己", @"戌":@"庚", @"亥":@"辛"};
    }else if ([@[@"戊",@"癸"] containsObject:dayT]) {
        of = @{ @"子":@"壬", @"丑":@"癸", @"寅":@"甲", @"卯":@"乙", @"辰":@"丙", @"巳":@"丁", @"午":@"戊" , @"未":@"己", @"申":@"庚", @"酉":@"辛", @"戌":@"壬", @"亥":@"癸"};
    }
    return [of objectForKey:dizhi];
}
- (NSString *)getDiZhiHour:(NSInteger)hour {
    NSArray *hourData = [NSArray arrayWithPlist:@"hour"];
    NSDictionary *dict = [hourData objectAtIndex:hour];
    NSString *dizhi = [dict objectForKey:@"name"];
    return dizhi;
}
- (NSArray *)getHourGanzhiAndState {
    NSMutableArray *array = [NSMutableArray array];
    NSDictionary *dict = [self getDictWithPlist:@"hourState"];
    NSString *dtgdz = [self getGanzhiDay];
    NSString *jiString = [dict objectForKey:dtgdz];
    if (jiString == nil) {
        jiString = [dict objectForKey:@"甲子"];
    }
    for (int i = 0; i < 12; i ++) {
       NSString *dizhi = [self getDiZhiHour:i];
        NSString *tiangan = [self getLunarTianganHour:dizhi];
        NSString *state = [jiString rangeOfString:dizhi].location != NSNotFound ? @"吉":@"凶";
        [array addObject:@{@"name":NSStringFormat(@"%@\n%@",tiangan,dizhi),@"state":state}];
    }
    return array;
}
#pragma mark - 获取时辰宜忌
- (NSArray *)getHoursDetail {
    NSString *dgz = [self getGanzhiDay];
//    NSString *datT = [dgz substringToIndex:1];
    NSArray *hour = [NSArray arrayWithPlist:@"hour"];
    NSDictionary *stateDict = [self getDictWithPlist:@"hourState"];
    NSDictionary *yijiDict = [self getDictWithPlist:@"houryiji"];
    NSString *jiString = [stateDict objectForKey:dgz];
    if (jiString == nil) {
        jiString = [stateDict objectForKey:@"甲子"];//天时辰的吉凶
    }
    NSDictionary *houryiji = [yijiDict objectForKey:dgz];
    if (houryiji == nil) {
        houryiji = [yijiDict objectForKey:@"甲子"];
    }
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < hour.count; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSDictionary *hourDetail = [hour objectAtIndex:i];
        NSString *hourName = [hourDetail objectForKey:@"name"];
        NSString *tiangan = [self getLunarTianganHour:hourName];
        NSString *hourGZ = NSStringFormat(@"%@%@",tiangan,hourName);
        [dict setObject:hourGZ forKey:@"hour"];
        [dict setObject:[hourDetail objectForKey:@"time"] forKey:@"time"];
        
        NSDictionary *shiyiji = [houryiji objectForKey:hourName];
        [dict addEntriesFromDictionary:shiyiji];
        NSString *state = nil;
        if ([jiString rangeOfString:hourName].location == NSNotFound) {
            state = @"凶";
        }else {
            state = @"吉";
        }
        [dict setObject:state forKey:@"jix"];
        NSString *zhengchong = [self getZhengChong:hourGZ];
        [dict setObject:zhengchong forKey:@"zheng_chong"];
        NSString *sha = [[self getSanShaWithDz:hourName] objectAtIndex:0];
        [dict setObject:sha forKey:@"sha"];
        NSDictionary *position = [self getPostionWithTianGan:tiangan];
        [dict setValue:position forKey:@"position"];
        NSString *sheng = [[self getBaMenPostionWithGanZhi:hourGZ]objectForKey:@"生"];
        [dict setValue:sheng forKey:@"sheng"];
        NSArray *dizhiChong = @[ @[@"子", @"午"], @[@"丑", @"未"],@[@"寅", @"申"], @[@"卯", @"酉"],@[@"辰", @"戌"],@[@"巳", @"亥"]];
        for (NSArray *array in dizhiChong) {
            if ([array containsObject:hourName]) {
                NSString *oneValue = [array objectAtIndex:0];
                if ([oneValue isEqualToString:hourName]) {
                    [dict setObject:[array objectAtIndex:1] forKey:@"sx_chong"];
                }else {
                    [dict setObject:[array objectAtIndex:0] forKey:@"sx_chong"];
                }
                break;
            }
        }
        [array addObject:dict];
    }
    return array;
}
- (NSString *)getZhengChong:(NSString *)gz {
    NSDictionary *dict = [self getDictWithPlist:@"zhengchong"];
    return KNullTransformString([dict objectForKey:gz]);
}
#pragma mark - 值神
- (NSString *)getZhiShen {
    NSArray *list = [NSArray arrayWithPlist:@"zhishen"];
    //huan_dao $list2[$index],
//    $list2 = ["黄道", "黄道", "黑道", "黑道", "黄道", "黄道", "黑道", "黄道", "黑道", "黑道", "黄道", "黑道"];
//    //星神xing_shen $list3[$index],
//    $list3 = ["天乙星", "贵人星", "天刑星", "天讼星", "福德星", "天德星", "天杀星", "天开星", "镇神星", "天狱星", "凤辇星", "地狱星"];
    //shen_sha
    NSString *rgz = [self getGanzhiDay];
    NSArray *list4 = @[@"青龙", @"明堂", @"天刑", @"朱雀", @"金匮", @"天德", @"白虎", @"玉堂", @"天牢", @"玄武", @"司命", @"勾陈"];
    NSInteger monthDzindex = self.monthDiZhi;
    NSArray *array = list[monthDzindex];
    NSInteger index = [array indexOfObject: [rgz substringFromIndex:1]];
    return list4[index];
}
#pragma mark - 建除
- (NSString *)getJianChu {
    NSArray *dz = @[@"寅", @"卯", @"辰", @"巳", @"午", @"未", @"申", @"酉", @"戌", @"亥", @"子", @"丑"];
    NSArray *list = [NSArray arrayWithPlist:@"jianchu"];
    NSString *ygz = [[self getGanzhiMouth]substringFromIndex:1];
    NSString *rgz = [[self getGanzhiDay] substringFromIndex:1];
    NSInteger yIndex = [dz indexOfObject:ygz];
    NSInteger rIndex = [dz indexOfObject:rgz];
    return list[yIndex][rIndex];
}
#pragma mark 纳音
- (NSString *)getNayinWithDay {
    NSString *rgz = [self getGanzhiDay];
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"wuxing" ofType:@"plist"]];
    return [dict objectForKey:rgz];
}
#pragma mark -星宿
- (NSArray *)getXingSu {
    NSDate *baseDate = [NSDate stringTransToDate:@"1901-01-01" withFormat:@"yyyy-MM-dd"];
    NSTimeInterval startTime = [baseDate timeIntervalSince1970];
    NSTimeInterval time = [_searchDate timeIntervalSince1970];
    NSInteger timeBetween = floor(time - startTime);
    NSInteger index = 24 + (timeBetween / 86400) % 28;
    if (index > 28) {
        index = index - 28;
    }
    if (index < 1) {
        index = 1;
    }
    NSArray *xingxiu = [NSArray arrayWithPlist:@"xingxiu"];
    return [xingxiu objectAtIndex:index];
}
#pragma mark -taishen
- (NSArray *)getTaiShen {
    NSDictionary *taishenDict = [self getDictWithPlist:@"taishen"];
    NSString *rgz = [self getGanzhiDay];
    NSArray *list = [taishenDict objectForKey:rgz];
    if (KJudgeIsArrayAndHasValue(list)) {
        return @[[list objectAtIndex:0],NSStringFormat(@"本日胎神在%@，在这些方位不可随意敲打、动剪刀或移动物件，以免对孕妇和胎儿不利。",[list objectAtIndex:1])];
    }else {
        return @[@"",@""];
    }
}
#pragma mark - 彭祖
- (NSArray *)getPengZu:(NSString *)gan dizhi:(NSString *)dizhi {
    NSDictionary *list = @{
             @"甲" : @"甲不开仓财物耗散",
             @"乙" : @"乙不栽植千株不长",
             @"丙" : @"丙不修灶必见灾殃",
             @"丁" : @"丁不剃头头必生疮",
             @"戊" : @"戊不受田田主不祥",
             @"己" : @"己不破券二比并亡",
             @"庚" : @"庚不经络织机虚张",
             @"辛" : @"辛不合酱主人不尝",
             @"壬" : @"壬不汲水更难提防",
             @"癸" : @"癸不词讼理弱敌强",
             };
    NSDictionary *list2 = @{
              @"子" : @"子不问卜自惹祸殃",
              @"丑" : @"丑不冠带主不还乡",
              @"寅" : @"寅不祭祀神鬼不尝",
              @"卯" : @"卯不穿井水泉不香",
              @"辰" : @"辰不哭泣必主重丧",
              @"巳" : @"巳不远行财物伏藏",
              @"午" : @"午不苫盖屋主更张",
              @"未" : @"未不服药毒气入肠",
              @"申" : @"申不安床鬼祟入房",
              @"酉" : @"酉不宴客醉坐颠狂",
              @"戌" : @"戌不吃犬作怪上床",
              @"亥" : @"亥不嫁娶不利新郎",
              };
    return @[[list objectForKey:gan],[list2 objectForKey:dizhi]];
}
- (NSArray *)getPengZuMessage {
    NSString *dgz = [self getGanzhiDay];
    return [self getPengZu:[dgz substringToIndex:1] dizhi:[dgz substringFromIndex:1]];
}
- (NSArray *)getPengZuDetail:(NSString *)dgz {
    NSString *tiangan = [dgz substringToIndex:1];
    NSString *dizhi = [dgz substringFromIndex:1];
    NSArray *pengzuTitleArray = [self getPengZu:tiangan dizhi:dizhi];
    NSDictionary *dict = [self getDictWithPlist:@"pengzuDetail"];
    NSArray *pengzuDetailArray = @[[dict objectForKey:tiangan],[dict objectForKey:dizhi]];
    return @[pengzuTitleArray,pengzuDetailArray];
}
#pragma mark - 相冲
- (NSString *)getXiangChong {
    NSString *dgz = [self getGanzhiDay];
    NSString *dizhi = [dgz substringFromIndex:1];
    NSString *chong = [self getChong:dizhi];
    NSString *sha = [[self getSanShaWithDz:dizhi] objectAtIndex:0];
    return NSStringFormat(@"冲%@%@",chong,sha);
    
}
//获取三杀
- (NSArray *)getSanShaWithDz:(NSString *)dz {
    NSDictionary *sanShaDict =  @{
        @"子": @[@"煞南", @"巳山", @"午山", @"未山"],
        @"丑": @[@"煞东", @"寅山", @"卯山", @"辰山"],
        @"寅": @[@"煞北", @"亥山", @"子山", @"丑山"],
        @"卯": @[@"煞西", @"申山", @"酉山", @"戌山"],
        @"辰": @[@"煞南", @"巳山", @"午山", @"未山"],
        @"巳": @[@"煞东", @"寅山", @"卯山", @"辰山"],
        @"午": @[@"煞北", @"亥山", @"子山", @"丑山"],
        @"未": @[@"煞西", @"申山", @"酉山", @"戌山"],
        @"申": @[@"煞南", @"巳山", @"午山", @"未山"],
        @"酉": @[@"煞东", @"寅山", @"卯山", @"辰山"],
        @"戌": @[@"煞北", @"亥山", @"子山", @"丑山"],
        @"亥": @[@"煞西", @"申山", @"酉山", @"戌山"]
        };
    return [sanShaDict objectForKey:dz];
}
#pragma mark - 获取首页幸运生肖
- (NSString *)getHomeLuckyShengxiao {
    NSString *dgz = [self getGanzhiDay];
    NSString *dizhi = [dgz substringFromIndex:1];
    return NSStringFormat(@"%@%@",[self getDizhiSanHe:dizhi],[self getLiuHe:dizhi]);
}
#pragma mark - 获取 今日合害数据
//地支相刑
- (NSString *)getXiangXing:(NSString *)dz {
    NSArray *list7 = @[@[@"子", @"卯"], @[@"寅", @"巳", @"申"], @[@"丑", @"未", @"戌"],@[@"辰", @"午", @"未"]];
    NSString *xiangXing = [self getShengxiaoForChong:list7 dizhi:dz];
    return xiangXing;
}
//地支相破
- (NSString *)getXiangPo:(NSString *)dz {
    NSArray *list6 = @[@[@"子", @"酉"], @[@"卯", @"午"], @[@"辰", @"丑"], @[@"未", @"戌"],@[@"寅", @"亥"],@[@"巳", @"申"]];
    NSString *xiangPo = [self getShengxiaoForChong:list6 dizhi:dz];
    return xiangPo;
}
//地支相害（相穿）
- (NSString *)getXiangHai:(NSString *)dz {
    NSArray *list5 = @[ @[@"子", @"未"], @[@"丑", @"午"],@[@"寅", @"巳"], @[@"卯", @"辰"],@[@"申", @"亥"], @[@"酉", @"戌"]];
    NSString *xiangHai = [self getShengxiaoForChong:list5 dizhi:dz];
    return xiangHai;
}
//地支三会
- (NSString *)getSanHui:(NSString *)dz {
    NSArray *list4 = @[ @[@"寅", @"卯", @"辰"], @[@"巳", @"午", @"未"], @[@"申", @"酉", @"戌"], @[@"亥", @"子", @"丑"]];
    NSString *sanhui = [self getShengxiaoForChong:list4 dizhi:dz];
    return sanhui;
}
//地支三合
- (NSString *)getDizhiSanHe:(NSString *)dz {
    NSDictionary *list = @{@"子": @[@"辰", @"申"], @"丑": @[@"巳", @"酉"],@"寅": @[@"午", @"戌"], @"卯": @[@"亥", @"未"],  @"辰": @[@"子", @"申"], @"巳": @[@"酉", @"丑"], @"午": @[@"寅", @"戌"],@"未": @[@"亥", @"卯"], @"申": @[@"辰", @"子"], @"酉": @[@"巳", @"丑"], @"戌": @[@"午", @"寅"], @"亥": @[@"卯", @"未"] };
    NSMutableString *chong = [NSMutableString stringWithString:@""];
    NSArray *sanHeList = [list objectForKey:dz];
    for (int i = 0; i < sanHeList.count; i++) {
        NSString *dizhi1 = [sanHeList objectAtIndex:i];
        NSInteger index = [self.earthlyBranches indexOfObject:dizhi1];
//        if (i != 0) {
//            [chong appendString:@","];
//        }
        [chong appendString:[self.zodiacs objectAtIndex:index]];
    }
    return chong;
}
//地支六合
- (NSString *)getLiuHe:(NSString *)dz {
    NSArray *list3= @[ @[@"子", @"丑"], @[@"寅", @"亥"], @[@"卯", @"戌"], @[@"辰", @"酉"],@[@"巳", @"申"], @[@"午", @"未"],  ];
    NSString *liuhe = [self getShengxiaoForChong:list3 dizhi:dz];
    return liuhe;
}
//地支相冲
- (NSString *)getChong:(NSString *)dz {
    NSArray *dizhiChong = @[ @[@"子", @"午"], @[@"丑", @"未"],@[@"寅", @"申"], @[@"卯", @"酉"],@[@"辰", @"戌"],@[@"巳", @"亥"]];
    NSString *chong = [self getShengxiaoForChong:dizhiChong dizhi:dz];
    return chong;
}
//获取今日合害生肖
- (NSString *)getShengxiaoForChong:(NSArray *)list dizhi:(NSString *)dizhi {
    NSMutableString *chong = [NSMutableString stringWithString:@""];
    for (NSArray *dizhiArray in list) {
        if ([dizhiArray containsObject:dizhi]) {
            for (int i = 0; i < dizhiArray.count; i++) {
                NSString *dizhi1 = [dizhiArray objectAtIndex:i];
                if (![dizhi1 isEqualToString:dizhi]) {
                    NSInteger index = [self.earthlyBranches indexOfObject:dizhi1];
//                    if (i != 0) {
//                        [chong appendString:@","];
//                    }
                    [chong appendString:[self.zodiacs objectAtIndex:index]];
                }
            }
            break;
        }
    }
    return chong;
}
#pragma mark - 罗盘首页数据
- (NSDictionary *)getCompassMessage {
    NSString *dgz = [self getGanzhiDay];
    NSDictionary *postion = [self getPostionWithTianGan:[dgz substringToIndex:1]];
    NSString *sheng = [[self getBaMenPostionWithGanZhi:dgz]objectForKey:@"生"];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:postion];
    [dict setObject:sheng forKey:@"sheng"];
    return dict;
}
- (NSDictionary *)getDayPosition {
    NSString *dgz = [self getGanzhiDay];
    NSDictionary *postion = [self getPostionWithTianGan:[dgz substringToIndex:1]];
    return postion;
}
#pragma mark - 获取postion
- (NSDictionary *)getBaMenPostionWithGanZhi:(NSString *)gz {
    NSDictionary *dict = [self getDictWithPlist:@"bamenPosition"];
    if (![dict.allKeys containsObject:gz]) {
        gz = @"庚午";
    }
    return [dict objectForKey:gz];
}
- (NSDictionary *)getPostionWithTianGan:(NSString *)tiangan {
    NSDictionary *dict = @{
        @"甲": @[@"东南", @"东北", @"东北", @"西南", @"东北"],
        @"乙": @[@"东南", @"西北", @"东北", @"西南", @"正北"],
        @"丙": @[@"正东", @"西南", @"西南", @"正西", @"西北"],
        @"丁": @[@"正东", @"正南", @"西南", @"西北", @"正西"],
        @"戊": @[@"正北", @"东南", @"正北", @"东北", @"西南"],
        @"己": @[@"正南", @"东北", @"正北", @"正北", @"西南"],
        @"庚": @[@"西南", @"西北", @"正东", @"东北", @"西南"],
        @"辛": @[@"西南", @"西南", @"正东", @"东北", @"正南"],
        @"壬": @[@"西北", @"正南", @"正南", @"正东", @"东南"],
        @"癸": @[@"正西", @"东南", @"正南", @"东南", @"正东"]
        };
    if (![dict.allKeys containsObject:tiangan]) {
        tiangan = @"甲";
    }
    NSArray *result = [dict objectForKey:tiangan];
    return @{@"fu_shen":[result objectAtIndex:0],@"xi_shen":[result objectAtIndex:1],@"cai_shen":[result objectAtIndex:2],@"yang_gui_ren":[result objectAtIndex:3],@"yin_gui_ren":[result objectAtIndex:4]};
}
#pragma mark - 获取 吉凶宜忌
- (NSDictionary *)getTgdzYiJiXiongJi {
    NSString *ganzi = [self getGanzhiDay];
    NSInteger monthDzindex = self.monthDiZhi + 1;
    NSDictionary *dict = [self.dbManager selectYiJiXiongJi:ganzi month:monthDzindex];
    return dict;
}
- (NSString *)getYiJiDetail:(NSString *)key {
    NSDictionary *jixiongyijiDic = [self getDictWithPlist:@"jixiongdetail"];
    return [jixiongyijiDic objectForKey:key];
}
- (NSArray *)getSearshList:(NSDate *)startDate timeBetween:(NSInteger)countDate key:(NSString *)key isWeek:(BOOL)isWeek isAvoid:(BOOL)isAvoid {
    NSDictionary *dict = [self.dbManager selectSearch:key isAvoid:isAvoid];
    NSArray *yueArray = dict.allKeys;
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:30];
    for (int i = 0; i < countDate; i ++) {
        NSDate *date = [startDate dateByAddingTimeInterval:(60 * 60 * 24) * i];
        if (!isWeek || (isWeek && [date getWeekIndex] > 5)) {
            self.searchDate = date;
            NSString *gz = [self getGanzhiDay];
            NSInteger yue = self.monthDiZhi + 1;
            if ([yueArray containsObject:@(yue)]) {
                NSArray *gzArray = [dict objectForKey:@(yue)];
                if ([gzArray containsObject:gz]) {
                    [array addObject:@{@"nlmonthday":NSStringFormat(@"%@%@",[self chineseMonthString],[self chineseDayString]),@"nlYeargz":[self tgdzString],@"nlMonthgz":[self getGanzhiMouth],@"nlDaygz":[self getGanzhiDay],@"zhishen":[self getZhiShen],@"jianchu":[self getJianChu],@"xingxiu":[[self getXingSu] objectAtIndex:0],@"count":@(i),@"date":[date dateTransformToString:kCalendarFormatter],@"week":[date getWeekDate]}];
                }
            }
        }
    }
    return array;
}

- (TXXLDBManager *)dbManager {
    if (!_dbManager) {
        _dbManager = [[TXXLDBManager alloc]init];
    }
    return _dbManager;
}
#pragma mark - 现代文获取
- (NSDictionary *)getCurrentModernText {
    NSString *dgz = [self getGanzhiDay];
    NSString *ddizhi = [dgz substringFromIndex:1];
    NSArray *sanSha = [self getSanShaWithDz:ddizhi];
    //星宿
    NSMutableArray *xingxiu = [[self getXingSu]mutableCopy];
    NSDictionary *xxDetailDic = [self getDictWithPlist:@"xingxiuDetail"];
    NSString *xingxiuDetail = [xxDetailDic objectForKey:[xingxiu objectAtIndex:0]];
    [xingxiu addObject:xingxiuDetail];
    //建除12神
    NSString *jianchu = [self getJianChu];
    NSDictionary *jianchuDetail = [self getDictWithPlist:@"jianchudetail"];
    //值神
    NSString *zhishen = [self getZhiShen];
    NSDictionary *zhishenDetail = [self getDictWithPlist:@"shenshadetail"];
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    [result setObject:@{@"name":jianchu,@"detail":[jianchuDetail objectForKey:jianchu]} forKey:@"jian_chu"];
    [result setObject:@{@"name":zhishen,@"detail":[zhishenDetail objectForKey:zhishen]} forKey:@"zhi_shen"];
    [result setObject:xingxiu forKey:@"xing_su"];
    
    NSString *chong = [self getChong:ddizhi];
    NSString *sha = [[sanSha objectAtIndex:0] stringByReplacingOccurrencesOfString:@"煞" withString:@""];
    [result setObject:@{@"chong":chong,@"sha":sha} forKey:@"chong_sha"];
    
    NSString *wuxing = [self getNayinWithDay];
    NSDictionary *nayin = [self getDictWithPlist:@"nayindetail"];
    [result setObject:@{@"name":wuxing,@"detail":[nayin objectForKey:wuxing]} forKey:@"na_yin"];
    
    NSArray *taishen = [self getTaiShen];
    [result setObject:taishen forKey:@"tai_shen"];
    
    NSArray *pengzu = [self getPengZuDetail:dgz];
    [result setObject:pengzu forKey:@"peng_zu"];
    
    NSString *liuhe = [self getLiuHe:ddizhi];
    NSInteger index = [self.zodiacs indexOfObject:liuhe];
    NSString *dizhi = [self.earthlyBranches objectAtIndex:index];
    [result setObject:@{@"shengxiao":liuhe,@"ganzhi":dizhi,@"info":@"生肖六合是一种暗合，指的是暗中帮助你的贵人。"} forKey:@"lucky"];
    
    NSDictionary *jixiong = [self getTgdzYiJiXiongJi];
    NSDictionary *jixiongyijiDic = [self getDictWithPlist:@"jixiongdetail"];
    for (NSString *key in jixiong.allKeys) {
        NSMutableArray *data = [NSMutableArray array];
        NSArray *array = [[jixiong objectForKey:key]componentsSeparatedByString:@"、"];
        for (NSString *content in array) {
            [data addObject:@{@"name":content,@"detail":KNullTransformString([jixiongyijiDic objectForKey:content])}];
        }
        [result setObject:data forKey:key];
    }
    return result;
}
#pragma mark - 获取当前日期的上下节气
- (NSDictionary *)getBetweenSolarterm {
    NSMutableDictionary * jieArr = [NSMutableDictionary dictionary];
    NSDate *lastDate = nil;
    NSInteger lastIndex = -1;
    NSDate *maxDate = nil;
    int maxIndex = -1;
    [self getSolartermDateListWithYear:_year];
   NSDate *searchDate1 = [NSDate stringTransToDate:[_searchDate dateTransformToString:kCalendarFormatter] withFormat:kCalendarFormatter];
    for (int i = 0; i < self.solartermArray.count; i++) {
        NSDictionary *dict = [self.solartermArray objectAtIndex:i];
        int index = [[dict objectForKey:@"index"]intValue];
        NSDate *solartermDate = [self.solartermDateArray objectAtIndex:i];
        NSDate *date = [NSDate stringTransToDate:[solartermDate dateTransformToString:kCalendarFormatter] withFormat:kCalendarFormatter];
        if ([searchDate1 compare:date] <= 0) {
            maxIndex = index;
            maxDate = solartermDate;
            if (i == 0) {
                NSInteger otherIndex = 23;
                NSInteger year = _year - 1;
                if (year > START_YEAR) {
                    NSDate *date1 = [self getSolartermDateWithYear:year index:otherIndex];
                    lastDate = date1;
                    lastIndex = otherIndex;
                }
            }else {
                NSDate *date1 = [self.solartermDateArray objectAtIndex:index - 1];
                lastDate = date1;
                lastIndex = index - 1;
            }
            break;
        }
        if (maxIndex == -1 && i == self.solartermArray.count - 1) {
            NSInteger otherIndex = 23;
            NSDate *date1 = [self.solartermDateArray objectAtIndex:otherIndex];
            lastDate = date1;
            lastIndex = otherIndex;
            
            maxIndex = 0;
            NSInteger year = _year + 1;
            if (year > END_YEAR) {
                maxIndex = -1;
            }else {
                maxIndex = 0;
                NSDate *date2 = [self getSolartermDateWithYear:year index:maxIndex];
                maxDate = date2;
            }
        }
    }
    if (lastIndex >= 0) {
        NSString *name = [[self.solartermArray objectAtIndex:lastIndex] objectForKey:@"title"];
        [jieArr setObject:@{@"title":name,@"date":lastDate} forKey:@"first"];
    }
    if (maxIndex >= 0) {
        NSString *name = [[self.solartermArray objectAtIndex:maxIndex] objectForKey:@"title"];
        [jieArr setObject:@{@"title":name,@"date":maxDate} forKey:@"last"];
    }
    return jieArr;
}

#pragma mark -基本数据
- (NSDictionary *)getDictWithPlist:(NSString *)name {
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"plist"]];
}
//获取初几
- (NSString *)chineseDayString {
    if (_chineseDay > 0) {
        return self.chineseDays[_chineseDay - 1];
    }
    return nil;
}
//获取中国的农历日  初1修改成日子
- (NSString *)calendarChineseString {
    if (_chineseDay != 1) {
        return [self chineseDayString];
    }
    return [self chineseMonthString];
}
//获取中国月份名字
- (NSString *)chineseMonthString {
    if (_chineseMonth > 0) {
        NSString *monthString = [_chinessFormatter stringFromDate:_searchDate];
        if ([_chinessCalendar.veryShortMonthSymbols containsObject:monthString]) {
            return self.chineseMonths[_chineseMonth - 1];
        }
        // Leap month
        monthString = [NSString stringWithFormat:@"闰%@", self.chineseMonths[_chineseMonth - 1]];
        return monthString;
    }
    return nil;
}
//生肖
- (NSString *)zodiacString {
    NSInteger year = [self getEarthlyBranches];
    if (year >= 0) {
       return self.zodiacs[year];
    }
    return nil;
}
- (NSString *)tgdzString {
    if (!_tgdzString) {
        _tgdzString = NSStringFormat(@"%@%@",[self.heavenlyStems objectAtIndex:[self getHeavenlyStems]],[self.earthlyBranches objectAtIndex:[self getEarthlyBranches]]);
    }
    return _tgdzString;
}
#pragma mark - 数据的初始化
- (void)setSearchDate:(NSDate *)searchDate {
    [[NSDate date]dateTransformToString:@"HH:mm"];
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute;
    NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:searchDate];
    NSDateComponents *currentComp = [_localeCalendar components:unitFlags fromDate:[NSDate date]];
    localeComp.hour = currentComp.hour;
    localeComp.minute = currentComp.minute;
    
    _searchDate = [_localeCalendar dateFromComponents:localeComp];;
    if (localeComp.year != _year || localeComp.month != _month || localeComp.day != _day ) {
        NSDateComponents *comps = [_chinessCalendar components:unitFlags fromDate:_searchDate];
        _chinesSYear = comps.year;
        
        _chineseDay = comps.day;
        _chineseMonth = comps.month;
        _weekString = [searchDate getWeekDate];
        if (_year != localeComp.year) {
            _springStartDate = nil;
        }
        _year = localeComp.year;
        _month = localeComp.month;
        _day = localeComp.day;
//        _chineseYear = [self getCurrentChinessYear];
    }
    _monthDiZhi = -1;
    _tgdzString = nil;
    _dtgdzString = nil;
    
}
- (NSInteger)monthDiZhi {
    if (_monthDiZhi == -1) {
        _monthDiZhi = [self mouthZhiIndex];
    }
    return _monthDiZhi;
}
- (NSDate *)springStartDate {
    if (!_springStartDate) {
        _springStartDate = [NSDate stringTransToDate:[[self getSolartermDateWithYear:_year index:2] dateTransformToString:@"yyyy-MM-dd HH:mm"] withFormat:@"yyyy-MM-dd HH:mm"];
    }
    return _springStartDate;
}
- (NSArray *)solartermArray {
    if (!_solartermArray) {
        _solartermArray = [[NSArray arrayWithPlist:@"twenty-fourSolarTerms"]sortedArrayUsingComparator:^NSComparisonResult(NSDictionary *obj1, NSDictionary *obj2) {
            NSInteger number1 = [[obj1 objectForKey:@"index"] integerValue];
            NSInteger number2 = [[obj2 objectForKey:@"index"] integerValue];
            return number1 > number2;
        }];
    }
    return _solartermArray;
}
- (NSArray *)zodiacs {
    if (!_zodiacs) {
        _zodiacs = [NSArray arrayWithPlist:@"zodiacs"];
    }
    return _zodiacs;
}
- (NSArray *)chineseDays {
    if (_chineseDays == nil) {
        _chineseDays = [NSArray arrayWithPlist:@"chineseDay"];
    }
    return _chineseDays;
}
- (NSArray *)chineseMonths {
    if (_chineseMonths == nil) {
        _chineseMonths = [NSArray arrayWithPlist:@"chineseMonth"];
    }
    return _chineseMonths;
}
- (NSDictionary *)chineseHoliDay{
    if (!_chineseHoliDay) {
        _chineseHoliDay = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"chineseHoliDay" ofType:@"plist"]];
    }
    return _chineseHoliDay;
}
- (NSDictionary *)lunDic{
    if (!_lunDic) {
        //阳历节日
        _lunDic = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"publicHoliDay" ofType:@"plist"]];;
    }
    return _lunDic;
}
- (NSArray *)heavenlyStems {
    if (_heavenlyStems == nil) {
        _heavenlyStems = [NSArray arrayWithPlist:@"heavenlyStems"];
    }
    return _heavenlyStems;
}
- (NSArray *)earthlyBranches {
    if (_earthlyBranches == nil) {
        _earthlyBranches = [NSArray arrayWithPlist:@"earthlyBranches"];
    }
    return _earthlyBranches;
}

//计算星座
-(NSString *)getXingzuo {
    NSString *retStr=@"";
    NSInteger i_month = _month;
    NSInteger i_day = _day;
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
                retStr=@"水瓶座";
            }
            if(i_day>=1 && i_day<=19){
                retStr=@"摩羯座";
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                retStr=@"水瓶座";
            }
            if(i_day>=19 && i_day<=31){
                retStr=@"双鱼座";
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                retStr=@"双鱼座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"白羊座";
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                retStr=@"白羊座";
            }
            if(i_day>=20 && i_day<=31){
                retStr=@"金牛座";
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
                retStr=@"金牛座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"双子座";
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                retStr=@"双子座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"巨蟹座";
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                retStr=@"巨蟹座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"狮子座";
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                retStr=@"狮子座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"处女座";
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                retStr=@"处女座";
            }
            if(i_day>=23 && i_day<=31){
                retStr=@"天秤座";
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                retStr=@"天秤座";
            }
            if(i_day>=24 && i_day<=31){
                retStr=@"天蝎座";
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                retStr=@"天蝎座";
            }
            if(i_day>=22 && i_day<=31){
                retStr=@"射手座";
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                retStr=@"射手座";
            }
            if(i_day>=21 && i_day<=31){
                retStr=@"摩羯座";
            }
            break;
    }
    return retStr;
}
@end
