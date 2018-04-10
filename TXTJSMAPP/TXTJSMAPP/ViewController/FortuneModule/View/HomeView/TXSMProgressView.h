//
//  TXSMProgressView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ProgressStyleType) {
    ProgressStyleType_Synthesize = 0,
    ProgressStyleType_Money,
    ProgressStyleType_Love,
    ProgressStyleType_Job,
    ProgressStyleType_Health,
};
@interface TXSMProgressView : UIView
- (instancetype)initWithType:(ProgressStyleType)styleType;
- (void)setupValue:(CGFloat)value;
@end
