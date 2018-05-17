//
//  TXBZSMTreeHomeView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTreeHomeView.h"
@interface TXBZSMTreeHomeView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cardWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *Cardheight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue1;
@end
@implementation TXBZSMTreeHomeView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topValue.constant = STATUSBAR_HEIGHT - 10;
    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
        self.topValue1.constant = WIDTH_RACE_6S(95);
        self.cardWidth.constant = 30;
        self.Cardheight.constant = 52;
    }else {
        self.topValue1.constant = WIDTH_RACE_6S(95) + STATUSBAR_HEIGHT;
        self.cardWidth.constant = WIDTH_RACE_6S(41);
        self.Cardheight.constant = WIDTH_RACE_6S(71);
    }
    
}
- (IBAction)cardClick:(UIButton *)sender {
    if (self.homeBlock) {
        self.homeBlock(sender.tag - 400,nil);
    }
}
- (IBAction)wishClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(10,nil);
    }
}
- (IBAction)myWishClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(11,nil);
    }
}
- (IBAction)backClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(12,nil);
    }
}

@end
