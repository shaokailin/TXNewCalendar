//
//  TXSMMessageOneImgCell.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageOneImgCell.h"
#import "UIImageView+WebCache.h"
@implementation TXSMMessageOneImgCell
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
- (void)setupCellContent:(NSString *)img title:(NSString *)title where:(NSString *)where count:(NSString *)count {
    if (KJudgeIsNullData(img)) {
        [_adImgView sd_setImageWithURL:[NSURL URLWithString:img]];
    }else {
        _adImgView.image = nil;
    }
    _titleLbl.text = title;
    _whereLbl.text = NSStringFormat(@"%@    %@评",where,count);
}
- (void)_layoutMainView {
    UIImageView *adImage = [[UIImageView alloc]initWithFrame:CGRectMake(0 , 0, 115, 82)];
    [adImage addCornerMaskLayerWithRadius:1];
    adImage.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    _adImgView = adImage;
    [self.contentView addSubview:adImage];
    WS(ws)
    [adImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(ws.contentView).with.offset(-15);
        make.centerY.equalTo(ws.contentView);
        make.size.mas_offset(CGSizeMake(115, 82));
    }];
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl.numberOfLines = 2;
    [self.contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView).with.offset(14);
        make.right.equalTo(adImage.mas_left).with.offset(-17);
    }];
    _whereLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self.contentView addSubview:_whereLbl];
    [_whereLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.bottom.equalTo(ws.contentView).with.offset(-12);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
