//
//  TXBZSMMyBlessNoView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessNoView.h"

@implementation TXBZSMMyBlessNoView

- (IBAction)jumpSelect:(id)sender {
    if (self.block) {
        self.block(YES);
    }
}


@end
