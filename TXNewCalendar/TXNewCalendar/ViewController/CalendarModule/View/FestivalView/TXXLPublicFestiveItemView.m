//
//  TXXLPublicFestiveItemView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLPublicFestiveItemView.h"
@interface TXXLPublicFestiveItemView ()
@property (nonatomic, weak) UILabel *timeLbl;
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UILabel *weekLbl;
@property (nonatomic, weak) UILabel *hasCountLbl;
@end
@implementation TXXLPublicFestiveItemView
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithDate:(NSDate *)date title:(NSString *)title hasCount:(NSString *)hasCount {
    self.titleLbl.text = title;
    self.hasCountLbl.text = hasCount;
    self.timeLbl.text = [date dateTransformToString:@"yyyy年MM月dd日"];
    self.weekLbl.text = [date getWeekDate];
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *bgImageView = [[UIImageView alloc]initWithImage:ImageNameInit(@"public_bg")];
    [self addSubview:bgImageView];
    WS(ws)
    [bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];
    UILabel *timeLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:nil];
    self.timeLbl = timeLbl;
    [self addSubview:timeLbl];
    [timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(ws);
        make.height.mas_equalTo(20);
    }];
    
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:17];
    self.titleLbl = titleLbl;
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(timeLbl.mas_bottom).with.offset(5);
    }];
    
    UILabel *weekLbl = [TXXLViewManager customTitleLbl:nil font:12];
    self.weekLbl = weekLbl;
    [self addSubview:weekLbl];
    [weekLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(3);
    }];
    
    UILabel *hasCountLbl = [TXXLViewManager customTitleLbl:nil font:12];
    self.hasCountLbl = hasCountLbl;
    [self addSubview:hasCountLbl];
    [hasCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(ws);
        make.top.equalTo(weekLbl.mas_bottom).with.offset(3);
    }];
    UIButton *addTimeBtn = [LSKViewFactory initializeButtonNornalImage:@"addTime" selectedImage:nil target:self action:@selector(addTimeClick)];
    [self addSubview:addTimeBtn];
    [addTimeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-7);
        make.bottom.equalTo(ws).with.offset(-7);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
}
- (void)addTimeClick {
    if (self.itemBlock) {
        self.itemBlock(YES);
    }
}
@end
