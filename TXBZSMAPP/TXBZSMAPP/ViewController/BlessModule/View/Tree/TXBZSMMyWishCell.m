//
//  TXBZSMMyWishCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyWishCell.h"
@interface TXBZSMMyWishCell ()
@property (weak, nonatomic) IBOutlet UIButton *btn;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
@implementation TXBZSMMyWishCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContent:(NSString *)image title:(NSString *)title {
    self.iconImage.image = ImageNameInit(image);
    [self.btn setTitle:title forState:UIControlStateNormal];
}
- (IBAction)click:(id)sender {
    if (self.block) {
        self.block(self);
    }
}

@end
