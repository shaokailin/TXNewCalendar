//
//  TXXLPublicMethod.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLPublicMethod.h"

@implementation TXXLPublicMethod
+ (NSString *)dataAppend:(NSArray *)array {
    NSMutableString *yi = [NSMutableString string];
    NSInteger count = array.count;
    for (int i = 0; i < count; i ++) {
        NSString *key = [array objectAtIndex:i];
        [yi appendString:key];
        if (i != count - 1 ) {
            [yi appendString:@"  "];
        }
    }
    return yi;
}
@end
