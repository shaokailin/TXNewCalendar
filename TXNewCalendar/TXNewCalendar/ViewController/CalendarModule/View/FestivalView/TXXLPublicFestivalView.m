//
//  TXXLPublicFestivalView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLPublicFestivalView.h"
#import "TXXLPublicFestiveItemView.h"
@interface TXXLPublicFestivalView ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation TXXLPublicFestivalView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    TXXLPublicFestiveItemView *itemView = [[TXXLPublicFestiveItemView alloc]init];
    [itemView setupContentWithDate:[NSDate date] title:@"腊八节" hasCount:@"剩余7天"];
    [self addSubview:itemView];
    WS(ws)
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws).with.offset(20);
        make.size.mas_equalTo(CGSizeMake(268 / 2.0, 190 / 2.0));
    }];
    itemView.itemBlock = ^(BOOL isClick) {
        
    };
}

@end
