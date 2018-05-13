//
//  TXBZSMWishCardDetailView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishCardDetailView.h"
@interface TXBZSMWishCardDetailView ()
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *infoLbl;

@end
@implementation TXBZSMWishCardDetailView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.topValue.constant = STATUSBAR_HEIGHT;
}
- (IBAction)backClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(0, nil);
    }
}
- (IBAction)jumpInputView:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(1, nil);
    }
}
- (void)setupContentWithData:(NSDictionary *)dict {
    self.iconImage.image = ImageNameInit([dict objectForKey:@"image"]);
    self.infoLbl.text = [dict objectForKey:@"info"];
}

@end
