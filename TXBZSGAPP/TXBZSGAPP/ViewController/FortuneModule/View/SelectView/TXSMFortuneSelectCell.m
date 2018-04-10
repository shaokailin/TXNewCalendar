//
//  TXSMFortuneSelectCell.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneSelectCell.h"
@interface TXSMFortuneSelectCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;

@end
@implementation TXSMFortuneSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContent:(NSString *)name img:(NSString *)img time:(NSString *)time {
    self.iconImage.image = ImageNameInit(img);
    self.nameLbl.text = name;
    self.timeLbl.text = time;
}
@end
