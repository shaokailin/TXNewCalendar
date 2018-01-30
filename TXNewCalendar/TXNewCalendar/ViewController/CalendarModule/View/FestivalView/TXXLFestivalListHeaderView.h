//
//  TXXLFestivalListHeaderView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger,FestivalShowType) {
    FestivalShowType_Public = 0,
    FestivalShowType_TwentyFour,
    FestivalShowType_Holidays
};
typedef void (^HeaderClickBlock)(FestivalShowType showType);
@interface TXXLFestivalListHeaderView : UIView
@property (nonatomic, copy) HeaderClickBlock clickBlock;
@end
