//
//  TXBZSMBlessWishCompleteView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessWishCompleteView.h"
@interface TXBZSMBlessWishCompleteView()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;

@end
@implementation TXBZSMBlessWishCompleteView
- (void)awakeFromNib {
    [super awakeFromNib];
    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
        self.topValue.constant = 30;
    }
    KViewRadius(self.bgView, 187 / 2.0);
}
- (void)setupContent:(NSString *)img name:(NSString *)name {
    self.iconImage.image = ImageNameInit(img);
    self.nameLbl.text = NSStringFormat(@"弟子在%@供前虔诚供奉，许下心愿，今天达成所愿，请至寺庙烧香还愿！",name);
}
- (IBAction)completeClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}

@end
