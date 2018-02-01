//
//  TXXLAlimanacMessageView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacMessageView.h"
#import "TXXLAlimanacHomeLbl1View.h"
#import "TXXLAlimanacHomeLbl2View.h"
#import "TXXLAlimanacHomeLbl3View.h"
#import "TXXLAlimanacHomeLbl4View.h"
#import "TXXLAlimanacHomeLbl5View.h"
#import "TXXLCompassView.h"
@interface TXXLAlmanacMessageView ()
@property (nonatomic, weak) TXXLAlimanacHomeLbl1View *left1View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl1View *right1View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl2View *left2View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl2View *right2View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl3View *left3View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl3View *right3View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl4View *left4View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl4View *right4View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl5View *left5View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl5View *middle5View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl5View *middle6View;
@property (nonatomic, weak) TXXLAlimanacHomeLbl5View *right5View;
@property (nonatomic, weak) TXXLCompassView *compassView;
@end
@implementation TXXLAlmanacMessageView
- (instancetype)init {
    if (self = [super init]) {
        self.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
        [self _layoutMainView];
        [self setupDefaultContent];
    }
    return self;
}
#pragma mark - 设置数据
- (void)setupCompassMessage:(id)model {
    
}
- (void)setupPeripheralsMessage:(TXXLAlmanacHomeModel *)model {
    if ([model.zhi_shen isKindOfClass:[NSDictionary class]]) {
        [self.left1View setupMessage:[model.zhi_shen objectForKey:@"shen_sha"]];
    }
    if ([model.chong_sha isKindOfClass:[NSDictionary class]]) {
        [self.right1View setupMessage:NSStringFormat(@"冲%@煞%@",[model.chong_sha objectForKey:@"chong"],[model.chong_sha objectForKey:@"sha"])];
    }
    if (KJudgeIsArrayAndHasValue(model.na_yin)) {
        [self.left2View setupMessage:nil bottom:[model.na_yin objectAtIndex:0]];
    }
    if (KJudgeIsArrayAndHasValue(model.peng_zu)) {
        NSArray *contentArray = [model.peng_zu objectAtIndex:0];
        if (KJudgeIsArrayAndHasValue(contentArray)) {
            NSString *top = contentArray.count > 0?[contentArray objectAtIndex:0]:nil;
            NSString *bottom = contentArray.count > 1? [contentArray objectAtIndex:1]:nil;
            [self.right2View setupMessage:top bottom:bottom];
        }
    }
    if ([model.xiong isKindOfClass:[NSDictionary class]] && model.xiong.allKeys.count > 0) {
        NSMutableString *xiong = [NSMutableString string];
        NSInteger count = model.xiong.allKeys.count;
        for (int i = 0; i < count; i ++) {
            NSString *key = [model.xiong.allKeys objectAtIndex:i];
            [xiong appendString:key];
            if (i != count - 1 ) {
                [xiong appendString:@"  "];
            }
        }
        [self.left3View setupMessage:xiong];
    }
    if ([model.jishen isKindOfClass:[NSDictionary class]] && model.jishen.allKeys.count > 0) {
        NSMutableString *jishen = [NSMutableString string];
        NSInteger count = model.jishen.allKeys.count;
        for (int i = 0; i < count; i ++) {
            NSString *key = [model.jishen.allKeys objectAtIndex:i];
            [jishen appendString:key];
            if (i != count - 1 ) {
                [jishen appendString:@"  "];
            }
        }
        [self.right3View setupMessage:jishen];
    }
    if ([model.yi isKindOfClass:[NSDictionary class]] && model.yi.allKeys.count > 0) {
        NSMutableString *yi = [NSMutableString string];
        NSInteger count = model.yi.allKeys.count;
        for (int i = 0; i < count; i ++) {
            NSString *key = [model.yi.allKeys objectAtIndex:i];
            [yi appendString:key];
            if (i != count - 1 ) {
                [yi appendString:@"  "];
            }
        }
        [self.left4View setupLblType4Content:yi];
    }
    if ([model.ji isKindOfClass:[NSDictionary class]] && model.ji.allKeys.count > 0) {
        NSMutableString *ji = [NSMutableString string];
        NSInteger count = model.ji.allKeys.count;
        for (int i = 0; i < count; i ++) {
            NSString *key = [model.ji.allKeys objectAtIndex:i];
            [ji appendString:key];
            if (i != count - 1 ) {
                [ji appendString:@"  "];
            }
        }
        [self.right4View setupLblType4Content:ji];
    }
    if (KJudgeIsArrayAndHasValue(model.jian_chu)) {
        [self.left5View setupMessage:NSStringFormat(@"%@日",[model.jian_chu objectAtIndex:0])];
    }
    if ([model.lucky isKindOfClass:[NSDictionary class]]) {
        [self.middle5View setupMessage:[model.lucky objectForKey:@"shengxiao"]];
    }
    if (KJudgeIsArrayAndHasValue(model.tai_shen)) {
        [self.middle6View setupMessage:[model.tai_shen objectAtIndex:0]];
    }
    if (KJudgeIsArrayAndHasValue(model.xing_su)) {
        [self.right5View setupMessage:[model.xing_su objectAtIndex:0]];
    }
    
}
- (void)setupNilContent {
    [self.left1View setupMessage:@"  "];
    [self.right1View setupMessage:@"  "];
    [self.left2View setupMessage:nil bottom:@"  "];
    [self.right2View setupMessage:@"  " bottom:@"  "];
    [self.left3View setupMessage:nil];
    [self.right3View setupMessage:nil];
    [self.left4View setupLblType4Content:@"  "];
    [self.right4View setupLblType4Content:@"  "];
    [self.left5View setupMessage:nil];
    [self.middle5View setupMessage:nil];
    [self.middle6View setupMessage:nil];
    [self.right5View setupMessage:nil];
    [self.compassView setupContentWithMoney:@"  " happy:@"  " luck:@"  " live:@"  "];
}
- (void)setupDefaultContent {
    [self.left1View setupLblType1Content:@"值神"];
    [self.right1View setupLblType1Content:@"冲煞"];
    [self.left2View setupLblType2Content:@"五行"];
     [self.right2View setupLblType2Content:@"彭祖百忌"];
    [self.left3View setupLblType3Content:@"凶神宜忌"];
    [self.right3View setupLblType3Content:@"吉神宜趋"];
    [self.left5View setupLblType5Content:@"建除十二神"];
    [self.middle5View setupLblType5Content:@"幸运生肖"];
    [self.middle6View setupLblType5Content:@"今日胎神"];
    [self.right5View setupLblType5Content:@"二十八星宿"];
    [self setupNilContent];
}
//罗盘旋转角度
- (void)compassTranform:(CGFloat)radius {
    [self.compassView compassTranform:radius];
}
- (void)compassDetailClick {
    if (self.clickBlock) {
        self.clickBlock(MessageEventType_Compass);
    }
}
- (void)_layoutMainView {
    CGFloat centerWidth = 173;
    WS(ws)
    TXXLCompassView *compassView = [[TXXLCompassView alloc]init];
    self.compassView = compassView;
    [self addSubview:compassView];
    [compassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws);
        make.bottom.equalTo(ws.mas_bottom).with.offset(-58);
        make.centerX.equalTo(ws).with.offset(-1);
        make.width.mas_equalTo(centerWidth);
    }];
    UITapGestureRecognizer *compassTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(compassDetailClick)];
    [compassView addGestureRecognizer:compassTap];

    TXXLAlimanacHomeLbl1View *left1View = [[TXXLAlimanacHomeLbl1View alloc]init];
    self.left1View = left1View;
    [self addSubview:left1View];
    [left1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(ws);
        make.right.equalTo(compassView.mas_left).with.offset(-1);
        make.height.mas_equalTo(46);
    }];
    
    TXXLAlimanacHomeLbl1View *right1View = [[TXXLAlimanacHomeLbl1View alloc]init];
    self.right1View = right1View;
    [self addSubview:right1View];
    [right1View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws);
        make.left.equalTo(compassView.mas_right).with.offset(1);
        make.height.top.equalTo(left1View);
    }];
    
    TXXLAlimanacHomeLbl2View *left2View = [[TXXLAlimanacHomeLbl2View alloc]init];
    self.left2View = left2View;
    [self addSubview:left2View];
    [left2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(left1View);
        make.top.equalTo(left1View.mas_bottom).with.offset(1);
        make.height.mas_equalTo(55);
    }];
    TXXLAlimanacHomeLbl2View *right2View = [[TXXLAlimanacHomeLbl2View alloc]init];
    self.right2View = right2View;
    [self addSubview:right2View];
    [right2View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(right1View);
        make.height.top.equalTo(left2View);
        
    }];
    TXXLAlimanacHomeLbl3View *left3View = [[TXXLAlimanacHomeLbl3View alloc]init];
    self.left3View = left3View;
    [self addSubview:left3View];
    [left3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(left1View);
        make.top.equalTo(left2View.mas_bottom).with.offset(1);
        make.height.mas_equalTo(71);
    }];
    TXXLAlimanacHomeLbl3View *right3View = [[TXXLAlimanacHomeLbl3View alloc]init];
    self.right3View = right3View;
    [self addSubview:right3View];
    [right3View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(right1View);
        make.height.top.equalTo(left3View);
        
    }];
    
    TXXLAlimanacHomeLbl4View *left4View = [[TXXLAlimanacHomeLbl4View alloc]initWithType:ContentType_Fit];
    self.left4View = left4View;
    [self addSubview:left4View];
    [left4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(left1View);
        make.top.equalTo(left3View.mas_bottom).with.offset(1);
        make.height.mas_equalTo(44);
    }];
    TXXLAlimanacHomeLbl4View *right4View = [[TXXLAlimanacHomeLbl4View alloc]initWithType:ContentType_Avoid];
    self.right4View = right4View;
    [self addSubview:right4View];
    [right4View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(right1View);
        make.height.top.equalTo(left4View);
    }];
    
    TXXLAlimanacHomeLbl5View *left5View = [[TXXLAlimanacHomeLbl5View alloc]init];
    self.left5View = left5View;
    [self addSubview:left5View];
    [left5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(left1View);
        make.top.equalTo(left4View.mas_bottom).with.offset(1);
        make.height.mas_equalTo(57);
    }];
    TXXLAlimanacHomeLbl5View *right5View = [[TXXLAlimanacHomeLbl5View alloc]init];
    self.right5View = right5View;
    [self addSubview:right5View];
    [right5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(right1View);
        make.height.top.equalTo(left5View);
    }];

    TXXLAlimanacHomeLbl5View *middle5View = [[TXXLAlimanacHomeLbl5View alloc]init];
    self.middle5View = middle5View;
    [self addSubview:middle5View];
    [middle5View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(compassView.mas_left);
        make.top.equalTo(compassView.mas_bottom).with.offset(1);
        make.height.equalTo(left5View);
        make.right.equalTo(compassView.mas_centerX).with.offset(-0.5);
    }];
    TXXLAlimanacHomeLbl5View *middle6View = [[TXXLAlimanacHomeLbl5View alloc]init];
    self.middle6View = middle6View;
    [self addSubview:middle6View];
    [middle6View mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(middle5View.mas_right).with.offset(1);
        make.top.height.width.equalTo(middle5View);
    }];
}
@end
