//
//  TXXLFestivalCountDownHeaderView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/26.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^MoreBlock)(BOOL isMore);
@interface TXXLFestivalCountDownHeaderView : UIView
@property (nonatomic, copy) MoreBlock moreBlock;
@end
