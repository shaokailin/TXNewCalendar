//
//  TXXLDateManager.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/27.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLDateManager : NSObject
+ (TXXLDateManager *)sharedInstance;

@property (nonatomic, strong) NSDate *searchDate;
@property (nonatomic, strong) NSDate *birthdayDate;
@property (nonatomic, assign, readonly) NSInteger chineseYear;
@property (nonatomic, assign, readonly) NSInteger chineseMonth;
@property (nonatomic, assign, readonly) NSInteger chineseDay;
@property (nonatomic, assign, readonly) NSInteger year;
@property (nonatomic, assign, readonly) NSInteger hour;
@property (nonatomic, assign, readonly) NSInteger month;
@property (nonatomic, assign, readonly) NSInteger day;
@property (nonatomic, copy, readonly) NSString *weekString;
@property (nonatomic, copy, readonly) NSString *chineseDayString;
@property (nonatomic, copy, readonly) NSString *chineseMonthString;
@property (nonatomic, copy, readonly) NSString *zodiacString;
@property (nonatomic, copy, readonly) NSDate *springStartDate;
//年天干地支
@property (nonatomic, copy, readwrite) NSString *tgdzString;//天干地支
//天的天干地支
@property (nonatomic, copy, readwrite) NSString *dtgdzString;
//获取时辰的中国时段
- (NSString *)getHourChinese;
//小时的天干地支
- (NSString *)getHourTianGanDizhi;
//月的天干地支
- (NSString *)getGanzhiMouth;
//日天干地支
- (NSString *)getGanzhiDay;

//获取节假日
- (NSString *)getHasHolidayString;
- (NSString *)getHoliday:(NSDate *)date;
- (NSString *)solartermFromDate:(NSDate *)date;
//获取中国的农历日  初1修改成日子
- (NSString *)calendarChineseString;
//获取星座
- (NSString *)getXingzuo;

//时辰 天干地支的
- (NSArray *)getHourGanzhiAndState;
//获取时辰的详情
- (NSArray *)getHoursDetail;
//24节气时间
- (NSDate *)getSolartermDateWithYear:(NSInteger)year index:(NSInteger)index;
//建除
- (NSString *)getJianChu;
//获取 值神
- (NSString *)getZhiShen;
//纳音-五行
- (NSString *)getNayinWithDay;
//获取星宿
- (NSArray *)getXingSu;
//获取胎神
- (NSArray *)getTaiShen;
//获取彭祖
- (NSArray *)getPengZuMessage;
//获取冲煞
- (NSString *)getXiangChong;
//获取当天的宜忌
- (NSDictionary *)getTgdzYiJiXiongJi;

//获取首页的幸运生肖
- (NSString *)getHomeLuckyShengxiao;
//获取首页罗盘的方位
- (NSDictionary *)getCompassMessage;
- (NSDictionary *)getDayPosition;
//黄历现代文
- (NSDictionary *)getCurrentModernText;
//获取 节气期间
- (NSDictionary *)getBetweenSolarterm;
//获取节假日
- (NSArray *)getHolidayList:(BOOL)isFive;
//查询日期
- (NSArray *)getSearshList:(NSDate *)startDate timeBetween:(NSInteger)countDate key:(NSString *)key isWeek:(BOOL)isWeek isAvoid:(BOOL)isAvoid;
- (NSString *)getYiJiDetail:(NSString *)key;
- (void)getSolartermDateListWithYear:(NSInteger)year;
@end
