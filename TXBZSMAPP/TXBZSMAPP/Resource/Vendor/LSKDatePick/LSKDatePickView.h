//
//  LSKDatePickView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/16.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGDatePicker.h"
#import "PGEnumeration.h"
typedef void (^LSKDateSelectBlock)(NSDate *selectDate);
@interface LSKDatePickView : UIView
@property (nonatomic, weak) PGDatePicker *datePicker;
@property (nonatomic, assign) PGDatePickManagerStyle style;
@property (nonatomic, assign) BOOL isShadeBackgroud;

@property (nonatomic, copy) NSString *cancelButtonText;
@property (nonatomic, copy) UIFont *cancelButtonFont;
@property (nonatomic, copy) UIColor *cancelButtonTextColor;

@property (nonatomic, copy) NSString *confirmButtonText;
@property (nonatomic, copy) UIFont *confirmButtonFont;
@property (nonatomic, copy) UIColor *confirmButtonTextColor;

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, strong)UIColor *headerViewBackgroundColor;
@property (nonatomic, assign) CGFloat headerHeight;

@property (nonatomic, strong) NSDate *maxDate;
@property (nonatomic, strong) NSDate *minDate;
@property (nonatomic, strong) LSKDateSelectBlock selectBlock;
- (void)showInView;
- (instancetype)initWithFrame:(CGRect)frame tabHeight:(CGFloat)height;
@end
