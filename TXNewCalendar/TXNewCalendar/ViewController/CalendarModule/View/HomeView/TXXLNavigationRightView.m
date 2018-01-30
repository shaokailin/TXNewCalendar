//
//  TXXLNavigationRightView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLNavigationRightView.h"

@implementation TXXLNavigationRightView
{
    UILabel *_dateDetailLbl;
    UILabel *_dateTimeLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)changeTextWithDate:(NSDate *)date {
    _dateDetailLbl.text = NSStringFormat(@"%@%@年%@%@",[date getChinessYearString],[date getZodiac],[date getChineseMonthString],[date getChineseDayString]);
    _dateTimeLbl.text = [date dateTransformToString:@"yyyy.MM.dd"];
}
- (void)_layoutMainView {
    _dateDetailLbl = [LSKViewFactory initializeLableWithText:nil font:9 textColor:[UIColor whiteColor] textAlignment:2 backgroundColor:nil];
    _dateDetailLbl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 12 - 10, CGRectGetWidth(self.frame), 12);
    [self addSubview:_dateDetailLbl];
    UIImageView *arrowImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"calendar_arrowdown")];
    arrowImageView.frame = CGRectMake(CGRectGetWidth(self.frame) - 12, CGRectGetHeight(self.frame) - 12 - 10 - 4 - 7, 12, 7);
    [self addSubview:arrowImageView];
    _dateTimeLbl = [LSKViewFactory initializeLableWithText:nil font:9 textColor:[UIColor whiteColor] textAlignment:2 backgroundColor:nil];
    _dateTimeLbl.frame = CGRectMake(0, CGRectGetHeight(self.frame) - 12 - 10 - 4 - 12 + 3, CGRectGetWidth(self.frame) - 12 - 12, 12);
    [self addSubview:_dateTimeLbl];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectTimeClick)];
    [self addGestureRecognizer:tap];
}
- (void)selectTimeClick {
    if (self.selectBlock) {
        self.selectBlock(YES);
    }
}

@end
