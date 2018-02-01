//
//  TXXLAlimanacHomeLbl4View.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/23.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ContentType) {
    ContentType_Fit,
    ContentType_Avoid
};
@interface TXXLAlimanacHomeLbl4View : UIView
@property (nonatomic, copy) ShowTodayDetailBlock detailBlock;
- (instancetype)initWithType:(ContentType)type;
- (void)setupLblType4Content:(NSString *)content;
@end
