//
//  TXSMMessageAddCell.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageAddCell.h"
#import "UIImageView+WebCache.h"
@implementation TXSMMessageAddCell
{
    UIImageView *_adImgView;
    UILabel *_titleLbl;
    UILabel *_whereLbl;
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
- (void)setupCellContent:(NSString *)img title:(NSString *)title where:(NSString *)where {
    if (KJudgeIsNullData(img)) {
        [_adImgView sd_setImageWithURL:[NSURL URLWithString:img]];
    }else {
        _adImgView.image = nil;
    }
    _titleLbl.text = title;
}
- (void)_layoutMainView {
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl = titleLbl;
    [self.contentView addSubview:titleLbl];
    WS(ws)
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView).with.offset(9);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
    UIImageView *adImage = [[UIImageView alloc]init];
//    [adImage addCornerMaskLayerWithRadius:1];
    adImage.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    _adImgView = adImage;
    [self.contentView addSubview:adImage];
    
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(7);
        make.height.mas_equalTo(173);
    }];
    
    UILabel * adTitleLbl = [TXXLViewManager customDetailLbl:@"广告" font:10];
    [self.contentView addSubview:adTitleLbl];
    [adTitleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.bottom.equalTo(ws.contentView).with.offset(-8);
    }];
    
//    _whereLbl = [TXXLViewManager customDetailLbl:nil font:10];
//    [self.contentView addSubview:_whereLbl];
//    [_whereLbl mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(adTitleLbl.mas_right).with.offset(27);
//        make.centerY.equalTo(adTitleLbl);
//    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
