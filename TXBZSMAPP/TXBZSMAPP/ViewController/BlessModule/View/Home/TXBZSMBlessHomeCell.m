//
//  TXBZSMBlessHomeCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeCell.h"
#import "UIImageView+WebCache.h"
@interface TXBZSMBlessHomeCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end
@implementation TXBZSMBlessHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
    KViewRadius(self.bgView, 5.0);
}
- (void)setupCellContent:(NSDictionary *)dict {
    self.titleLbl.text = [dict objectForKey:@"title"];
    self.detailLbl.text = KNullTransformString([dict objectForKey:@"subtitle"]);
    NSString *image = [dict objectForKey:@"image"];
    if (KJudgeIsNullData(image)) {
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
