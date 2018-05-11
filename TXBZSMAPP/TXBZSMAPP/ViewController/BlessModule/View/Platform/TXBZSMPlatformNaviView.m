//
//  TXBZSMPlatformNaviView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMPlatformNaviView.h"

@implementation TXBZSMPlatformNaviView
- (IBAction)backClick:(id)sender {
    if (self.block) {
        self.block(1);
    }
}
- (IBAction)shareClick:(id)sender {
    if (self.block) {
        self.block(2);
    }
}
- (IBAction)selectGod:(id)sender {
    if (self.block) {
        self.block(3);
    }
}
- (IBAction)myBlessClick:(id)sender {
    if (self.block) {
        self.block(4);
    }
}


@end
