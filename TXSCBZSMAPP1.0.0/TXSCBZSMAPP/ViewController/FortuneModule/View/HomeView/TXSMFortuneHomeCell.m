//
//  TXSMFortuneHomeCell.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeCell.h"
#import "UIImageView+WebCache.h"
@implementation TXSMFortuneHomeCell
{
    UIImageView *_iconImgView;
    UILabel *_titleLbl;
//    UILabel *_countLbl;
    UILabel *_percentLbl;
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
- (void)setupCellContent:(NSString *)image title:(NSString *)title count:(NSString *)count present:(NSString *)present {
    if (KJudgeIsNullData(image)) {
        [_iconImgView sd_setImageWithURL:[NSURL URLWithString:image]];
    }else {
        _iconImgView.image = nil;
    }
    _titleLbl.text = title;
//    _countLbl.text = count;
    _percentLbl.text = present;
}
- (void)_layoutMainView {
    self.backgroundColor = KColorHexadecimal(kMainBackground_Color, 1.0);
    UIView *contentView = [[UIView alloc]init];
    contentView.backgroundColor = [UIColor whiteColor];
    KViewRadius(contentView, 4.0);
    [self.contentView addSubview:contentView];
    UIImageView *iconImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 86, 86)];
    iconImgView.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
    [iconImgView addCornerMaskLayerWithRadius:4.0];
    _iconImgView = iconImgView;
    [contentView addSubview:iconImgView];
    [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(contentView).with.offset(17);
        make.width.mas_equalTo(86);
        make.centerY.equalTo(contentView);
        make.height.mas_equalTo(iconImgView.mas_width).multipliedBy(1.0);
    }];
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl.numberOfLines = 2;
    [contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(iconImgView.mas_right).with.offset(12);
        make.right.equalTo(contentView).with.offset(-20);
        make.top.equalTo(contentView).with.offset(17);
    }];
    
    UIImageView *presentIconImg = [[UIImageView alloc]initWithImage:ImageNameInit(@"present_icon")];
    [contentView addSubview:presentIconImg];
    [presentIconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(contentView).with.offset(-22);
        make.left.equalTo(iconImgView.mas_right).with.offset(12);
        make.size.mas_equalTo(CGSizeMake(9, 9));
    }];
    
    _percentLbl = [LSKViewFactory initializeLableWithText:nil font:11 textColor:KColorHexadecimal(0xadadad, 1.0) textAlignment:NSTextAlignmentLeft backgroundColor:nil];
    [contentView addSubview:_percentLbl];
    [_percentLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(presentIconImg.mas_right).with.offset(8);
        make.centerY.equalTo(presentIconImg);
    }];
    
    WS(ws)
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(0, 5, 0, 5));
    }];
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 0.5;    // 减掉的值就是分隔线的高度
    [super setFrame:frame];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
