//
//  TXBZSMCardDetailView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMCardDetailView.h"
@interface TXBZSMCardDetailView ()
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@end
@implementation TXBZSMCardDetailView
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self removeFromSuperview];
}
- (void)setupCellContent:(NSString *)content title:(NSString *)title {
    self.contentLbl.text = content;
    self.nameLbl.text = title;
}

@end
