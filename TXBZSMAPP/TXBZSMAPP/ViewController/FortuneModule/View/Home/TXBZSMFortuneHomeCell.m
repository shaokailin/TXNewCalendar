//
//  TXBZSMFortuneHomeCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMFortuneHomeCell.h"
#import "UIImageView+WebCache.h"
@interface TXBZSMFortuneHomeCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation TXBZSMFortuneHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KViewBoundsRadius(self.iconImage, 5);
    KViewRadius(self.bgView, 5);
}
- (void)setupCellContent:(NSString *)title img:(NSString *)img {
    if (img) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:img]];
    }
    self.titleLbl.text = title;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
