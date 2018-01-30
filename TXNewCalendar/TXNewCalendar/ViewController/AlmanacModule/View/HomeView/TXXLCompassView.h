//
//  TXXLCompassView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TXXLCompassView : UIView
//罗盘旋转
- (void)compassTranform:(double)radius;
- (void)setupContentWithMoney:(NSString *)money happy:(NSString *)happy
                         luck:(NSString *)luck live:(NSString *)live;
@end
