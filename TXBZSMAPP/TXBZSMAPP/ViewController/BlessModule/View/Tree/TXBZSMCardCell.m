//
//  TXBZSMCardCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMCardCell.h"
@interface TXBZSMCardCell ()
@property (weak, nonatomic) IBOutlet UIImageView *firstImag;
@property (weak, nonatomic) IBOutlet UIView *contentView1;
@property (weak, nonatomic) IBOutlet UILabel *contentLbk;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation TXBZSMCardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setModel:(NSDictionary *)model {
    NSInteger type = [[model objectForKey:@"type"]integerValue];
    if (type == 0) {
        self.contentView1.hidden = YES;
        self.firstImag .image = ImageNameInit([model objectForKey:@"image"]);
    }else {
        self.contentView1.hidden = NO;
        self.firstImag.hidden = YES;
        self.contentLbk.text = [model objectForKey:@"content"];
        self.titleLbl.text = [model objectForKey:@"title"];
    }
}
@end
