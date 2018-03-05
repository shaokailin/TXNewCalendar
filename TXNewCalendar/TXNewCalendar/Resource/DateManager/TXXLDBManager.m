//
//  TXXLDBManager.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/3/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLDBManager.h"
#import <FMDB/FMDB.h>
static NSString * const kDBName = @"almanacDB";
@interface TXXLDBManager ()
@property (strong ,nonatomic)FMDatabase *fmDB;
@end
@implementation TXXLDBManager

- (instancetype)init {
    if (self = [super init]) {
        NSString *tDbFilePath=[[NSBundle mainBundle]pathForResource:@"aaa" ofType:@"db"];
        self.fmDB = [FMDatabase databaseWithPath:tDbFilePath];
        if ([self.fmDB open]) {
            LSKLog(@"111");
        }
    }
    return self;
}
#pragma mark - 查询语句
- (NSDictionary *)selectYiJiXiongJi:(NSString *)tg month:(NSInteger)month {
    NSString *selectSQLString = [NSString stringWithFormat:@"select * from bw_huanglijixiong where gz = '%@' and yue=%ld",tg,month];
    FMResultSet *fmsr = [self.fmDB executeQuery:selectSQLString];
    if (!fmsr) {
        return nil;
    }
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    while ([fmsr next]) {
        [dict setObject:KNullTransformString([fmsr stringForColumnIndex:3]) forKey:@"jishen"];
        [dict setObject:KNullTransformString([fmsr stringForColumnIndex:4]) forKey:@"xiong"];
        [dict setObject:KNullTransformString([fmsr stringForColumnIndex:5]) forKey:@"yi"];
        [dict setObject:KNullTransformString([fmsr stringForColumnIndex:6]) forKey:@"ji"];
    }
    [fmsr close];
    return dict;
    
}

-(void)dealloc {
    [self.fmDB close];
    self.fmDB = nil;
}
@end
