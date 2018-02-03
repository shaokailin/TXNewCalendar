//
//  TXXLHolidaysTableViewCell.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHolidaysTableViewCell.h"

@implementation TXXLHolidaysTableViewCell
{
    UILabel *_titleLbl;
    UILabel *_timeLbl;
    UILabel *_hasCountLbl;
    UILabel *_monthDayLbl;
    UILabel *_weekLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContent:(NSString *)title monthDay:(NSString *)monthDay date:(NSString *)chinessDate week:(NSString *)week hasCount:(NSString *)hasCount {
    _titleLbl.text = title;
    _timeLbl.text = chinessDate;
    _weekLbl.text = week;
    _monthDayLbl.text = monthDay;
    _hasCountLbl.text = hasCount;
}
- (void)_layoutMainView {
    self.selectionStyle = 0;
    self.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    self.contentView.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    UIView *conView = [[UIView alloc]init];
    conView.backgroundColor = [UIColor whiteColor];
    KViewRadius(conView, 4.0);
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"timebgImage")];
    [conView addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView).with.offset(11);
        make.centerY.equalTo(conView);
        make.size.mas_equalTo(CGSizeMake(38, 33));
    }];
    
    UILabel *monthDayLbl = [LSKViewFactory initializeLableWithText:nil font:6 textColor:KColorHexadecimal(kText_Green_Color, 1.0) textAlignment:1 backgroundColor:nil];
    _monthDayLbl = monthDayLbl;
    [conView addSubview:monthDayLbl];
    [monthDayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage).with.offset(5);
        make.right.equalTo(bgImage).with.offset(-5);
        make.top.equalTo(bgImage).with.offset(5);
    }];
    
    UILabel *weekLbl = [TXXLViewManager customTitleLbl:nil font:11];
    weekLbl.textAlignment = 1;
    _weekLbl = weekLbl;
    [conView addSubview:weekLbl];
    [weekLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(monthDayLbl);
        make.bottom.equalTo(bgImage).with.offset(-4);
    }];
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:12];
    [conView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage.mas_right).with.offset(5);
        make.top.equalTo(conView).with.offset(10);
    }];
    _timeLbl = [TXXLViewManager customDetailLbl:nil font:12];
    [conView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgImage.mas_right).with.offset(5);
        make.bottom.equalTo(conView).with.offset(-11);
    }];
    _hasCountLbl = [TXXLViewManager customTitleLbl:nil font:12];
    _hasCountLbl.textColor = KColorHexadecimal(kText_Green_Color, 1.0);
    [conView addSubview:_hasCountLbl];
    [_hasCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView.mas_right).with.offset(-47);
        make.centerY.equalTo(conView);
    }];
    
    [self.contentView addSubview:conView];
    WS(ws)
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 10, 7, 10));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
