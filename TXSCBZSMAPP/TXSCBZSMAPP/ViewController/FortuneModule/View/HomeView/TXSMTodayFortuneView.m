//
//  TXSMTodayFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMTodayFortuneView.h"
#import "TXSMCircleFortuneView.h"
#import "TXSMTodayFortuneDetailView.h"
@interface TXSMTodayFortuneView ()
{
    CGFloat _circleHeight;
    NSInteger _type;
}
@property (nonatomic, weak) TXSMCircleFortuneView *circleView;
@property (nonatomic, weak) TXSMTodayFortuneDetailView *detailView;
@end
@implementation TXSMTodayFortuneView

- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContent:(NSString *)content {
    [self.detailView setupContent:content];
    CGFloat height = [self.detailView returnMessageHeight];
    CGFloat contentHeight = height + _circleHeight + 7;
    CGRect frame = self.frame;
    if (CGRectGetHeight(frame) != contentHeight) {
        frame.size.height = contentHeight;
        self.frame = frame;
    }
}
- (void)setupContent:(NSString *)name dict:(NSDictionary *)dict {
    [self.circleView setupContent:dict name:name];
    [self setupCellContent:[dict objectForKey:@"warn"]];
}
- (CGFloat)returnViewHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView {
    _circleHeight = 305 + WIDTH_RACE_6S(55);
    TXSMCircleFortuneView *circleView = [[TXSMCircleFortuneView alloc]initWithType:_type];
    circleView.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, _circleHeight);
    self.circleView = circleView;
    [self addSubview:circleView];
    
    TXSMTodayFortuneDetailView *messageView = [[TXSMTodayFortuneDetailView alloc]initType:_type];
    messageView.frame = CGRectMake(5, _circleHeight + 6, SCREEN_WIDTH - 10, [messageView returnMessageHeight]);
    self.detailView = messageView;
    [self addSubview:messageView];
}
@end
