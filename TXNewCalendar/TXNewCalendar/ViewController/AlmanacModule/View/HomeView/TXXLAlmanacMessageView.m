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
- (void)setupContentMessage {
    [self.left5View setupMessage:NSStringFormat(@"%@日",[KDateManager getJianChu])];
    [self.left1View setupMessage:[KDateManager getZhiShen]];
    [self.left2View setupMessage:nil bottom:[KDateManager getNayinWithDay]];
    [self.right5View setupMessage:[[KDateManager getXingSu] objectAtIndex:0]];
    [self.middle6View setupMessage:[[KDateManager getTaiShen] objectAtIndex:0]];
    NSArray *pengzu = [KDateManager getPengZuMessage];
    [self.right2View setupMessage:[pengzu objectAtIndex:0] bottom:[pengzu objectAtIndex:1]];
    [self.right1View setupMessage:[KDateManager getXiangChong]];
    NSDictionary *position = [KDateManager getCompassMessage];
    [self.compassView setupContentWithMoney:[position objectForKey:@"cai_shen"] happy:[position objectForKey:@"xi_shen"] luck:[position objectForKey:@"fu_shen"] live:[position objectForKey:@"sheng"]];
    [self.middle5View setupMessage:[KDateManager getHomeLuckyShengxiao]];
    NSDictionary *dict = [KDateManager getTgdzYiJiXiongJi];
    [self.left3View setupMessage:[[dict objectForKey:@"xiong"]stringByReplacingOccurrencesOfString:@"、" withString:@"  "]];
    [self.right3View setupMessage:[[dict objectForKey:@"jishen"]stringByReplacingOccurrencesOfString:@"、" withString:@"  "]];
    [self.left4View setupLblType4Content:[[dict objectForKey:@"yi"]stringByReplacingOccurrencesOfString:@"、" withString:@"  "]];
    [self.right4View setupLblType4Content:[[dict objectForKey:@"ji"]stringByReplacingOccurrencesOfString:@"、" withString:@"  "]];
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
}
//罗盘旋转角度
- (void)compassTranform:(CGFloat)radius {
    [self.compassView compassTranform:radius];
}
- (void)compassDetailClick {
    if (self.clickBlock) {
        self.clickBlock(MessageEventType_Compass,0);
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
    left1View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:4];
    };
    right1View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:3];
    };
    left2View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:5];
    };
    left3View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:7];
    };
    left4View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:0];
    };
    left5View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:10];
    };
    right2View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:9];
    };
    right3View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:6];
    };
    right4View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:1];
    };
    right5View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:11];
    };
    middle5View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:2];
    };
    middle6View.detailBlock = ^(BOOL isShow) {
        [ws detailClick:8];
    };
}
- (void)detailClick:(NSInteger)type {
    if (self.clickBlock) {
        self.clickBlock(MessageEventType_Detail,type);
    }
}
@end
