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
- (void)setupCellContent:(NSString *)img title:(NSString *)title where:(NSString *)where count:(NSString *)count {
    if (KJudgeIsNullData(img)) {
        [_adImgView sd_setImageWithURL:[NSURL URLWithString:img]];
    }else {
        _adImgView.image = nil;
    }
    _titleLbl.text = title;
    _whereLbl.text = where;
    _countLbl.text = NSStringFormat(@"%@阅",count);;
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor clearColor];
    WS(ws)
    UIView *bgView = [[UIView alloc]init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView);
    }];
    _adImgView = [[UIImageView alloc]init];
    _adImgView.backgroundColor = KColorRGBA(244, 244, 244, 1.0);
    [bgView addSubview:_adImgView];
    
    [_adImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(bgView);
        make.width.equalTo(self->_adImgView.mas_height).multipliedBy(156 / 103.0);
    }];
    
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:13];
    _titleLbl.numberOfLines = 2;
    [bgView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (self->_adImgView.mas_right).with.offset(22);
        make.top.equalTo(bgView).with.offset(7);
        make.right.equalTo(bgView).with.offset(-12);
    }];
    _whereLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [bgView addSubview:_whereLbl];
    [_whereLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_titleLbl);
        make.bottom.equalTo(ws.contentView).with.offset(-7);
    }];
    
    _countLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [bgView addSubview:_countLbl];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self->_titleLbl);
        make.bottom.equalTo(self->_whereLbl);
    }];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
