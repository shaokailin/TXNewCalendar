//
//  TXXLCalculateAdCell.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateAdCell.h"
#import "UIImageView+WebCache.h"
@interface TXXLCalculateAdCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

@end
@implementation TXXLCalculateAdCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    _iconImageView.layer.masksToBounds = YES;
    _iconImageView.layer.cornerRadius = 4;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.cornerRadius = 4;
    _iconImageView.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);
    self.bgView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.bgView.layer.shadowOpacity = 0.2;
    self.bgView.layer.shadowRadius = 2.0f;
    self.bgView.layer.shadowOffset = CGSizeMake(1, 1);
    self.clipsToBounds =NO;
    self.bgView.clipsToBounds =NO;
}
- (void)setModel:(NSDictionary *)model {
    NSString *title = [model objectForKey:@"title"];
    NSString *image = [model objectForKey:@"image"];
    _titleLbl.text = title;
    if (KJudgeIsNullData(image)) {
        [_iconImageView sd_setImageWithURL:[NSURL URLWithString:image]];
    }
}
@end
