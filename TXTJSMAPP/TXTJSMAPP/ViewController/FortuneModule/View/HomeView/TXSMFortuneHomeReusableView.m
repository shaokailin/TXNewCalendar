//
//  TXSMFortuneHomeReusableView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeReusableView.h"
@interface TXSMFortuneHomeReusableView ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIView *leftLine;
@property (weak, nonatomic) IBOutlet UIView *rightLine;
@end
@implementation TXSMFortuneHomeReusableView
- (void)setupContentIsHiden:(BOOL)isHiden {
    self.titleLbl.hidden = isHiden;
    self.leftLine.hidden = isHiden;
    self.rightLine.hidden = isHiden;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
