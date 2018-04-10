//
//  TXSMTodayFortuneView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMTodayFortuneView.h"
#import "TXSMFortuneProgressView.h"
#import "TXSMTodayFortuneDetailView.h"
@interface TXSMTodayFortuneView ()
{
    CGFloat _circleHeight;
    NSInteger _type;
}
@property (nonatomic, weak) TXSMFortuneProgressView *progressView;
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
    CGFloat contentHeight = height + _circleHeight;
    CGRect frame = self.frame;
    if (CGRectGetHeight(frame) != contentHeight) {
        frame.size.height = contentHeight;
        self.frame = frame;
    }
}
- (void)setupContent:(NSDictionary *)dict {
    [self.progressView setupScore:dict time:[dict objectForKey:@"time"]];
    [self setupCellContent:[dict objectForKey:@"warn"]];
}
- (CGFloat)returnViewHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView {
    _circleHeight = 124;
    TXSMFortuneProgressView *pressView = [[TXSMFortuneProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 20, _circleHeight) progressType:ProgressType_Today];
    self.progressView = pressView;
    [self addSubview:pressView];
    
    TXSMTodayFortuneDetailView *messageView = [[TXSMTodayFortuneDetailView alloc]init];
    messageView.frame = CGRectMake(0, _circleHeight - 16, SCREEN_WIDTH - 20, 0);
    self.detailView = messageView;
    [self addSubview:messageView];
}
@end
