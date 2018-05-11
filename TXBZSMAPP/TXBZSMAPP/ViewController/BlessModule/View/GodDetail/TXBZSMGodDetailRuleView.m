//
//  TXBZSMGodDetailRuleView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodDetailRuleView.h"

@implementation TXBZSMGodDetailRuleView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.bgImage.image = [ImageNameInit(@"goddetailkuang")resizableImageWithCapInsets:UIEdgeInsetsMake(25, 24, 25, 24)];
}

@end
