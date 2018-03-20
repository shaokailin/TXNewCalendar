//
//  AppDelegate.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXXLRootTabBarVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) TXXLRootTabBarVC *rootTabBarVC;
@property (strong, nonatomic) UIWindow *window;
- (void)windowRootController;
@end

