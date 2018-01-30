//
//  TXXLHoursDetailCell.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHoursDetailCell.h"
@interface TXXLHoursDetailCell ()
@property (nonatomic, weak) UILabel *chinessTimeLbl;
@property (nonatomic, weak) UILabel *stateLbl;
@property (nonatomic, weak) UILabel *timeBetweenLbl;
@property (nonatomic, weak) UILabel *timeDetailLbl;
@property (nonatomic, weak) UILabel *suitLbl;
@property (nonatomic, weak) UILabel *avoidLbl;
@end
@implementation TXXLHoursDetailCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContent:(NSString *)chinessHour state:(NSInteger)state timeBetween:(NSString *)timeBetween timeDetail:(NSString *)timeDetail orientation:(NSString *)orientation suit:(NSString *)suit avoid:(NSString *)avoid {
    self.chinessTimeLbl.text = chinessHour;
    self.stateLbl.text = (state == 0?@"凶":@"吉");
    self.timeBetweenLbl.text = NSStringFormat(@"%@  %@",timeBetween,timeDetail);
    self.timeDetailLbl.text = orientation;
    self.suitLbl.text = suit;
    self.avoidLbl.text = avoid;
}
- (void)_layoutMainView {
    self.selectionStyle = 0;
    UIView *conView = [[UIView alloc]init];
    KViewRadius(conView, 4.0);
    KViewBorderLayer(conView, KColorHexadecimal(kLineMain_Color, 1.), 1.0);
    UILabel *chinessTimeLbl = [TXXLViewManager customTitleLbl:nil font:24];
    self.chinessTimeLbl = chinessTimeLbl;
    [conView addSubview:chinessTimeLbl];
    [chinessTimeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView).with.offset(33);
        make.top.equalTo(conView).with.offset(42);
    }];
    UILabel *stateLbl = [TXXLViewManager customTitleLbl:nil font:17];
    self.stateLbl = stateLbl;
    [conView addSubview:stateLbl];
    [stateLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(chinessTimeLbl);
        make.top.equalTo(chinessTimeLbl.mas_bottom).with.offset(5);
    }];
    
    UILabel *timeBetweenLbl = [TXXLViewManager customTitleLbl:nil font:14];
    timeBetweenLbl.adjustsFontSizeToFitWidth = YES;
    self.timeBetweenLbl = timeBetweenLbl;
    [conView addSubview:timeBetweenLbl];
    [timeBetweenLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(chinessTimeLbl.mas_right).with.offset(29);
        make.right.lessThanOrEqualTo(conView).with.offset(-10);
        make.top.equalTo(conView).with.offset(18);
    }];
    
    UILabel *timeDetailLbl = [TXXLViewManager customDetailLbl:nil font:10];
    timeDetailLbl.numberOfLines = 2;
    self.timeDetailLbl = timeDetailLbl;
    [conView addSubview:timeDetailLbl];
    [timeDetailLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeBetweenLbl);
        make.right.equalTo(conView).with.offset(-10);
        make.top.equalTo(timeBetweenLbl.mas_bottom).with.offset(5);
    }];
    
    UILabel *avoidIconLbl = [LSKViewFactory initializeLableWithText:@"忌" font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(kAPP_Main_Color, 1.0)];
    [conView addSubview:avoidIconLbl];
    [avoidIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeBetweenLbl);
        make.bottom.equalTo(conView).with.offset(-10);
        make.size.mas_equalTo(CGSizeMake(15, 17));
    }];
    
    UILabel *avoidLbl = [TXXLViewManager customTitleLbl:@"无" font:9];
    avoidLbl.numberOfLines = 2;
    self.avoidLbl = avoidLbl;
    [conView addSubview:avoidLbl];
    [avoidLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(avoidIconLbl.mas_right).with.offset(10);
        make.right.lessThanOrEqualTo(conView).with.offset(-10);
        make.centerY.equalTo(avoidIconLbl);
    }];
    
    UILabel *suitIconLbl = [LSKViewFactory initializeLableWithText:@"宜" font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(kText_LightGreen_Color, 1.0)];
    [conView addSubview:suitIconLbl];
    [suitIconLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(timeBetweenLbl);
        make.bottom.equalTo(avoidIconLbl.mas_top).with.offset(-15);
        make.size.mas_equalTo(CGSizeMake(15, 17));
    }];
    
    UILabel *suitLbl = [TXXLViewManager customTitleLbl:@"无" font:9];
    suitLbl.numberOfLines = 2;
    self.suitLbl = suitLbl;
    [conView addSubview:suitLbl];
    [suitLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(suitIconLbl.mas_right).with.offset(10);
        make.right.lessThanOrEqualTo(conView).with.offset(-10);
        make.centerY.equalTo(suitIconLbl);
    }];
    
    [self.contentView addSubview:conView];
    WS(ws)
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
