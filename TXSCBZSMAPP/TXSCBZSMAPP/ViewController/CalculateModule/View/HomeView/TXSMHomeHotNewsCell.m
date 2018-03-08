//
//  TXSMHomeHotNewsCell.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMHomeHotNewsCell.h"
#import "UIImageView+WebCache.h"
@implementation TXSMHomeHotNewsCell
{
    UIImageView *_iconImgView;
    UILabel *_titleLbl;
    UILabel *_countLbl;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        [self _layoutMainView];
    }
    return self;
}

- (void)setupCellContent:(NSString *)image title:(NSString *)title detail:(NSString *)detail {
    if (KJudgeIsNullData(image)) {
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        _iconImgView.image = nil;
    }
    _titleLbl.text = title;
    _countLbl.text = NSStringFormat(@"%@阅",detail);
}
- (void)_layoutMainView {
    self.backgroundColor = KColorHexadecimal(kMainBackground_Color, 1.0);
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:contentView];
    
    UIImageView *iconImgView = [[UIImageView alloc]init];
    iconImgView.backgroundColor = [UIColor lightGrayColor];
    _iconImgView = iconImgView;
    [contentView addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.top.equalTo(contentView);
        make.height.mas_equalTo(iconImgView.mas_width).multipliedBy(1.0);
    }];
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl.numberOfLines = 2;
    [contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgView.mas_right).with.offset(17);
        make.right.equalTo(contentView).with.offset(-20);
        make.top.equalTo(contentView).with.offset(12);
    }];
    
    _countLbl = [TXXLViewManager customDetailLbl:nil font:14];
    [contentView addSubview:_countLbl];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgView.mas_right).with.offset(17);
        make.bottom.equalTo(contentView).with.offset(-9);
    }];
    
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
