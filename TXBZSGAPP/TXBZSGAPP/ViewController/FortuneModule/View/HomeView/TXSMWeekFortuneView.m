//
//  TXSMWeekFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneView.h"
#import "TXSMWeekMessageView.h"
@interface TXSMWeekFortuneView ()
{
    CGFloat _contentHeight;
    NSInteger _type;
    NSDictionary *_dataDict;
    TXSMWeekMessageView *_firstView;
    TXSMWeekMessageView *_secondView;
    TXSMWeekMessageView *_fourView;
    TXSMWeekMessageView *_fiveView;
}
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
    _contentHeight = 0;
    [_firstView setupContent:[dict objectForKey:@"love"]];
    CGFloat height = [_firstView returnMessageHeight];
    _firstView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH, height);
    _contentHeight += (height + 1);
    
    [_secondView setupContent:[dict objectForKey:@"fortune"]];
    height = [_secondView returnMessageHeight];
    _secondView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH, height);
    _contentHeight += (height + 1);
    
    [_fourView setupContent:[dict objectForKey:@"work"]];
    height = [_fourView returnMessageHeight];
    _fourView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH, height);
    _contentHeight += (height + 1);
    
    [_fiveView setupContent:[dict objectForKey:@"health"]];
    height = [_fiveView returnMessageHeight];
    _fiveView.frame = CGRectMake(0, _contentHeight, SCREEN_WIDTH, height);
    _contentHeight += height;
}


- (void)_layoutMainView {
    
    _firstView = [[TXSMWeekMessageView alloc]initWithType:0];
    _firstView.frame = CGRectMake(0,0, SCREEN_WIDTH, 0);
    [self addSubview:_firstView];
    _secondView = [[TXSMWeekMessageView alloc]initWithType:1];
    _secondView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    [self addSubview:_secondView];
    _fourView = [[TXSMWeekMessageView alloc]initWithType:2];
    _fourView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    [self addSubview:_fourView];
    _fiveView = [[TXSMWeekMessageView alloc]initWithType:3];
    _fiveView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 0);
    [self addSubview:_fiveView];
}
@end
