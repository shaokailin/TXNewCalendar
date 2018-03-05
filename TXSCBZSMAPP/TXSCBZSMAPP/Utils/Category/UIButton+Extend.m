//
//  UIButton+Extend.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "UIButton+Extend.h"

@implementation UIButton (Extend)
//上下文字图片
- (void)setVerticalLayoutWithSpace:(CGFloat)itemSpace {
    CGFloat spacing = itemSpace;
    CGSize imageSize = self.imageView.image.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height + spacing), 0.0);
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName : self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height + spacing), 0.0, 0.0, -titleSize.width);
}
@end
