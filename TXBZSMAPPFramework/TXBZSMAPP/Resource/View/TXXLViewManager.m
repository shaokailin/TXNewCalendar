//
//  TXXLViewManager.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLViewManager.h"

@implementation TXXLViewManager
+ (UILabel *)customAppLbl:(NSString *)title font:(CGFloat)font {
    return [LSKViewFactory initializeLableWithText:title font:font textColor:KColorHexadecimal(kAPP_Main_Color, 1.0) textAlignment:0 backgroundColor:nil];
}
+ (UILabel *)customTitleLbl:(NSString *)title font:(CGFloat)font {
    return [LSKViewFactory initializeLableWithText:title font:font textColor:KColorHexadecimal(kText_Title_Color, 1.0) textAlignment:0 backgroundColor:nil];
}
+ (UILabel *)customDetailLbl:(NSString *)title font:(CGFloat)font {
    return [LSKViewFactory initializeLableWithText:title font:font textColor:KColorHexadecimal(kText_Detail_Color, 1.0) textAlignment:0 backgroundColor:nil];
}
@end
