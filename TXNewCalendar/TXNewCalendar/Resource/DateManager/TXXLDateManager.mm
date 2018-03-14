//
//  TXXLDateManager.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLDateManager.h"
#import "SynthesizeSingleton.h"
#import "SolarDate.h"
#import "ChineseDate.h"
#import "ChineseCalendarDB.h"
#import "TXXLDBManager.h"
static const CGFloat kSpringStartCoefficient = 0.2422;
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
        NSString *chinessString = NSStringFormat(@"%ld-%ld",comps.month,comps.day);
        if ([self.chineseHoliDay.allKeys containsObject:chinessString]) {
            
            NSString *title = [self.chineseHoliDay objectForKey:chinessString];
            [array addObject:@{@"title":title,@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
        }else {
            
            NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:date];
            NSString *dataString = NSStringFormat(@"%ld-%ld",localeComp.month,localeComp.day);
            if ([self.lunDic.allKeys containsObject:dataString]) {
                NSString *title = [self.lunDic objectForKey:dataString];
                [array addObject:@{@"title":title,@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
            }else {
                //母亲节
                localeComp.month = 5;
                localeComp.day = 1;
                
                NSInteger week_now =   [[_localeCalendar dateFromComponents:localeComp] getWeekIndex]-1;
                NSString *motherDayStr = [NSString stringWithFormat:@"5-%ld", week_now == 0 ? 8 : 15 -week_now];
                if ([motherDayStr isEqualToString:dataString]) {
                    [array addObject:@{@"title":@"母亲节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                }else {
                    //父亲节
                    localeComp.month = 6;
                    NSInteger week_now2 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
                    NSString *fatherDayStr = [NSString stringWithFormat:@"6-%ld", week_now2 == 0 ? 1 : 22 -week_now2];
                    if ([fatherDayStr isEqualToString:dataString]) {
                        [array addObject:@{@"title":@"父亲节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                    }else {
                        //感恩节
                        localeComp.month = 11;
                        NSInteger week_now3 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
                        NSInteger thanksgivingDayDay = (4 >= week_now3) ? ((4 - week_now3) + 22) : (28 - (week_now3 - 5));
                        NSString *thanksgivingDayStr = [NSString stringWithFormat:@"11-%ld",thanksgivingDayDay];
                        if ([thanksgivingDayStr isEqualToString:dataString]) {
                            [array addObject:@{@"title":@"感恩节",@"date":[date dateTransformToString:@"yyyy年MM月dd日"],@"week":[date getWeekDate],@"day":@(i)}];
                        }
                    }
                }
            }
        }
        if (array.count == 5 && isFive) {
            break;
        }
    }
    return array;
}
//获取日期节日
- (NSString *)getHasHolidayString {
    NSString *chinessString = NSStringFormat(@"%ld-%ld",_chineseMonth,_chineseDay);
    if ([self.chineseHoliDay.allKeys containsObject:chinessString]) {
        return [self.chineseHoliDay objectForKey:chinessString];
    }
    NSString *dataString = NSStringFormat(@"%ld-%ld",_month,_day);
    if ([self.lunDic.allKeys containsObject:dataString]) {
        return [self.lunDic objectForKey:dataString];
    }
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:_searchDate];
    //母亲节
    localeComp.month = 5;
    localeComp.day = 1;
    NSInteger week_now = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex]-1;
    NSString *motherDayStr = [NSString stringWithFormat:@"5-%ld", week_now == 0 ? 8 : 15 -week_now];
    if ([motherDayStr isEqualToString:dataString]) {
        return @"母亲节";
    }else {
        //父亲节
        localeComp.month = 6;
        NSInteger week_now2 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
        NSString *fatherDayStr = [NSString stringWithFormat:@"6-%ld", week_now2 == 0 ? 1 : 22 -week_now2];
        if ([fatherDayStr isEqualToString:dataString]) {
            return @"父亲节";
        }else {
            //感恩节
            localeComp.month = 11;
            NSInteger week_now3 = [[_localeCalendar dateFromComponents:localeComp] getWeekIndex] - 1;
            NSInteger thanksgivingDayDay = (4 >= week_now3) ? ((4 - week_now3) + 22) : (28 - (week_now3 - 5));
            NSString *thanksgivingDayStr = [NSString stringWithFormat:@"11-%ld",thanksgivingDayDay];
            if ([thanksgivingDayStr isEqualToString:dataString]) {
                return @"感恩节";
              }
            }
        }
    return [self solartermFromDate:_searchDate];
}
- (NSInteger)getSpringChineseYear {
    if ([_searchDate compare:self.springStartDate] < 0) {
        if (_chineseYear == _year) {
            return (_chineseYear - 1);
        }else if (_chineseMonth == 12) {
            return (_chineseYear + 1);
        }
    }
    return _chineseYear;
}
- (NSInteger)getCurrentChinessYear {
     // 参考日期：农历2000年1月1日就是公元2000年2月5日
    SolarDate solarDate=SolarDate(_year, _month, _day);
    ChineseDate chineseDate;
    //从公历对象转为农历对象
    solarDate.ToChineseDate(chineseDate);
    return chineseDate.GetYear();
}
//获取立春公历
- (NSDate *)getSpringStart {
    CGFloat yearCoefficient = 0;
    NSInteger lastYear = 0;
    if (_year < 1901 || _year > 2201) {
        return nil;
    }
    if (_year >= 1901 && _year<=2000) {
        lastYear = _year - 1900;
        yearCoefficient = 4.6295;
    }else if (_year >= 2001 && _year <= 2100) {
        lastYear = _year - 2000;
        yearCoefficient = 3.87;
    }else {
        lastYear = _year - 2100;
        yearCoefficient = 4.15;
    }
    //闰年数= 年数后2位 - 1 的差  除以4.0
    CGFloat  leapYearCount = (lastYear - 1) / 4;
    //年数后2位 * 固定系数 + 世纪系数 - 润年数
    CGFloat yearFloat = (lastYear * kSpringStartCoefficient + yearCoefficient);
    NSInteger yearCount = floor(yearFloat);
    NSInteger day = yearCount - leapYearCount;
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.year = _year;
    components.month = 2;
    components.day = day;
    NSDate * date = [_localeCalendar dateFromComponents:components];
    return date;
}
- (void)getSolartermDateListWithYear:(NSInteger)year {
    for (int i = 0; i < 24; i++) {
        if (i == 0) {
            <#statements#>
        }
    }
}
#pragma mark 节气
- (NSString *)solartermFromDate:(NSDate *)date {
    NSInteger array_index = (_year - START_YEAR) * 12 + _month - 1;
    int64_t flag = gLunarHolDay[array_index];
    
    int64_t day = _day < 15 ? (15 - ((flag>>4)&0x0f)) : (day = ((flag)&0x0f) + 15);
    
    NSInteger index = -1;
    if(_day == day) {
        index = (_month - 1) * 2 + (_day > 15 ? 1: 0);
    }
    if (index >= 0  && index < [self.solartermArray count]) {
        NSDictionary *dict = [self.solartermArray objectAtIndex:index];
        return [dict objectForKey:@"title"];
    } else {
        return nil;
    }
}
#pragma mark -获取天干地支 年柱
- (NSInteger)getHeavenlyStems {
    NSInteger index = (_year - 3) % 10 - 1;
    if ([_searchDate compare:self.springStartDate] < 0) {
        index -= 1;
    }
    return index;
}
- (NSInteger)getEarthlyBranches {
    NSInteger index = (_year - 3) % 12 - 1;
    if ([_searchDate compare:self.springStartDate] < 0) {
        index -= 1;
    }
    return index;
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
    NSInteger mouth_zhi_index = [self mouthZhiIndex];
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
- (NSDate *)getSolartermDate:(int)year index:(int)index {
    int day= ChineseCalendarDB::GetSolarTerm(year, index);
    div_t dt = div(index, 2);
    int month = dt.rem+dt.quot;
    NSDateComponents * components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate * date = [_localeCalendar dateFromComponents:components];
    return date;
}
- (NSInteger)mouthZhiIndex{
    NSMutableArray * jieArr = [NSMutableArray array];
    for (int i = 0; i < self.solartermArray.count; i++) {
        NSDictionary *dict = [self.solartermArray objectAtIndex:i];
        int index = [[dict objectForKey:@"index"]intValue];
        NSDate *date = [self getSolartermDate:_year index:index + 1];
        [jieArr addObject:date];
    }
    int index = 0;
    NSDate *searchDate1 = [NSDate stringTransToDate:[_searchDate dateTransformToString:@"YYYY-MM-DD"] withFormat:@"YYYY-MM-DD"];
    for (int i  = 0;i < jieArr.count ;i++ ) {
        NSDate *date = jieArr[i];
        NSComparisonResult res = [searchDate1 compare:date];
        if (res == NSOrderedAscending) {
            break;
        }else{
            index++;
        }
    }
    NSInteger zhi_id = (index+1)/2;
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
    return ganzhi_Arr[gan_index];
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
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < hour.count; i++) {
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        NSDictionary *hourDetail = [hour objectAtIndex:i];
        NSString *hourName = [hourDetail objectForKey:@"name"];
        NSString *tiangan = [self getLunarTianganHour:hourName];
        NSString *hourGZ = NSStringFormat(@"%@%@",tiangan,hourName);
        [dict setObject:hourGZ forKey:@"hour"];
        [dict setObject:[hourDetail objectForKey:@"time"] forKey:@"time"];
        NSDictionary *houryiji = [yijiDict objectForKey:dgz];
        if (houryiji == nil) {
            houryiji = [yijiDict objectForKey:@"甲子"];
        }
        NSDictionary *shiyiji = [houryiji objectForKey:hourName];
        [dict addEntriesFromDictionary:shiyiji];
        NSString *state = [jiString rangeOfString:hourName].location != NSNotFound ? @"吉":@"凶";
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
    NSInteger monthDzindex = [self mouthZhiIndex];
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
    NSInteger monthDzindex = [self mouthZhiIndex] + 1;
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
            NSInteger yue = [self mouthZhiIndex] + 1;
            if ([yueArray containsObject:@(yue)]) {
                NSArray *gzArray = [dict objectForKey:@(yue)];
                if ([gzArray containsObject:gz]) {
                    [array addObject:@{@"nlmonthday":NSStringFormat(@"%@%@",[self chineseMonthString],[self chineseDayString]),@"nlYeargz":[self tgdzString],@"nlMonthgz":[self getGanzhiMouth],@"nlDaygz":[self getGanzhiDay],@"shengxiao":[self zodiacString],@"zhishen":[self getZhiShen],@"jianchu":[self getJianChu],@"xingxiu":[[self getXingSu] objectAtIndex:0],@"count":@(i),@"date":[date dateTransformToString:kCalendarFormatter],@"week":[date getWeekDate]}];
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
    int lastIndex = -1;
    NSDate *maxDate = nil;
    int maxIndex = -1;
    NSDate *searchDate1 = [NSDate stringTransToDate:[_searchDate dateTransformToString:kCalendarFormatter] withFormat:kCalendarFormatter];
    for (int i = 0; i < self.solartermArray.count; i++) {
        NSDictionary *dict = [self.solartermArray objectAtIndex:i];
        int index = [[dict objectForKey:@"index"]intValue];
        NSDate *date = [self getSolartermDate:_year index:index + 1];
        if ([searchDate1 compare:date] <= 0) {
            maxIndex = index;
            maxDate = date;
            if (i == 0) {
                int otherIndex = 23;
                int year = _year - 1;
                if (year > START_YEAR) {
                    NSDate *date1 = [self getSolartermDate:year index:otherIndex + 1];
                    lastDate = date1;
                    lastIndex = otherIndex;
                }
            }else {
                NSDate *date1 = [self getSolartermDate:_year index:index];
                lastDate = date1;
                lastIndex = index - 1;
            }
            break;
        }
        if (maxIndex == -1 && i == self.solartermArray.count - 1) {
            int otherIndex = 23;
            NSDate *date1 = [self getSolartermDate:_year index:otherIndex + 1];
            lastDate = date1;
            lastIndex = otherIndex;
            
            int maxIndex = 0;
            int year = _year + 1;
            if (year > END_YEAR) {
                maxIndex = -1;
            }else {
                NSDate *date2 = [self getSolartermDate:year index:maxIndex + 1];
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
    return NSStringFormat(@"%@%@",[self.heavenlyStems objectAtIndex:[self getHeavenlyStems]],[self.earthlyBranches objectAtIndex:[self getEarthlyBranches]]);
}
#pragma mark - 数据的初始化
- (void)setSearchDate:(NSDate *)searchDate {
    unsigned unitFlags = NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay;
    NSDateComponents *localeComp = [_localeCalendar components:unitFlags fromDate:searchDate];
    if (localeComp.year != _year || localeComp.month != _month || localeComp.day != _day ) {
        _searchDate = searchDate;
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
        _chineseYear = [self getCurrentChinessYear];
    }
    
}
- (NSDate *)springStartDate {
    if (!_springStartDate) {
        _springStartDate = [self getSpringStart];
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
const  int START_YEAR =1901;
const  int END_YEAR   =2050;
static int32_t gLunarHolDay[]=
{
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1901
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1902
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1903
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //1904
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1905
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1906
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1907
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1908
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1909
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1910
    0X96, 0XA5, 0X87, 0X96, 0X87, 0X87, 0X79, 0X69, 0X69, 0X69, 0X78, 0X78,   //1911
    0X86, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1912
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1913
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1914
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1915
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1916
    0X95, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1917
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77,   //1918
    0X96, 0XA5, 0X97, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1919
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1920
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1921
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X77,   //1922
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X69, 0X69, 0X78, 0X78,   //1923
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1924
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X87,   //1925
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1926
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1927
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1928
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1929
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1930
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X87, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1931
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1932
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1933
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1934
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1935
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1936
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1937
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1938
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1939
    0X96, 0XA5, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1940
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1941
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1942
    0X96, 0XA4, 0X96, 0X96, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1943
    0X96, 0XA5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1944
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1945
    0X95, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1946
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1947
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1948
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X79, 0X77, 0X87,   //1949
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1950
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X79, 0X79, 0X79, 0X69, 0X78, 0X78,   //1951
    0X96, 0XA5, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1952
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1953
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X68, 0X78, 0X87,   //1954
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1955
    0X96, 0XA5, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1956
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1957
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1958
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1959
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1960
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1961
    0X96, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1962
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1963
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1964
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1965
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1966
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1967
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1968
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1969
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1970
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X79, 0X69, 0X78, 0X77,   //1971
    0X96, 0XA4, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1972
    0XA5, 0XB5, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1973
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1974
    0X96, 0XB4, 0X96, 0XA6, 0X97, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1975
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X89, 0X88, 0X78, 0X87, 0X87,   //1976
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1977
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //1978
    0X96, 0XB4, 0X96, 0XA6, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1979
    0X96, 0XA4, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1980
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X77, 0X87,   //1981
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1982
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X78, 0X79, 0X78, 0X69, 0X78, 0X77,   //1983
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //1984
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //1985
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1986
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X79, 0X78, 0X69, 0X78, 0X87,   //1987
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1988
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1989
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //1990
    0X95, 0XB4, 0X96, 0XA5, 0X86, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1991
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1992
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1993
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1994
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X76, 0X78, 0X69, 0X78, 0X87,   //1995
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //1996
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //1997
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //1998
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //1999
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2000
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2001
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2002
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //2003
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2004
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2005
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2006
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X69, 0X78, 0X87,   //2007
    0X96, 0XB4, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2008
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2009
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2010
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X78, 0X87,   //2011
    0X96, 0XB4, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2012
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2013
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2014
    0X95, 0XB4, 0X96, 0XA5, 0X96, 0X97, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2015
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2016
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2017
    0XA5, 0XB4, 0XA6, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2018
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2019
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86,   //2020
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2021
    0XA5, 0XB4, 0XA5, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2022
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X79, 0X77, 0X87,   //2023
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2024
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2025
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2026
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2027
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2028
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2029
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2030
    0XA5, 0XB4, 0X96, 0XA5, 0X96, 0X96, 0X88, 0X78, 0X78, 0X78, 0X87, 0X87,   //2031
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2032
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X86,   //2033
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X78, 0X88, 0X78, 0X87, 0X87,   //2034
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2035
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2036
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X86,   //2037
    0XA5, 0XB3, 0XA5, 0XA5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2038
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2039
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X96,   //2040
    0XA5, 0XC3, 0XA5, 0XB5, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2041
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X88, 0X88, 0X88, 0X78, 0X87, 0X87,   //2042
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2043
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X88, 0X87, 0X96,   //2044
    0XA5, 0XC3, 0XA5, 0XB4, 0XA5, 0XA6, 0X87, 0X88, 0X87, 0X78, 0X87, 0X86,   //2045
    0XA5, 0XB3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X88, 0X78, 0X87, 0X87,   //2046
    0XA5, 0XB4, 0X96, 0XA5, 0XA6, 0X96, 0X88, 0X88, 0X78, 0X78, 0X87, 0X87,   //2047
    0X95, 0XB4, 0XA5, 0XB4, 0XA5, 0XA5, 0X97, 0X87, 0X87, 0X88, 0X86, 0X96,   //2048
    0XA4, 0XC3, 0XA5, 0XA5, 0XA5, 0XA6, 0X97, 0X87, 0X87, 0X78, 0X87, 0X86,   //2049
    0XA5, 0XC3, 0XA5, 0XB5, 0XA6, 0XA6, 0X87, 0X88, 0X78, 0X78, 0X87, 0X87    //2050
};
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
