//
//  TXXLAlmanacMainView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/24.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, EventType) {
    EventType_Compass,
    EventType_Hours,
    EventType_Detail,
};
typedef NS_ENUM(NSInteger, DirectionType) {
    DirectionType_Left = 0,
    DirectionType_Right
};
@class TXXLAlmanacHomeModel;
typedef void (^TapEventBlock)(EventType type,NSInteger index);
typedef void (^TimeChangeBlock)(DirectionType direction,NSDate *date);
@interface TXXLAlmanacMainView : UIView
@property (nonatomic, copy) TapEventBlock clickBlock;
@property (nonatomic, copy) TimeChangeBlock timeBlock;
@property (nonatomic, strong) NSDate *currentDate;
- (void)viewDidAppearStartHeading;
- (void)viewDidDisappearStopHeading;
//设置内容界面上的数据
- (void)setupMessageContent:(TXXLAlmanacHomeModel *)model;
@end
