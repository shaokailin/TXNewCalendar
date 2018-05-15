//
//  TXBZSMUserPhotoCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMUserPhotoCell.h"
@interface TXBZSMUserPhotoCell()
@property (weak, nonatomic) IBOutlet UIImageView *userPhotoImage;
@end

@implementation TXBZSMUserPhotoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.userPhotoImage.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changePhotoClick)];
    [self.userPhotoImage addGestureRecognizer:tap];
}
- (void)changePhotoClick {
    if (self.block) {
        self.block(YES);
    }
}
- (void)setupUserPhoto:(UIImage *)photoString {
    self.userPhotoImage.image = photoString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
