//
//  TXBZSMInitWishCardView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMInitWishCardView.h"
@interface TXBZSMInitWishCardView ()
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *remarkView;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end
@implementation TXBZSMInitWishCardView
- (void)awakeFromNib {
    [super awakeFromNib];
    KViewRadius(self.remarkView, 5.0);
    self.contentView.hidden = YES;
}
- (IBAction)backClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (IBAction)shareClick:(id)sender {
    if (self.block) {
        self.block(1);
    }
}

- (void)setupContent:(TXBZSMWishTreeModel *)model {
    self.iconImageView.image = ImageNameInit(model.image);
    self.contentLbl.text = model.wishContent;
    self.nameLbl.text = NSStringFormat(@"--%@",model.wishTitle);
}
@end
