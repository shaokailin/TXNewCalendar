//
//  TXBZSMTodayNavigationView.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NavigationBlock)(NSInteger type);//type :1:返回  2.分享
@interface TXBZSMTodayNavigationView : UIView
@property (nonatomic, copy) NavigationBlock navigationBlock;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL isBack;
@property (nonatomic, assign) BOOL isShare;
@end
