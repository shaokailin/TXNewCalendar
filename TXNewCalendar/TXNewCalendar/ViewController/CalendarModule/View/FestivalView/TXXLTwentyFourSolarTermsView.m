//
//  TXXLTwentyFourSolarTermsView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLTwentyFourSolarTermsView.h"
@interface TXXLTwentyFourSolarTermsView ()<UITableViewDelegate, UITableViewDataSource>

@end
@implementation TXXLTwentyFourSolarTermsView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
}

@end
