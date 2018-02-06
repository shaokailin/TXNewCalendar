//
//  AppDelegate.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "AppDelegate.h"
#import "TXXLRootTabBarVC.h"
#import "TXXLGuideVC.h"
#import "PPSSAppVersionManager.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>
static NSString * const kAliAanaliticsKey = @"24796510";
static NSString * const kAliAanaliticsSecret = @"8530aeab85d9ed304efc98bc0afddb50";
static NSString * const kAliAanaliticssetChannel = @"APP Store";
static const BOOL kIsOnline = YES;
@interface AppDelegate ()
@property (nonatomic, strong) TXXLRootTabBarVC *rootTabBarVC;
@property (nonatomic, strong) PPSSAppVersionManager *appVersionManager;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    //设置导航栏的全局样式
    [LSKViewFactory setupMainNavigationBgColor:KColorUtilsString(kNavigationBackground_Color) titleFont:kNavigationTitle_Font titleColor:KColorUtilsString(kNavigationTitle_Color) lineColor:KColorUtilsString(kNavigationLine_Color)];
    [self windowRootController];
    [self registerAnalytics];
    [self.window makeKeyAndVisible];
    return YES;
}
- (void)registerAnalytics {
    // 获取MAN服务
    ALBBMANAnalytics *man = [ALBBMANAnalytics getInstance];
    if (!kIsOnline) {
        // 打开调试日志，线上建议关闭
        [man turnOnDebug];
    }
    // 初始化MAN
    [man initWithAppKey:kAliAanaliticsKey secretKey:kAliAanaliticsSecret];
    [man setAppVersion:[LSKPublicMethodUtil getAppVersion]];
    [man setChannel:kAliAanaliticssetChannel];
}
- (void)windowRootController {
    BOOL isHasShow = [kUserMessageManager getMessageManagerForBoolWithKey:kGuide_Is_Has_Show];
    if (!isHasShow) {
        TXXLGuideVC *guideVC = [[TXXLGuideVC alloc]init];
        self.window.rootViewController = guideVC;
    }else {
        self.window.rootViewController = self.rootTabBarVC;
    }
}
- (TXXLRootTabBarVC *)rootTabBarVC {
    if (!_rootTabBarVC) {
        _rootTabBarVC = [[TXXLRootTabBarVC alloc]init];
    }
    return _rootTabBarVC;
}
#pragma mark -版本更新
- (PPSSAppVersionManager *)appVersionManager {
    if (!_appVersionManager) {
        _appVersionManager = [[PPSSAppVersionManager alloc]init];
    }
    return _appVersionManager;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [self.appVersionManager loadAppVersion];
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
