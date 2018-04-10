//
//  TXSMTodayFortuneDetailView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMTodayFortuneDetailView.h"

@implementation TXSMTodayFortuneDetailView
{
    NSInteger _type;
    UILabel *_contentLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)content {
    _contentLbl.text = content;
    CGFloat height = 20;
    if (KJudgeIsNullData(content)) {
        CGFloat contentHeight = [content calculateTextHeight:12 width:CGRectGetWidth(self.frame) - 20];
        height += contentHeight;
        CGRect frame = self.frame;
        frame.size.height = height;
        self.frame = frame;
    }
}
- (CGFloat)returnMessageHeight {
    return CGRectGetHeight(self.frame);
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _contentLbl = [TXXLViewManager customTitleLbl:nil font:12];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self);
    }];
}


@end
