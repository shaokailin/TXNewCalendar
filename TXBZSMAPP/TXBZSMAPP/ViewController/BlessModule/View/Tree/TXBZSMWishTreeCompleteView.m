//
//  TXBZSMWishTreeCompleteView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishTreeCompleteView.h"
@interface TXBZSMWishTreeCompleteView ()
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;

@end
@implementation TXBZSMWishTreeCompleteView
-(void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setupContent:(NSString *)name {
    self.nameLbl.text = NSStringFormat(@"随缘布施传递爱心，许愿树会一直保佑您%@依教奉行，放生、印经、念佛、打坐",name);
}
- (IBAction)buttonClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}

@end
