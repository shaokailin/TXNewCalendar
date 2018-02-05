//
//  TXXLBottonAdView.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^BottonAdBlock)(NSInteger flag,NSInteger type);
@interface TXXLBottonAdView : UIView
@property (nonatomic, copy) BottonAdBlock clickBlock;
@property (nonatomic, assign) NSInteger flag;
- (void)setupContentWithTitle:(NSString *)title english:(NSString *)english;
- (void)setupContentWithData:(NSArray *)array;
@end
