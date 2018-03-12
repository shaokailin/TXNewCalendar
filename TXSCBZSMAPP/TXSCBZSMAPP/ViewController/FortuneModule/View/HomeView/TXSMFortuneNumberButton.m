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
    NSInteger _type;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super init]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:ImageNameInit([self returnImageName])];
    [self addSubview:bgImageView];
    WS(ws)
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:[self returnTitle] font:11 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.mas_centerY).with.offset(4);
        make.centerX.equalTo(ws);
    }];
    
    UILabel *presentLbl = [LSKViewFactory initializeLableWithText:nil font:11 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    self.presentValueLbl = presentLbl;
    [self addSubview:presentLbl];
    [presentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_centerY).with.offset(-4);
        make.centerX.equalTo(ws);
    }];
}
- (NSString *)returnImageName {
    NSString *image = nil;
    switch (_type) {
        case 0:
            image = @"feeling_bg";
            break;
        case 1:
            image = @"career_bg";
            break;
        case 2:
            image = @"headlth_bg";
            break;
        case 3:
            image = @"money_bg";
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
            title = @"爱情指数";
            break;
        case 1:
            title = @"事业指数";
            break;
        case 2:
            title = @"健康指数";
            break;
        case 3:
            title = @"财富指数";
            break;
            
        default:
            break;
    }
    return title;
}
@end
