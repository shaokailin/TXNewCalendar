//
//  TXBZSMWishTreeModel.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishTreeModel.h"

@implementation TXBZSMWishTreeModel
- (void)encodeWithCoder:(NSCoder *)aCoder {
    for (NSString *perperty in [self perperiesWithClass:[self class]])
    {
        [aCoder encodeObject:[self valueForKey:perperty] forKey:perperty];
    }
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super init])
    {
        for (NSString *perperty in [self perperiesWithClass:[self class]])
        {
            [self setValue:[aDecoder decodeObjectForKey:perperty] forKey:perperty];;
        }
        
    }
    return self;
}
- (NSArray *)perperiesWithClass:(Class)cls {
    NSMutableArray *perperies = [NSMutableArray array];
    unsigned int outCount;
    //动态获取属性
    objc_property_t *properties = class_copyPropertyList(cls, &outCount);
    //遍历person类的所有属性
    for (int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        const char *name = property_getName(property);
        NSString *s = [[NSString alloc] initWithUTF8String:name];
        [perperies addObject:s];
    }
    return perperies;
}
@end
