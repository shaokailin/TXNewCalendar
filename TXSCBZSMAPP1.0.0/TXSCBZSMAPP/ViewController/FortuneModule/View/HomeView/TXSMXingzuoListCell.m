//
//  TXSMXingzuoListCell.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/16.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMXingzuoListCell.h"

@implementation TXSMXingzuoListCell
{
    UIImageView *_iconImage;
    UILabel *_titleLbl;
    UILabel *_timeLbl;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupCellContent:(NSString *)img title:(NSString *)title time:(NSString *)time {
    _iconImage.image = ImageNameInit(img);
    _titleLbl.text = title;
    _timeLbl.text = time;
}
- (void)_layoutMainView {
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 265, 35)];
    view.backgroundColor = KColorHexadecimal(0xeaf5ff, 1.0);
    self.selectedBackgroundView = view;
    UIImageView *iconImage = [[UIImageView alloc]init];
    _iconImage = iconImage;
    [self.contentView addSubview:iconImage];
    WS(ws)
    [iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(42);
        make.centerY.equalTo(ws.contentView);
    }];
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:17];
    _titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImage.mas_right).with.offset(5);
        make.centerY.equalTo(ws.contentView);
    }];
    
    _timeLbl = [TXXLViewManager customTitleLbl:nil font:17];
    [self.contentView addSubview:_timeLbl];
    [_timeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl.mas_right).with.offset(12);
        make.centerY.equalTo(ws.contentView);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
