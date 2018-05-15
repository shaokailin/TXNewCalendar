//
//  TXBZSMUserSelectCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMUserSelectCell.h"
@interface TXBZSMUserSelectCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UILabel *detailLbl;

@end
@implementation TXBZSMUserSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithTitle:(NSString *)title detail:(NSString *)detail {
    _titleLbl.text = title;
    _detailLbl.text = detail;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
