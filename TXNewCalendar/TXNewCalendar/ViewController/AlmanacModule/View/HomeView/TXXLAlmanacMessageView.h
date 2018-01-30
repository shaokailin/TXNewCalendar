//
//  TXXLAlimanacMessageView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MessageEventType) {
    MessageEventType_Compass,
};
typedef void (^MessageBlock) (MessageEventType type);
@interface TXXLAlmanacMessageView : UIView
@property (nonatomic, copy) MessageBlock clickBlock;
//罗盘旋转
- (void)compassTranform:(CGFloat)radius;
@end
