//
//  TXBZSMHotSelectView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMHotSelectView.h"
#import "UIImageView+WebCache.h"
@interface TXBZSMHotSelectView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;

@end
@implementation TXBZSMHotSelectView
- (void)awakeFromNib {
    [super awakeFromNib];
}
- (void)setupContentWithImg:(NSString *)image {
    if (image) {
        [self.iconImage sd_setImageWithURL:[NSURL URLWithString:image]];
    }
}
@end
