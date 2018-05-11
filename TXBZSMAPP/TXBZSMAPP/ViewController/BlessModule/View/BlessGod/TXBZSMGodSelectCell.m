//
//  TXBZSMGodSelectCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodSelectCell.h"
#import "TXBZSMSelectGodButton.h"
@interface TXBZSMGodSelectCell ()
@property (weak, nonatomic) IBOutlet TXBZSMSelectGodButton *firstBtn;
@property (weak, nonatomic) IBOutlet TXBZSMSelectGodButton *secondBtn;
@property (weak, nonatomic) IBOutlet TXBZSMSelectGodButton *thirdBtn;

@end
@implementation TXBZSMGodSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupContentWithFirst:(NSDictionary *)first second:(NSDictionary *)second third:(NSDictionary *)third {
    [self.firstBtn setupContentWithName:[first objectForKey:@"name"] detail:[first objectForKey:@"blessType"] img:[first objectForKey:@"image"]];
    [self.secondBtn setupContentWithName:[second objectForKey:@"name"] detail:[second objectForKey:@"blessType"] img:[second objectForKey:@"image"]];
    [self.thirdBtn setupContentWithName:[third objectForKey:@"name"] detail:[third objectForKey:@"blessType"] img:[third objectForKey:@"image"]];
}
- (IBAction)btnClick:(UIButton *)sender {
    if (self.block) {
        self.block(sender.tag - 200, self);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
