//
//  NSDictionary+Extend.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/4/28.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "NSDictionary+Extend.h"

@implementation NSDictionary (Extend)
#pragma mark -基本数据
+ (NSDictionary *)dictionaryWithPlist:(NSString *)name {
    return [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:name ofType:@"plist"]];
}
@end
