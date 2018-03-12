//
//  TXSMMessageMoreImgCell.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageMoreImgCell.h"
#import "UIImageView+WebCache.h"
@implementation TXSMMessageMoreImgCell
{
    UIImageView *_adImgView;
    UIImageView *_adImgView2;
    UIImageView *_adImgView3;
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
- (void)setupCellContent:(NSString *)img img2:(NSString *)img2 img3:(NSString *)img3 title:(NSString *)title where:(NSString *)where count:(NSString *)count {
    if (KJudgeIsNullData(img)) {
        [_adImgView sd_setImageWithURL:[NSURL URLWithString:img]];
    }else {
        _adImgView.image = nil;
    }
    if (KJudgeIsNullData(img2)) {
        [_adImgView2 sd_setImageWithURL:[NSURL URLWithString:img2]];
    }else {
        _adImgView2.image = nil;
    }
    if (KJudgeIsNullData(img3)) {
        [_adImgView3 sd_setImageWithURL:[NSURL URLWithString:img3]];
    }else {
        _adImgView3.image = nil;
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
    CGFloat width = 110;
    CGFloat height = 82;
    UIImageView *adImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, width, height)];
    [adImage addCornerMaskLayerWithRadius:1];
    adImage.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    _adImgView = adImage;
    [self.contentView addSubview:adImage];
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(7);
        make.size.mas_offset(CGSizeMake(width, height));
    }];
    
    UIImageView *adImage2 = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, width, height)];
    [adImage2 addCornerMaskLayerWithRadius:1];
    adImage2.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    _adImgView2 = adImage2;
    [self.contentView addSubview:adImage2];
    [adImage2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(adImage.mas_right).with.offset(7);
        make.top.width.height.equalTo(adImage);
    }];
    
    UIImageView *adImage3 = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, width, height)];
    [adImage3 addCornerMaskLayerWithRadius:1];
    adImage3.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    _adImgView3 = adImage3;
    [self.contentView addSubview:adImage3];
    [adImage3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(adImage2.mas_right).with.offset(7);
        make.top.width.height.equalTo(adImage);
    }];
    
    _whereLbl = [TXXLViewManager customDetailLbl:@"广告" font:10];
    [self.contentView addSubview:_whereLbl];
    [_whereLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.bottom.equalTo(ws.contentView).with.offset(-8);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
