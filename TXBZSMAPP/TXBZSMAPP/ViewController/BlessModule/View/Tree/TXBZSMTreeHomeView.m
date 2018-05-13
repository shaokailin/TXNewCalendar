//
//  TXBZSMTreeHomeView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTreeHomeView.h"
@interface TXBZSMTreeHomeView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;
@end
@implementation TXBZSMTreeHomeView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.topValue.constant = STATUSBAR_HEIGHT;
    
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
