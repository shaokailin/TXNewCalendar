//
//  TXSMFortuneProgressView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ProgressType)
{
    ProgressType_Today = 0,
    ProgressType_Week
};
@interface TXSMFortuneProgressView : UIView
- (instancetype)initWithFrame:(CGRect)frame progressType:(ProgressType)type;
- (void)setupScore:(NSDictionary *)dict time:(NSString *)time ;
@end
