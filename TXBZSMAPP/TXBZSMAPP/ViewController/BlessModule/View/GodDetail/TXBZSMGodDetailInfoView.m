//
//  TXBZSMGodDetailInfoView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodDetailInfoView.h"
@interface TXBZSMGodDetailInfoView ()
@property (weak, nonatomic) IBOutlet UIImageView *bgImage;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;

@end
@implementation TXBZSMGodDetailInfoView
- (void)setupContent:(NSString *)content {
    self.contentLbl.text = content;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImage.image = [ImageNameInit(@"goddetailkuang")resizableImageWithCapInsets:UIEdgeInsetsMake(25, 24, 25, 24)];
}

@end
