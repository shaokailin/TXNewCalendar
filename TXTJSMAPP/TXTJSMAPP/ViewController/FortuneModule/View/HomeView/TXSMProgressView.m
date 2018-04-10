//
//  TXSMProgressView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMProgressView.h"

@implementation TXSMProgressView
{
    ProgressStyleType _styleType;
    UILabel *_valueLbl;
    UIProgressView *_progressView;
}
- (instancetype)initWithType:(ProgressStyleType)styleType {
    if (self = [super init]) {
        _styleType = styleType;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupValue:(CGFloat)value {
    _progressView.progress = value;
    _valueLbl.text = NSStringFormat(@"%.0f",value * 100);
}
- (void)_layoutMainView {
    
    _progressView = [[UIProgressView alloc]init];
    _progressView.progressTintColor = KColorHexadecimal(0xff48da, 1.0);
    _progressView.progressViewStyle = UIProgressViewStyleBar;
    KViewBoundsRadius(_progressView, 5);
    //表示进度条未完成的，剩余的轨迹颜色,默认是灰色
    _progressView.trackTintColor = KColorHexadecimal(0xb5207b, 1.0);
    [self addSubview:_progressView];
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.right.equalTo(self);
        make.height.mas_equalTo(10);
    }];
    
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:[self returnText] font:12];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_progressView);
        make.bottom.equalTo(self->_progressView.mas_top).with.offset(-4);
    }];
    
    _valueLbl = [TXXLViewManager customTitleLbl:nil font:13];
    [self addSubview:_valueLbl];
    [_valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(9);
        make.centerY.equalTo(titleLbl);
    }];
    
}
- (NSString *)returnText {
    NSString *text = nil;
    switch (_styleType) {
        case 0:
            text = @"综合运势:";
            break;
        case 1:
            text = @"财富指数:";
            break;
        case 2:
            text = @"爱情指数:";
            break;
        case 3:
            text = @"事业指数:";
            break;
        case 4:
            text = @"健康指数:";
            break;
        default:
            break;
    }
    return text;
}
@end
