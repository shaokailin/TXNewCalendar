//
//  TXXLSearchDetailHeaderView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, TimeState) {
    TimeState_Start = 0,
    TimeState_End = 1
};
typedef void (^DetailHeaderBlock)(TimeState state,NSInteger type);
@interface TXXLSearchDetailHeaderView : UIView
@property (nonatomic, copy) DetailHeaderBlock headerBlock;
@property (nonatomic, copy) NSString *titleString;
- (void)setupDescribe:(NSString *)describe count:(NSInteger)count;
- (void)setupStartTime:(NSDate *)startDate endTime:(NSDate *)endDate;
@end
