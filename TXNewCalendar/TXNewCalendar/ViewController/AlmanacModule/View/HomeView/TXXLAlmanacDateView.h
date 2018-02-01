//
//  TXXLAlmanacDateView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, DateChangeType) {
    DateChangeType_Prev = 0,
    DateChangeType_Next = 1
};
typedef void (^AlimanacDateChangeBlock)(DateChangeType type);
@interface TXXLAlmanacDateView : UIView
//点击修改日期的回调
@property (nonatomic, copy) AlimanacDateChangeBlock changeDateBlock;
- (void)setupDateContent:(NSDate *)date;
- (void)setupChinessDateData:(NSDictionary *)jinian week:(NSString *)week shengxiao:(NSString *)shengxiao nongli:(NSDictionary *)nongli;
@end
