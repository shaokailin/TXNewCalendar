//
//  TXSMFortuneHomeCell.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeCell.h"
@interface TXSMFortuneHomeCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation TXSMFortuneHomeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)setupCellContentWithImg:(NSString *)img title:(NSString *)title {
    _titleLbl.text = title;
    if (KJudgeIsNullData(img)) {
        _iconImage.image = ImageNameInit(img);
    }
}
@end
