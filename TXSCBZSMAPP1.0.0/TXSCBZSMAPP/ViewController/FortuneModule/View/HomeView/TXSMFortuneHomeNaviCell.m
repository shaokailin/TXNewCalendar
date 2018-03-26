//
//  TXSMFortuneHomeNaviCell.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeNaviCell.h"
@interface TXSMFortuneHomeNaviCell()
@property (strong ,nonatomic) UILabel *m_contentLabel;
@end
@implementation TXSMFortuneHomeNaviCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        self.m_contentLabel = [LSKViewFactory initializeLableWithText:nil font:WIDTH_RACE_6S(13) textColor:KColorHexadecimal(kText_Detail_Color, 1.0) textAlignment:1 backgroundColor:nil];
        [self.contentView addSubview:self.m_contentLabel];
        self.m_contentLabel.adjustsFontSizeToFitWidth = YES;
        WS(ws)
        [self.m_contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(ws.contentView);
            make.centerY.equalTo(ws.contentView);
        }];
    }
    return self;
}
-(void)setupContentWithTitle:(NSString *)title isSeleted:(BOOL)isSeleted {
    self.m_contentLabel.text = title;
    if (isSeleted) {
        self.m_contentLabel.textColor = KColorHexadecimal(kNavi_Yellow_Color, 1.0);
        [UIView animateWithDuration:0.2 animations:^{
            self.m_contentLabel.transform = CGAffineTransformMakeScale(1.13, 1.13);
        }];
    }else
    {
        self.m_contentLabel.textColor = KColorHexadecimal(kText_Detail_Color, 1.0);
        [UIView animateWithDuration:0.2 animations:^{
            self.m_contentLabel.transform = CGAffineTransformIdentity;
        }];
    }
}
-(void)changeTitleAttribute:(CGFloat)rate {
    self.m_contentLabel.transform = CGAffineTransformMakeScale(1.0 + (0.13 * rate), 1.0 + (0.13 * rate));
    self.m_contentLabel.textColor = KColorRGBA(ceil(128 + (100 * rate)), ceil(128 + (52 * rate)), ceil(128 - (55 * rate)), 1.0);
}
-(CGRect)getCellTitleFrame {
    CGRect rect = [self convertRect:self.m_contentLabel.frame toView:self.superview];
    return  rect;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
