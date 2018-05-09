//
//  TXBZSMMyBlessCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessCell.h"
@interface TXBZSMMyBlessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *allCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *hasCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *blessBtn;

@end
@implementation TXBZSMMyBlessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KViewRadius(self.blessBtn, 3.0);
    KViewBorderLayer(self.blessBtn, KColorHexadecimal(0x21A8E4, 1.0), 0.5);
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 5;
    [super setFrame:frame];
}
- (IBAction)jumpBless:(id)sender {
    if (self.block) {
        self.block(1, self);
    }
}
- (IBAction)wanClick:(id)sender {
    if (self.block) {
        self.block(2, self);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
