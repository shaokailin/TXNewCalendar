//
//  TXBZSMPlatformGoodsCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//
#import "TXBZSMPlatformGoodsButtn.h"
#import "TXBZSMPlatformGoodsCell.h"
@interface TXBZSMPlatformGoodsCell ()
@property (weak, nonatomic) IBOutlet TXBZSMPlatformGoodsButtn *fitstbtn;
@property (weak, nonatomic) IBOutlet TXBZSMPlatformGoodsButtn *secondBtn;
@property (weak, nonatomic) IBOutlet TXBZSMPlatformGoodsButtn *thirdBtn;
@end
@implementation TXBZSMPlatformGoodsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = [UIColor clearColor];
}
- (void)setupContentWithFirst:(NSDictionary *)first second:(NSDictionary *)second third:(NSDictionary *)third {
    [self.fitstbtn setupContentWithName:[first objectForKey:@"name"] img:[first objectForKey:@"image"]];
    [self.secondBtn setupContentWithName:[second objectForKey:@"name"] img:[second objectForKey:@"image"]];
     [self.thirdBtn setupContentWithName:[third objectForKey:@"name"] img:[third objectForKey:@"image"]];
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.selectBlock) {
        self.selectBlock(sender.tag - 200, self);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
