//
//  TXXLFestivalCountDownCell.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLFestivalCountDownCell.h"

@implementation TXXLFestivalCountDownCell
{
    UILabel *_leftTitleLbl;
    UILabel *_rightTitleLbl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContentWithLeft:(NSString *)left right:(NSString *)right {
    _leftTitleLbl.text = left;
    _rightTitleLbl.text = right;
}
- (void)_layoutMainView {
    UIView *circleView = [[UIView alloc]init];
    circleView.backgroundColor = KColorHexadecimal(0xbfbfbf, 1.0);
    KViewRadius(circleView, 3);
    [self.contentView addSubview:circleView];
    WS(ws)
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(10);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(6, 6));
    }];
    _leftTitleLbl = [TXXLViewManager customTitleLbl:nil font:WIDTH_RACE_6S(13)];
    [self.contentView addSubview:_leftTitleLbl];
//    _leftTitleLbl.adjustsFontSizeToFitWidth = YES;
    [_leftTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(circleView.mas_right).with.offset(15);
        make.centerY.equalTo(ws.contentView);
        make.right.lessThanOrEqualTo(ws.contentView).with.offset(-90);
    }];
    _rightTitleLbl = [TXXLViewManager customTitleLbl:nil font:13];
    _rightTitleLbl.adjustsFontSizeToFitWidth = YES;
    [self.contentView addSubview:_rightTitleLbl ];
    [_rightTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws).with.offset(-10);
        make.centerY.equalTo(ws.contentView);
        make.width.mas_equalTo(WIDTH_RACE_6S(70));
    }];
    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 1;    // 减掉的值就是分隔线的高度
    [super setFrame:frame];
}
@end
