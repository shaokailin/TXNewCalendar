//
//  TXSMCalculateHomeCollectionCell.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMCalculateHomeCollectionCell.h"
#import "UIImageView+WebCache.h"
@interface TXSMCalculateHomeCollectionCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation TXSMCalculateHomeCollectionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithImg:(NSString *)img title:(NSString *)title {
    _titleLbl.text = title;
    if (KJudgeIsNullData(img)) {
        [_iconImage sd_setImageWithURL:[NSURL URLWithString:img]];
    }
}
@end
