//
//  TXXLMiddelAdView.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MiddleAdClickBlock)(NSString *url,NSString *title);
@interface TXXLMiddelAdView : UIView
@property (nonatomic, copy) MiddleAdClickBlock clickBlock;
- (void)setupContentWithTitle:(NSString *)title english:(NSString *)english;
- (void)setupContentWithDataArray:(NSArray *)data;
@end
