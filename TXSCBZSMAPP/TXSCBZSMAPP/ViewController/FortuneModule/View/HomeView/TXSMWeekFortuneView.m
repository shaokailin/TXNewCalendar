//
//  TXSMWeekFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMWeekFortuneView.h"
#import "TXSMWeekFortuneButtonView.h"
#import "TXSMWeekFortuneMessageView.h"
@interface TXSMWeekFortuneView ()
{
    NSInteger _type;
    NSDictionary *_dataDict;
}
@property (nonatomic, weak) TXSMWeekFortuneMessageView *messageView;
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
    return 335 + WIDTH_RACE_6S(55) + 5 + 1 + 1 + 80;
}
- (void)setupContent:(NSString *)name dict:(NSDictionary *)dict {
    _dataDict = dict;
    NSString * time = nil;
    if (_type == 0) {
        time = NSStringFormat(@"%@  -  %@",[dict objectForKey:@"start_time"],[dict objectForKey:@"end_time"]);
    }else {
        time = [dict objectForKey:@"time"];
    }
    [self.messageView setupContentWithImg:nil name:name time:time];
    [self.messageView setupContentWithScore:[dict objectForKey:@"score"]];
}
- (void)buttonClick:(NSInteger)flag {
    NSString *title = nil;
    switch (flag) {
        case 0:
            title = [_dataDict objectForKey:@"love"];
            break;
        case 1:
            title = [_dataDict objectForKey:@"work"];
            break;
        case 2:
            title = [_dataDict objectForKey:@"apply_job"];
            break;
        case 3:
            title = [_dataDict objectForKey:@"fortune"];
            break;
        case 4:
            title = [_dataDict objectForKey:@"health"];
            break;
            
        default:
            break;
    }
}
- (void)_layoutMainView {
    CGFloat height = 335 + WIDTH_RACE_6S(55);
    TXSMWeekFortuneMessageView *messageView = [[TXSMWeekFortuneMessageView alloc]initWithType:_type];
    messageView.frame = CGRectMake(5, 5, SCREEN_WIDTH - 10, height);
    self.messageView = messageView;
    [self addSubview:messageView];
    
    TXSMWeekFortuneButtonView *buttonBtn = [[TXSMWeekFortuneButtonView alloc]initWithFrame:CGRectMake(5, height + 5 + 1, SCREEN_WIDTH - 10, 80)];
    WS(ws)
    buttonBtn.clickBlock = ^(NSInteger flag) {
        [ws buttonClick:flag];
    };
    [self addSubview:buttonBtn];
}
@end
