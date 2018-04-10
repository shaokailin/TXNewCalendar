//
//  TXSMWeekFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneView.h"
#import "TXSMFortuneProgressView.h"
#import "TXSMWeekMessageView.h"
@interface TXSMWeekFortuneView ()
{
    CGFloat _circleHeight;
    CGFloat _contentHeight;
    NSInteger _type;
    NSDictionary *_dataDict;
    TXSMWeekMessageView *_firstView;
    TXSMWeekMessageView *_secondView;
    TXSMWeekMessageView *_thirdView;
    TXSMWeekMessageView *_fourView;
    TXSMWeekMessageView *_fiveView;
}
@property (nonatomic, weak) TXSMFortuneProgressView *progressView;
@end
@implementation TXSMWeekFortuneView
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (CGFloat)returnViewHeight {
    return _contentHeight;;
}
- (void)setupContent:(NSDictionary *)dict {
    NSString *thirdContent = nil;
    if (_type == 0) {
        thirdContent = [dict objectForKey:@"warn"];
        [self.progressView setupScore:[dict objectForKey:@"score"] time:NSStringFormat(@"%@-%@",[dict objectForKey:@"start_time"],[dict objectForKey:@"end_time"])];
    }else {
        thirdContent = [dict objectForKey:@"study"];
        [self.progressView setupScore:[dict objectForKey:@"score"] time:[dict objectForKey:@"time"]];
    }
    _contentHeight = _circleHeight + 1;
    [_firstView setupContent:[dict objectForKey:@"love"]];
    CGFloat height = [_firstView returnMessageHeight];
    _firstView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH - 20, height);
    _contentHeight += (height + 1);
    
    [_secondView setupContent:[dict objectForKey:@"work"]];
    height = [_secondView returnMessageHeight];
    _secondView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH - 20, height);
    _contentHeight += (height + 1);
    
    [_thirdView setupContent:thirdContent];
    height = [_thirdView returnMessageHeight];
    _thirdView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH - 20, height);
    _contentHeight += (height + 1);
    
    [_fourView setupContent:[dict objectForKey:@"fortune"]];
    height = [_fourView returnMessageHeight];
    _fourView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH - 20, height);
    _contentHeight += (height + 1);
    
    [_fiveView setupContent:[dict objectForKey:@"health"]];
    height = [_fiveView returnMessageHeight];
    _fiveView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH - 20, height);
    _contentHeight += height;
}


- (void)_layoutMainView {
    _circleHeight = 124;
    TXSMFortuneProgressView *pressView = [[TXSMFortuneProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, _circleHeight) progressType:ProgressType_Week];
    self.progressView = pressView;
    [self addSubview:pressView];
    
    _firstView = [[TXSMWeekMessageView alloc]initWithType:0];
    _firstView.frame = CGRectMake(0, _circleHeight + 1, SCREEN_WIDTH - 20, 0);
    [self addSubview:_firstView];
    _secondView = [[TXSMWeekMessageView alloc]initWithType:1];
    _secondView.frame = CGRectMake(0, _circleHeight + 1, SCREEN_WIDTH - 20, 0);
    [self addSubview:_secondView];
    NSInteger viewType = 2;
    if (_type == 0) {
        viewType = 5;
    }
    _thirdView = [[TXSMWeekMessageView alloc]initWithType:viewType];
    _thirdView.frame = CGRectMake(0, _circleHeight + 1, SCREEN_WIDTH - 20, 0);
    [self addSubview:_thirdView];
    _fourView = [[TXSMWeekMessageView alloc]initWithType:3];
    _fourView.frame = CGRectMake(0, _circleHeight + 1, SCREEN_WIDTH - 20, 0);
    [self addSubview:_fourView];
    _fiveView = [[TXSMWeekMessageView alloc]initWithType:4];
    _fiveView.frame = CGRectMake(0, _circleHeight + 1, SCREEN_WIDTH - 20, 0);
    [self addSubview:_fiveView];
}
@end
