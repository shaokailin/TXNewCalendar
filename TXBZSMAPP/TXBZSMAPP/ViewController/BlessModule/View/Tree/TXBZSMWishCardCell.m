//
//  TXBZSMWishCardCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishCardCell.h"
@interface TXBZSMWishCardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation TXBZSMWishCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContent:(NSString *)title img:(NSString *)img {
    self.iconImage.image = ImageNameInit(img);
    self.titleLbl.text = title;
}
@end
