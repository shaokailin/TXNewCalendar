//
//  AppDelegate.h
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXXLRootTabBarVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) TXXLRootTabBarVC *rootTabBarVC;
- (void)windowRootController;
@end

