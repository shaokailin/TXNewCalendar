//
//  TXBZSMHappyManager.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/4/28.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMHappyManager.h"
#import "TXXLDateManager.h"
#import "SynthesizeSingleton.h"
@implementation TXBZSMHappyManager
SYNTHESIZE_SINGLETON_CLASS(TXBZSMHappyManager);
- (NSDictionary *)getFiveXingData {
    NSDictionary *_calenT = [NSDictionary dictionaryWithPlist:@"tianganshuzhi"];
    NSDictionary *_calenD = [NSDictionary dictionaryWithPlist:@"dizhishuzhi"];
    //喜用神藏干表
    NSDictionary *hideData = @{ @"子" : @"癸",@"丑" : @"癸辛己", @"寅" : @"丙甲",@"卯" : @"乙",@"辰" : @"乙癸戊", @"巳" : @"庚丙", @"午" : @"丁", @"未" : @"丁乙己",@"申" : @"壬庚", @"酉" : @"辛", @"戌" : @"辛丁戊",@"亥" : @"甲壬"};
    //五行属性
    NSDictionary *wuxing = @{@"甲" : @"木", @"乙" : @"木", @"丙" : @"火", @"丁" : @"火", @"戊" : @"土", @"己" : @"土", @"庚" : @"金", @"辛" : @"金", @"壬" : @"水", @"癸" : @"水"};
    NSString *yGZ = [TXXLDateManager sharedInstance].tgdzString;
    NSString *mGZ = [[TXXLDateManager sharedInstance]getGanzhiMouth];
    NSString *dGZ = [[TXXLDateManager sharedInstance]getGanzhiDay];
    NSString *hGZ = [[TXXLDateManager sharedInstance]getHourTianGanDizhi];
    //4天干
    NSArray *resultT = @[[yGZ substringToIndex:1], [mGZ substringToIndex:1], [dGZ substringToIndex:1], [hGZ substringToIndex:1]];
    //地支天干
    NSString *ydz = [yGZ substringFromIndex:1];
    NSString *mdz = [mGZ substringFromIndex:1];
    NSString *ddz = [dGZ substringFromIndex:1];
    NSString *hdz = [hGZ substringFromIndex:1];
    
    NSDictionary *resultD = @{ydz:[hideData objectForKey:ydz],
                              mdz:[hideData objectForKey:mdz],
                              ddz:[hideData objectForKey:ddz],
                              hdz:[hideData objectForKey:hdz]};
    NSMutableDictionary *numbers = [NSMutableDictionary dictionaryWithObjectsAndKeys:@(0),@"金",@(0),@"木",@(0),@"水",@(0),@"火",@(0),@"土", nil];
    for (NSString *tg in resultT) {
        NSString *key = [wuxing objectForKey:tg];
        CGFloat wuxingValue = [[numbers objectForKey:key]floatValue];
        wuxingValue += [[_calenT objectForKey:NSStringFormat(@"%@%@",mdz,tg)]floatValue];
        [numbers setObject:@(wuxingValue) forKey:key];
    }
    for (NSString *key in resultD.allKeys) {
        NSString *value = [resultD objectForKey:key];
        NSString *temp =nil;
        for(int i = 0; i < [value length]; i++) {
            temp = [value substringWithRange:NSMakeRange(i,1)];
            if ([[[_calenD objectForKey:mdz]objectForKey:key]objectForKey:NSStringFormat(@"%@%@",temp,mdz)]) {
                NSString *key1 = [wuxing objectForKey:temp];
                CGFloat wuxingValue = [[numbers objectForKey:key1]floatValue];
                wuxingValue += [[[[_calenD objectForKey:mdz]objectForKey:key]objectForKey:NSStringFormat(@"%@%@",temp,mdz)]floatValue ];
                [numbers setObject:@(wuxingValue) forKey:key1];
            }
        }
    }
    return numbers;
}
//获取喜用神
-(NSString *)getHappyGod:(NSDate *)date {
    [TXXLDateManager sharedInstance].searchDate = date;
    NSDictionary *likeGodNum = [self getFiveXingData];
    NSString *likeGod = @"";
    NSDictionary *temp = @{
             @"金" : @[@[@"土"], @[@"水", @"火", @"木"]],
             @"木" : @[@[@"水"], @[@"金", @"火", @"土"]],
             @"水" : @[@[@"金"], @[@"火", @"木", @"土"]],
             @"火" : @[@[@"木"], @[@"土", @"水", @"金"]],
             @"土" : @[@[@"火"], @[@"水", @"木", @"金"]]
             };
    //日干支
    NSString *dgz = [[TXXLDateManager sharedInstance]getGanzhiDay];
    //五行属性
    NSDictionary *wuxing = [NSDictionary dictionaryWithPlist:@"wuxingShuxing"];
    NSString *likeGodDay = [wuxing objectForKey:[dgz substringToIndex:1]];
    
    CGFloat feng1 = [[likeGodNum objectForKey:likeGodDay] floatValue] + [[likeGodNum objectForKey:[temp objectForKey:likeGodDay][0][0]]floatValue];
    
    CGFloat feng2 = [[likeGodNum objectForKey:[temp objectForKey:likeGodDay][1][0]]floatValue] + [[likeGodNum objectForKey:[temp objectForKey:likeGodDay][1][1]]floatValue] + [[likeGodNum objectForKey:[temp objectForKey:likeGodDay][1][2]]floatValue];
    //异类
    NSMutableDictionary *unKing = [NSMutableDictionary dictionary];
    CGFloat mimFloat = -1;
    NSString *minKey;
    for (NSString *key in [[temp objectForKey:likeGodDay]objectAtIndex:1]) {
        CGFloat value = [[likeGodNum objectForKey:key]floatValue];
        if (mimFloat == -1) {
            mimFloat = value;
            minKey = key;
        }else {
            if (value < mimFloat) {
                mimFloat = value;
                minKey = key;
            }
        }
        [unKing setObject:@(value) forKey:key];
    }
    
    CGFloat differ = feng1 - feng2;
    if (differ > 0.1 || differ == 0.1) {
        likeGod = minKey;
    } else if (differ >= 0) {
        likeGod = likeGodDay;
    } else {
        likeGod = [[likeGodNum objectForKey:likeGodDay]floatValue] <= [[likeGodNum objectForKey:[temp objectForKey:likeGodDay][0][0]] floatValue]? likeGodDay:[temp objectForKey:likeGodDay][0][0];
    }
    return likeGod;
}
- (NSString *)getXysDetail:(NSString *)xys {
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"xiyongshenResult"];
    return [dict objectForKey:xys];
}

//获取八卦
- (void)getGossipMessage:(NSDate *)date isBoy:(BOOL)isBoy {
    [TXXLDateManager sharedInstance].searchDate = date;
    NSArray *positionArray = [NSArray arrayWithObjects:@"离",@"坎",@"坤",@"震",@"巽",@{@(1):@"坤",@(0):@"艮"},@"乾",@"兑",@"艮",@"离", nil];
    NSInteger year = 1954;
    NSInteger thousand = year / 1000;
    year = year % 1000;
    NSInteger hundred = year / 100;
    year = year % 100;
    NSInteger ten = year / 10;
    NSInteger yushu = year % 10;
    
    NSInteger count = thousand + hundred + ten + yushu;
    NSInteger minggua = -1;
    if (isBoy) {
        if (count <= 9) {
            minggua = 11 - count;
        }else if (count > 9){
            NSInteger ten1 = count / 10;
            NSInteger yushu1 = count % 10;
            NSInteger count1 = ten1 + yushu1;
            minggua = 11 - count1;
        }
        if (minggua > 9) {
            minggua -= 9;
        }
    }else {
        if (count <= 9) {
            count += 4;
            if (count > 9) {
                minggua = count - 9;
            }else {
                minggua = count;
            }
        }else {
            NSInteger ten1 = count / 10;
            NSInteger yushu1 = count % 10;
            NSInteger count1 = ten1 + yushu1 + 4;
            if (count1 > 9) {
                minggua = count1 - 9 ;
            }else {
                minggua = count1;
            }
        }
    }
    NSString *position = nil;
    if (minggua != 5) {
        position = [positionArray objectAtIndex:minggua];
    }else {
        position = [[positionArray objectAtIndex:5]objectForKey:@(isBoy)];
    }
    
    NSLog(@"%@",position);
}
- (NSDictionary *)getXtzyDgz:(NSString *)dgz {
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"xiantianzongyun"];
    NSDictionary *data = [dict objectForKey:dgz];
    return data;
}
- (NSDictionary *)getXtLoveDgz:(NSString *)dgz {
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"ganqingyunshi"];
    NSDictionary *data = [dict objectForKey:dgz];
    return data;
}
- (NSDictionary *)getXtFortuneDgz:(NSString *)dgz {
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"caifuyunshi"];
    NSDictionary *data = [dict objectForKey:dgz];
    return data;
}
- (NSDictionary *)getXtWorkDgz:(NSString *)dgz {
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"shiyeyunshi"];
    NSDictionary *data = [dict objectForKey:dgz];
    return data;
}

- (NSDictionary *)getMoneyAndLovePosition:(NSDate *)date {
    TXXLDateManager *manager = [TXXLDateManager sharedInstance];
    manager.searchDate = date;
    NSString *dgz = [[manager getGanzhiDay]substringToIndex:1];
    NSDictionary *position = [NSDictionary dictionaryWithPlist:@"moenyLovePosition"];
    NSDictionary *dict = [position objectForKey:dgz];
    NSDictionary *loveDetail = [NSDictionary dictionaryWithPlist:@"lovePosity"];
    NSDictionary *moneyDetail = [NSDictionary dictionaryWithPlist:@"moneyPosition"];
    NSString *moneyKey = [dict objectForKey:@"money"];
    NSString *loveKey = [dict objectForKey:@"love"];
    return @{@"money":@{@"title":moneyKey,@"detail":[moneyDetail objectForKey:moneyKey]},@"love":@{@"title":loveKey,@"detail":[loveDetail objectForKey:loveKey]}};
}
- (NSDictionary *)getLuckColor:(NSDate *)date bitrhDay:(NSDate *)birthday {
    TXXLDateManager *manager = [TXXLDateManager sharedInstance];
    manager.birthdayDate = birthday;
    NSString *dgz = [[manager getGanzhiDay]substringToIndex:1];
    NSDictionary *colorResult = [NSDictionary dictionaryWithPlist:@"jixiangseResult"];
    NSArray *array = [colorResult objectForKey:dgz];
    NSString *value = [array objectAtIndex:[[date dateTransformToString:@"dd"]integerValue]];
    NSDictionary *detailDict = [NSDictionary dictionaryWithPlist:@"jixiangse"];
    NSString *detail = [detailDict objectForKey:value];
    return @{@"title":value,@"detail":detail};
}
@end
