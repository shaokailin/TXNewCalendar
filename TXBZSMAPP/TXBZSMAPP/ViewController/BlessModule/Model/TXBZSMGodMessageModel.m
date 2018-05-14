//
//  TXBZSMGodMessageModel.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodMessageModel.h"

@implementation TXBZSMGodMessageModel
- (void)setGodDate:(NSString *)godDate {
    _godDate = godDate;
    if (KJudgeIsNullData(godDate)) {
        NSDate *current = [NSDate getTodayDate];
        NSDate *godDate1 = [NSDate stringTransToDate:godDate withFormat:nil];
        NSTimeInterval time = [godDate1 timeIntervalSinceDate:current];
        self.hasCount = ceil(time / (3600 * 24));
    }else {
        self.hasCount = 0;
    }
}
@end
