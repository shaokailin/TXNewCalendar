//
//  TXBZSMAnalysisDetailView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMAnalysisDetailView.h"

@implementation TXBZSMAnalysisDetailView
{
    UILabel *_storeLbl;
    UILabel *_remarkLbl;
    UILabel *_contentLbl;
    CGFloat _contentHeight;
    NSInteger _type;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSDictionary *)dict {
    _storeLbl.text = NSStringFormat(@"先天总运：%@分",[dict objectForKey:@"store"]);
    _remarkLbl.text = NSStringFormat(@"   %@   ",[dict objectForKey:@"remark"]);
    NSString *content = [dict objectForKey:@"content"];
    _contentLbl.text = content;
    CGFloat height = [content calculateTextHeight:12 width:SCREEN_WIDTH - 20 - 10] + 3;
    _contentHeight = 31 + kLineView_Height + 43 + 10 + height;
}
- (CGFloat)returnMessageView {
    return _contentHeight;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    KViewRadius(self, 5.0);
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:[self returnTitleString] font:14 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:1 backgroundColor:nil];
    titleLbl.font = FontBoldInit(14);
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self);
        make.centerX.equalTo(self);
        make.height.mas_equalTo(31);
    }];
    UIView *lineView = [LSKViewFactory initializeLineView];
    [self addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(titleLbl.mas_bottom);
        make.height.mas_equalTo(kLineView_Height);
    }];
    
    _storeLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x2222222, 1.0) textAlignment:0 backgroundColor:nil];
    [self addSubview:_storeLbl];
    [_storeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.top.equalTo(lineView.mas_bottom);
        make.height.mas_equalTo(43);
    }];
    
    _remarkLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:KColorHexadecimal(0x21a7e4, 1.0)];
    KViewBoundsRadius(_remarkLbl, 8);
    [self addSubview:_remarkLbl];
    [_remarkLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).with.offset(-12);
        make.centerY.equalTo(self->_storeLbl);
    }];
    
    _contentLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:KColorHexadecimal(0x222222, 1.0) textAlignment:0 backgroundColor:nil];
    _contentLbl.numberOfLines = 0;
    [self addSubview:_contentLbl];
    [_contentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(10);
        make.right.equalTo(self).with.offset(-10);
        make.top.equalTo(self->_storeLbl.mas_bottom);
    }];
}
- (NSString *)returnTitleString {
    NSString *title = nil;
    switch (_type) {
        case 0:
            title = @"先天总运";
            break;
        case 1:
            title = @"先天爱情";
            break;
        case 2:
            title = @"先天财运";
            break;
        case 3:
            title = @"先天事业";
            break;
            
        default:
            break;
    }
    return title;
}
@end
