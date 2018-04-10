//
//  UIView+Extend.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "UIView+Extend.h"

@implementation UIView (Extend)
//圆角
- (void)addCornerMaskLayerWithRadius:(CGFloat)radius {
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                       byRoundingCorners:UIRectCornerAllCorners
                                             cornerRadii:CGSizeMake(radius, radius)]
    .CGPath;
    self.layer.mask = layer;
}
//添加水平线
- (void)addHorizontalLineWithColor:(UIColor *)lineColor {
    CAShapeLayer *line = [CAShapeLayer layer];
    UIBezierPath *linePath = [UIBezierPath bezierPath];
    [linePath moveToPoint:CGPointMake(CGRectGetMinX(self.bounds), CGRectGetMidY(self.bounds))];
    [linePath addLineToPoint:CGPointMake(CGRectGetMaxX(self.bounds), CGRectGetMidY(self.bounds))];
    line.path = linePath.CGPath;
    line.fillColor = nil;
    line.opacity = 1.0;
    line.strokeColor = lineColor.CGColor;
    [self.layer addSublayer:line];
}
@end
