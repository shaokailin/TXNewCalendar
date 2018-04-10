//
//  TXSMFortuneNumberButton.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneNumberButton.h"

@implementation TXSMFortuneNumberButton
{
    UILabel *_presentValueLbl;
    NSInteger _type;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContent:(NSString *)value {
    if ([value rangeOfString:@"座"].location != NSNotFound) {
        value = [value substringToIndex:value.length - 1];
    }
    _presentValueLbl.text = NSStringFormat(@"%@: %@",[self returnTitle],value);
}
- (void)_layoutMainView {
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:ImageNameInit([self returnImageName])];
    [self addSubview:bgImageView];
    WS(ws)
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    
    _presentValueLbl = [LSKViewFactory initializeLableWithText:nil font:WIDTH_RACE_6S(10) textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    [self addSubview:_presentValueLbl];
    [_presentValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws);
    }];
}
- (NSString *)returnImageName {
    NSString *image = nil;
    switch (_type) {
        case 0:
            image = @"luckycolor";
            break;
        case 1:
            image = @"luckynumber";
            break;
        case 2:
            image = @"lovebg";
            break;
        default:
            break;
    }
    return image;
}
- (NSString *)returnTitle {
    NSString *title = nil;
    switch (_type) {
        case 0:
            title = @"幸运色";
            break;
        case 1:
            title = @"幸运数字";
            break;
        case 2:
            title = @"速配星座";
            break;
            
        default:
            break;
    }
    return title;
}
@end
