//
//  HSPBannerImageView.m
//  HSPlan
//
//  Created by hsPlan on 2017/6/26.
//  Copyright © 2017年 厦门花生计划网络科技公司. All rights reserved.
//

#import "LSKBannerImageView.h"
@interface LSKBannerImageView ()
{
    UIImage *_placeHolderImage;
    BOOL isHasSucess;
}
@end
@implementation LSKBannerImageView
-(instancetype)initWithFrame:(CGRect)frame placeHolderImage:(UIImage *)placeHolderImage {
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        _placeHolderImage = placeHolderImage;
        self.contentMode = UIViewContentModeScaleToFill;
        self.backgroundColor = KColorHexadecimal(kLineMain_Color, 1.0);;
        isHasSucess = NO;
    }
    return self;
}
- (void)loadWebImageView {
    if (!isHasSucess && KJudgeIsNullData(_imageWebUrl)) {
        isHasSucess = YES;
        self.image = ImageNameInit(_imageWebUrl);
    }
}

- (void)setImageWebUrl:(NSString *)imageWebUrl {
    if (!KJudgeIsNullData(_imageWebUrl) ||![_imageWebUrl isEqualToString:imageWebUrl]) {
        isHasSucess = NO;
    }
    _imageWebUrl = imageWebUrl;
}

@end
