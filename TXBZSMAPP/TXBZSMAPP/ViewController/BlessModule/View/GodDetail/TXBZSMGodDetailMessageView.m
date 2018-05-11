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

@end
@implementation TXBZSMGodDetailMessageView

- (void)setupContent:(NSString *)name type:(NSString *)type image:(NSString *)img {
    self.nameLbl.text = name;
    self.typeLbl.text = NSStringFormat(@"祈福类型: %@",type);
    self.imageView.image = ImageNameInit(img);
}

@end
