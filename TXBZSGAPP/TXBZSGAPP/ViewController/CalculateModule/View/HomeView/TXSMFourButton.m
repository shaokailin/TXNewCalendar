//
//  TXSMFourButton.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFourButton.h"
@implementation TXSMFourButton
{
    UIImageView *_iconImageView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _iconImageView = [[UIImageView alloc]init];
    [self addSubview:_iconImageView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self);
    }];
}
- (void)setupImg:(NSString *)img {
    if (KJudgeIsNullData(img)) {
        _iconImageView.image = ImageNameInit(img);
    }
}
@end
