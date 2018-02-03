//
//  TXXLCalculateMaxButton.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateMaxButton.h"
#import "UIImageView+WebCache.h"
@implementation TXXLCalculateMaxButton
{
    UIImageView *_bgImageView;
    UILabel *_titleLbl;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithImage:(NSString *)image title:(NSString *)title {
    if (KJudgeIsNullData(image)) {
        [_bgImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        _bgImageView.image = nil;
    }
    _titleLbl.text = title;
}
- (void)_layoutMainView {
    KViewBoundsRadius(self, 4.0);
    _bgImageView = [[UIImageView alloc]init];
    _bgImageView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bgImageView];
    WS(ws)
    [_bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    _titleLbl = [LSKViewFactory initializeLableWithText:nil font:10 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    _titleLbl.numberOfLines = 3;
    [self addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(9);
        make.right.equalTo(ws).with.offset(-7);
        make.width.mas_equalTo(WIDTH_RACE_6S(150 / 2.0 - 15));
    }];
}
@end
