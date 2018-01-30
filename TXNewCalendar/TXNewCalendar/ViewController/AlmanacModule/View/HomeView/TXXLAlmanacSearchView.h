//
//  TXXLAlimanacSearchView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, SearchEventType) {
    SearchEventType_Marry = 0,
    SearchEventType_Open,
    SearchEventType_Housing,
    SearchEventType_All,
};
typedef void(^SearchBlock)(SearchEventType eventType);
@interface TXXLAlmanacSearchView : UIView
@property (nonatomic, copy) SearchBlock clickBlock;
@end
