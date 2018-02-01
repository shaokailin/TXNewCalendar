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
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContent:(NSString *)title date:(NSDate *)date hasCount:(NSString *)hasCount {
    _titleLbl.text = title;
    _timeLbl.text = NSStringFormat(@"%zd年%@%@  %@",[date getChinessYear],[date getChineseMonthString],[date getChineseDayString],[date getWeekDate]);
    _hasCountLbl.text = hasCount;
}
- (void)_layoutMainView {
    self.selectionStyle = 0;
    self.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    self.contentView.backgroundColor = KColorHexadecimal(0xf7f7f7, 1.0);
    UIView *conView = [[UIView alloc]init];
    conView.backgroundColor = [UIColor whiteColor];
    KViewRadius(conView, 4.0);
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:12];
    [conView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView).with.offset(17);
        make.top.equalTo(conView).with.offset(10);
    }];
    _timeLbl = [TXXLViewManager customDetailLbl:nil font:12];
    [conView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(conView).with.offset(17);
        make.bottom.equalTo(conView).with.offset(-11);
    }];
    _hasCountLbl = [TXXLViewManager customTitleLbl:nil font:12];
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
