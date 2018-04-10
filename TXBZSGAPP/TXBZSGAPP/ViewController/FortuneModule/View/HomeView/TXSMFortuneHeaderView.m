//
//  TXSMFortuneHeaderView.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/15.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHeaderView.h"
#import "TXSMFortuneMessageView.h"
#import "TXSMFortuneMessageDetailView.h"
@interface TXSMFortuneHeaderView ()
{
    NSInteger _currentIndex;
    CGFloat _topMessageHeight;
    NSDictionary *_dataDict;
    CGFloat _topHeight;
}
@property (nonatomic, weak) TXSMFortuneMessageView *messageView;
@property (nonatomic, weak) TXSMFortuneMessageDetailView *detailView;

@end
@implementation TXSMFortuneHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (UIImage *)getMessageViewImage {
    [self.messageView exchangeIsHiden:YES];
    UIGraphicsBeginImageContextWithOptions(self.messageView.bounds.size, NO, 0.0); //currentView 当前的view  创建一个基于位图的图形上下文并指定大小为
    [self.messageView.layer renderInContext:UIGraphicsGetCurrentContext()];//renderInContext呈现接受者及其子范围到指定的上下文
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();//返回一个基于当前图形上下文的图片
    UIGraphicsEndImageContext();
    [self.messageView exchangeIsHiden:NO];
    return viewImage;
}
- (void)setupContent:(NSDictionary *)dict messageDict:(NSDictionary *)message {
    _dataDict = dict;
    [self.messageView setupContentWithDetail:message];
    CGFloat height = [self.messageView returnCurrentHeight];
    self.messageView.frame = CGRectMake(10, _topHeight, SCREEN_WIDTH - 20, height);
    _topMessageHeight = _topHeight + height + 5;
    CGRect frame = self.detailView.frame;
    frame.origin.y = _topMessageHeight;
    self.detailView.frame = frame;
    [self.detailView setupContent:dict];
}
- (void)changeMessageInfo {
    NSString *key = [TXSMFortuneMessageDetailView returnDataKey:_currentIndex];
    if (key) {
        NSDictionary *dict = [_dataDict objectForKey:key];
        [self.messageView setupLuckyColor:[dict objectForKey:@"color"] number:[dict objectForKey:@"number"] xingzuo:[dict objectForKey:@"constellation"]];
    }
}
- (void)frameChange:(CGFloat)height {
    if (self.frameBlock) {
        self.frameBlock(height + _topMessageHeight);
    }
}
- (void)changeSelect:(NSInteger)index {
    if (index < 4) {
        _currentIndex = index;
        [self changeMessageInfo];
    }else {
        if (self.jumpBlock) {
            self.jumpBlock(YES);
        }
    }
}

- (void)_layoutMainView {
    _topHeight = SCREEN_WIDTH * 227 / 750 - 35 - 10;
}
- (TXSMFortuneMessageView *)messageView {
    if (!_messageView) {
        TXSMFortuneMessageView *messageView = [[TXSMFortuneMessageView alloc]initWithFrame:CGRectMake(10, _topHeight, SCREEN_WIDTH - 20, 0)];
        _messageView = messageView;
        [self addSubview:messageView];
    }
    return _messageView;
}
- (TXSMFortuneMessageDetailView *)detailView {
    if (!_detailView) {
        TXSMFortuneMessageDetailView *detailView = [[TXSMFortuneMessageDetailView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        _detailView = detailView;
        WS(ws)
        detailView.frameBlock = ^(CGFloat height) {
            [ws frameChange:height];
        };
        detailView.selectBlock = ^(NSInteger currentIndex) {
            [ws changeSelect:currentIndex];
        };
        [self addSubview:detailView];
    }
    return _detailView;
}
@end
