//
//  TXXLPublicFestiveItemView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ItemClickBlock)(BOOL isClick);
@interface TXXLPublicFestiveItemView : UIView
- (void)setupContentWithDate:(NSString *)date week:(NSString *)week title:(NSString *)title hasCount:(NSString *)hasCount;
@property (nonatomic, copy) ItemClickBlock itemBlock;
@end
