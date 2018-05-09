//
//  TXBZSMTomorrowMessageView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTomorrowMessageView.h"
#import "TXBZSMTomorrowProgressView.h"
#import "TXBZSMTomorrowLuckyView.h"
#import "TXBZSMTomorrowDetailView.h"
@implementation TXBZSMTomorrowMessageView
{
    TXBZSMTomorrowProgressView *_progressView;
    TXBZSMTomorrowLuckyView *_luckyView;
    TXBZSMTomorrowDetailView *_messageView;
    NSInteger _type;
    CGFloat _contentHeight;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (CGFloat)returnViewHeight {
    return _contentHeight;
}
- (void)setupContent:(NSDictionary *)dict{
    [_progressView setupContentWithAll:[dict objectForKey:@"synthesize"] love:[dict objectForKey:@"love"] fortune:[dict objectForKey:@"fortune"] work:[dict objectForKey:@"work"]];
    CGFloat contentY = 171;
    contentY += 5;
    
    [_messageView setupContent:[dict objectForKey:@"warn"]];
    CGFloat contentHeight = [_messageView returnContentHeight];
    _messageView.frame = CGRectMake(0, contentY, SCREEN_WIDTH - 10, contentHeight);
    contentY += (contentHeight + 5);
    
    [_luckyView refreshData];
    contentHeight = [_luckyView returnContentHeight];
    _luckyView.frame = CGRectMake(0, contentY, SCREEN_WIDTH - 10, contentHeight);
    contentY += contentHeight;
    _contentHeight = contentY;
    CGRect frame = self.frame;
    frame.size.height = _contentHeight;
    self.frame = frame;
}
- (void)_layoutMainView {
    _contentHeight = 0;
    _progressView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMTomorrowProgressView" owner:self options:nil]lastObject];
    KViewBoundsRadius(_progressView, 5.0);
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(171);
    }];
    _messageView = [[TXBZSMTomorrowDetailView alloc]initWithType:_type];
    KViewRadius(_messageView, 5.0);
    [self addSubview:_messageView];
    CGFloat contentY = 171;
    contentY += 5;
    CGFloat contentHeight = [_messageView returnContentHeight];
    _messageView.frame = CGRectMake(0, contentY, SCREEN_WIDTH - 10, contentHeight);
    contentY += (contentHeight + 5);
    _luckyView = [[TXBZSMTomorrowLuckyView alloc]initWithType:_type];
    KViewRadius(_luckyView, 5.0);
    contentHeight = [_luckyView returnContentHeight];
    _luckyView.frame = CGRectMake(0, contentY, SCREEN_WIDTH - 10, contentHeight);
    [self addSubview:_luckyView];
}

@end
