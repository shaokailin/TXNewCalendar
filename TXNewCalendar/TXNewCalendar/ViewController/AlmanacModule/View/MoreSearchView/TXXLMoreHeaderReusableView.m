//
//  TXXLMoreHeaderReusableView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLMoreHeaderReusableView.h"

@implementation TXXLMoreHeaderReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)alertBtnClick:(id)sender {
    if (self.alertBlock) {
        self.alertBlock(YES);
    }
}
@end
