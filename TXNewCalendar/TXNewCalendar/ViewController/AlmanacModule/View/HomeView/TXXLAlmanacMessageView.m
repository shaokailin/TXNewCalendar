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
- (void)setupDefaultContent {
    [self.left1View setupLblType1Content:@"值神" bottom:@"司命"];
    [self.right1View setupLblType1Content:@"冲煞" bottom:@"冲虎  煞南"];
    [self.left2View setupLblType2Content:@"无行" middle:nil bottom:@"大驿土"];
    [self.right2View setupLblType2Content:@"彭祖百忌" middle:@"戊不受田" bottom:@"申不安床"];
    [self.left3View setupLblType3Content:@"凶神宜忌" middle:@"大煞  复日" bottom:@"五离  勾陈"];
    [self.right3View setupLblType3Content:@"吉神宜趋" middle:@"天恩  母仓" bottom:@"三骨  临目"];
    [self.left4View setupLblType4Content:@"嫁娶  移徒\n纳采  祭祀"];
    [self.right4View setupLblType4Content:@"开市  立券"];
    [self.left5View setupLblType5Content:@"建除十二神" middle:nil bottom:@"危日"];
    [self.middle5View setupLblType5Content:@"幸运生肖" middle:@"蛇" bottom:@"龙   鼠"];
    [self.middle6View setupLblType5Content:@"今日胎神" middle:@"仓库床外" bottom:@"正东"];
    [self.right5View setupLblType5Content:@"二十八星宿" middle:nil bottom:@"南方翼火蛇"];
    [self.compassView setupContentWithMoney:@"正北" happy:@"西南" luck:@"东北" live:@"东南"];
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
