//
//  TXBZSMWeekMessageView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWeekMessageView.h"
#import "TXBZSMWeekProgressView.h"
#import "TXBZSMWeekDetailView.h"
@implementation TXBZSMWeekMessageView
{
    TXBZSMWeekProgressView *_progressView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (CGFloat)returnViewHeight {
    return CGRectGetHeight(self.frame);
}
- (void)setupContent:(NSDictionary *)dict{
    [_progressView setupScore:[dict objectForKey:@"score"]];
    CGFloat contentHeight = 210;
    CGFloat width = SCREEN_WIDTH - 10;
    for (int i = 0; i < 4; i++) {
        contentHeight += 5;
        TXBZSMWeekDetailView *detailView = [self viewWithTag:300 + i];
        if (!detailView) {
            detailView = [[TXBZSMWeekDetailView alloc]initWithType:i];
            detailView.tag = 300 + i;
            [self addSubview:detailView];
        }
        [detailView setupContent:[dict objectForKey:[self returnTitle:i]]];
        CGFloat height = [detailView returnContentHeight];
        detailView.frame = CGRectMake(0, contentHeight, width, height);
        contentHeight += height;
    }
    CGRect frame = self.frame;
    frame.size.height = contentHeight;
    self.frame = frame;
}
- (void)_layoutMainView {
    _progressView = [[TXBZSMWeekProgressView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 10, 210)];
    KViewRadius(_progressView, 5.0);
    [self addSubview:_progressView];
}
- (NSString *)returnTitle:(int)i {
    NSString *title = @"";
    switch (i) {
        case 0:
            title = @"work";
            break;
        case 1:
            title = @"love";
            break;
        case 2:
            title = @"fortune";
            break;
        case 3:
            title = @"health";
            break;
        default:
            break;
    }
    return title;
}
@end
