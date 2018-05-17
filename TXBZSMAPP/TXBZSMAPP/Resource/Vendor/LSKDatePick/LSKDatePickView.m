//
//  LSKDatePickView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/16.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "LSKDatePickView.h"
@interface LSKDatePickView()
{
    CGFloat _tabHeight;
}
@end
@implementation LSKDatePickView
- (instancetype)initWithFrame:(CGRect)frame tabHeight:(CGFloat)height {
    if (self = [super initWithFrame:frame]) {
        _tabHeight = height;
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _tabHeight = 0;
    }
    return self;
}
- (instancetype)init {
    if (self = [super init]) {
        _tabHeight = 0;
    }
    return self;
}
@end
