//
//  TXSMNewNavigationTitleView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/15.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMNewNavigationTitleView.h"

@implementation TXSMNewNavigationTitleView
{
    UILabel *_titleLbl;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupXingZuoName:(NSString *)name {
    _titleLbl.text = name;
}
- (void)_layoutMainView {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickChange)];
    [self addGestureRecognizer:tap];
    
    UILabel *lbl = [TXXLViewManager customTitleLbl:nil font:kNavigationTitle_Font];
    lbl.frame = CGRectMake(30, 15, 70, 20);
    _titleLbl = lbl;
    [self addSubview:lbl];
    UIImageView *arrawImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrowdown_icon")];
    arrawImg.frame = CGRectMake(105, 21, 15, 9);
    [self addSubview:arrawImg];
}
- (void)clickChange {
    if (self.clickBlock) {
        self.clickBlock(YES);
    }
}
@end
