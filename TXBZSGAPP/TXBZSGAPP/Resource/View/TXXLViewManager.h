//
//  TXXLViewManager.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXXLViewManager : NSObject

/**
 自定义 标题Label

 @param title 323232 标题
 @param font 字体大小
 @return UILabel
 */
+ (UILabel *)customTitleLbl:(NSString *)title font:(CGFloat)font;

/**
 自定义 707070 Label

 @param title 内容
 @param font 字体大小
 @return UILabel
 */
+ (UILabel *)customDetailLbl:(NSString *)title font:(CGFloat)font;
/**
 自定义 APP主颜色Label
 
 @param title 内容
 @param font 字体大小
 @return UILabel
 */
+ (UILabel *)customAppLbl:(NSString *)title font:(CGFloat)font;
@end
