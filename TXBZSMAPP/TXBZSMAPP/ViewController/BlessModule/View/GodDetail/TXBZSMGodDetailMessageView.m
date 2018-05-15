//
//  TXBZSMGodDetailMessageView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodDetailMessageView.h"
@interface TXBZSMGodDetailMessageView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLbl;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerValue;
@property (weak, nonatomic) IBOutlet UIImageView *hasImage;

@end
@implementation TXBZSMGodDetailMessageView

- (void)setupContent:(NSString *)name type:(NSString *)type image:(NSString *)img has:(BOOL)isHas {
    self.nameLbl.text = name;
    self.typeLbl.text = NSStringFormat(@"祈福类型: %@",type);
    self.imageView.image = ImageNameInit(img);
    self.hasImage.hidden = !isHas;
    CGFloat width = [name calculateTextWidth:16] / 2.0;
    if (isHas) {
        self.centerValue.constant = - (width + 3);
    }else {
        self.centerValue.constant = 0;
    }
}

@end
