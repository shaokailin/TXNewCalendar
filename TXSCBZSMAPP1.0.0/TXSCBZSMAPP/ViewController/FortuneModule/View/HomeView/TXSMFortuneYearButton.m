//
//  TXSMFortuneYearButton.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/16.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneYearButton.h"

@implementation TXSMFortuneYearButton
{
    NSInteger _currentStar;
    NSInteger _type;
}
- (instancetype)initWithType:(NSInteger)type {
    if (self = [super initWithType:type]) {
        _type = type;
        [self _layoutMainView1];
    }
    return self;
}
- (void)setupYearStar:(NSInteger)star {
    if (star != _currentStar) {
        _currentStar = star;
        for (int i = 2; i <= 5; i++) {
            UIImageView *image = [self viewWithTag:i + 300];
            NSString *imageName = nil;
            if (i <= star) {
                imageName = @"star_yes_icon";
            }else {
                imageName = @"star_no_icon";
            }
            image.image = ImageNameInit(imageName);
        }
    }
}
- (void)_layoutMainView1 {
    _currentStar = 2;
    self.presentValueLbl.hidden = YES;
    UIImageView *centerImg = [[UIImageView alloc]initWithImage:nil];
    centerImg.tag = 303;
    [self addSubview:centerImg];
    WS(ws)
    [centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(ws.mas_centerY).with.offset(-4);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    UIImageView *leftImg2 = [[UIImageView alloc]initWithImage:ImageNameInit(@"star_yes_icon")];
    leftImg2.tag = 302;
    [self addSubview:leftImg2];
    [leftImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(centerImg);
        make.right.equalTo(centerImg.mas_left).with.offset(-4);
    }];
    UIImageView *leftImg1 = [[UIImageView alloc]initWithImage:ImageNameInit(@"star_yes_icon")];
    leftImg1.tag = 301;
    [self addSubview:leftImg1];
    [leftImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(centerImg);
        make.right.equalTo(leftImg2.mas_left).with.offset(-4);
    }];
    
    UIImageView *rightImg1 = [[UIImageView alloc]initWithImage:nil];
    rightImg1.tag = 304;
    [self addSubview:rightImg1];
    [rightImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(centerImg);
        make.left.equalTo(centerImg.mas_right).with.offset(4);
    }];
    
    UIImageView *rightImg2 = [[UIImageView alloc]initWithImage:nil];
    rightImg2.tag = 305;
    [self addSubview:rightImg2];
    [rightImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.width.height.equalTo(centerImg);
        make.left.equalTo(rightImg1.mas_right).with.offset(4);
    }];
}

@end
