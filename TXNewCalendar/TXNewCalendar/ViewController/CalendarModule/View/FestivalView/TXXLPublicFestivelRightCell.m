//
//  TXXLPublicFestivelRightCell.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLPublicFestivelRightCell.h"
#import "TXXLPublicFestiveItemView.h"
@implementation TXXLPublicFestivelRightCell

{
    TXXLPublicFestiveItemView *_itemView;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithDate:(NSString *)date week:(NSString *)week title:(NSString *)title hasCount:(NSString *)hasCount {
    [_itemView setupContentWithDate:date week:week title:title hasCount:hasCount];
}
- (void)_layoutMainView {
    self.selectionStyle = 0;
    WS(ws)
    UIView *circleView = [[UIView alloc]init];
    KViewRadius(circleView, 9);
    KViewBorderLayer(circleView, KColorHexadecimal(kAPP_Main_Color, 1.0), 2);
    [self.contentView addSubview:circleView];
    [circleView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.centerX.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(18, 18));
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KColorHexadecimal(0xd3d3d3, 1.0);
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(circleView.mas_bottom);
        make.centerX.equalTo(circleView);
        make.bottom.equalTo(ws.contentView);
        make.width.mas_equalTo(2);
    }];
    TXXLPublicFestiveItemView *itemView = [[TXXLPublicFestiveItemView alloc]initWithType:1];
    _itemView = itemView;
    [self.contentView addSubview:itemView];
    [itemView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws.contentView);
        make.size.mas_equalTo(CGSizeMake(268 / 2.0, 190 / 2.0));
        make.left.equalTo(circleView.mas_right).with.offset(9);
    }];
    itemView.itemBlock = ^(BOOL isClick) {
        [ws addTimeClick];
    };
    
}
- (void)addTimeClick {
    if (self.timeBlock) {
        self.timeBlock(self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
