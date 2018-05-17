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
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *contentHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topBetween;

@end
@implementation TXBZSMWishCardDetailView
- (void)awakeFromNib {
    [super awakeFromNib];
    self.topValue.constant = STATUSBAR_HEIGHT - 10;
    BOOL isIphone4 = [LSKPublicMethodUtil getiPhoneType] == 0?YES:NO;
    if (isIphone4) {
        self.contentHeight.constant = 95;
        self.topBetween.constant = 80;
    }
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
