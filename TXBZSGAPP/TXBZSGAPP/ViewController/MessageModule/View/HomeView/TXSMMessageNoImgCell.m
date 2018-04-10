//
//  TXSMMessageNoImgCell.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/10.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageNoImgCell.h"

@implementation TXSMMessageNoImgCell
{
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
- (void)setupCellContentTitle:(NSString *)title where:(NSString *)where count:(NSString *)count {
    _titleLbl.text = title;
    _whereLbl.text = NSStringFormat(@"%@    %@评",where,count);
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
    _titleLbl = [TXXLViewManager customTitleLbl:nil font:14];
    _titleLbl.numberOfLines = 2;
    [self.contentView addSubview:_titleLbl];
    [_titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo (ws.contentView).with.offset(15);
        make.top.equalTo(ws.contentView).with.offset(14);
        make.right.equalTo(ws.contentView).with.offset(-15);
    }];
    _whereLbl = [TXXLViewManager customDetailLbl:nil font:10];
    [self.contentView addSubview:_whereLbl];
    [_whereLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ws.contentView).with.offset(15);
        make.bottom.equalTo(ws.contentView).with.offset(-10);
    }];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
