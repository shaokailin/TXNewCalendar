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
#import "MiPushSDK.h"
#import "TXXLWebVC.h"
static NSString * const kAliAanaliticsKey = @"24796510";
static NSString * const kAliAanaliticsSecret = @"8530aeab85d9ed304efc98bc0afddb50";
static NSString * const kAliAanaliticssetChannel = @"APP Store";
NSString * const kMiPushRegisterIphone = @"isReigsterUserIphone";
static const BOOL kIsOnline = NO;
@interface AppDelegate ()<MiPushSDKDelegate,UNUserNotificationCenterDelegate>
{
    BOOL _isRegisterIphone;
    BOOL _isFackground;
}
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
    [self.window makeKeyAndVisible];
    [self registerAnalytics];
    [self registerMiPush];
    //点击通知打开app处理逻辑
    _isRegisterIphone = [kUserMessageManager getMessageManagerForBoolWithKey:kMiPushRegisterIphone];
    NSDictionary* userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if (userInfo) {
        NSString *messageId = [userInfo objectForKey:@"_id_"];
        if (messageId!=nil) {
            [MiPushSDK openAppNotify:messageId];
        }
        [self actionEventWithUserInfo:userInfo];
    }
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
- (void)registerMiPush {
    [MiPushSDK registerMiPush:self type:0 connect:YES];
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
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
#pragma mark - push
#pragma mark 注册push服务.
- (void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // 注册APNS成功, 注册deviceToken
    [MiPushSDK bindDeviceToken:deviceToken];
}

- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    // 注册APNS失败.
    // 自行处理.
}

#pragma mark Local And Push Notification
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    // 当同时启动APNs与内部长连接时, 把两处收到的消息合并. 通过miPushReceiveNotification返回
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    if (messageId!=nil) {
        [MiPushSDK openAppNotify:messageId];
    }
    [MiPushSDK handleReceiveRemoteNotification:userInfo];
}
- (void)application:(UIApplication *)application
didReceiveRemoteNotification:(NSDictionary *)userInfo
fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    NSString *messageId = [userInfo objectForKey:@"_id_"];
    [MiPushSDK openAppNotify:messageId];
}
// iOS10新加入的回调方法
// 应用在前台收到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    NSDictionary * userInfo = notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            [MiPushSDK handleReceiveRemoteNotification:userInfo];
        }
    } else {
        // Fallback on earlier versions
    }
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionSound);
    } else {
        // Fallback on earlier versions
    }
    
}

// 点击通知进入应用
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if (@available(iOS 10.0, *)) {
        if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
            _isFackground = YES;
            [MiPushSDK handleReceiveRemoteNotification:userInfo];
            NSString *messageId = [userInfo objectForKey:@"_id_"];
            if (messageId!=nil) {
                [MiPushSDK openAppNotify:messageId];
            }
        }
    } else {
        // Fallback on earlier versions
    }
    completionHandler();
}
#pragma mark MiPushSDKDelegate
- (void)miPushRequestSuccWithSelector:(NSString *)selector data:(NSDictionary *)data {
    if ([selector isEqualToString:@"registerMiPush:"]) {
        //注册成功
    }else if ([selector isEqualToString:@"registerApp"]) {
        
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        [self registerAlias];
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        //注册失败
    }else if ([selector isEqualToString:@"setAlias:"]){
        _isRegisterIphone = YES;
        [kUserMessageManager setMessageManagerForBoolWithKey:kMiPushRegisterIphone value:YES];
    }
}
- (void)registerAlias {
    if (!_isRegisterIphone) {
        [MiPushSDK setAlias:kUserMessageManager.iphoneIdentifier];
    }
}
//请求失败
- (void)miPushRequestErrWithSelector:(NSString *)selector error:(int)error data:(NSDictionary *)data {
    
}

- (void)miPushReceiveNotification:(NSDictionary*)data {
    // 1.当启动长连接时, 收到消息会回调此处
    // 2.[MiPushSDK handleReceiveRemoteNotification]
    //   当使用此方法后会把APNs消息导入到此
    NSInteger state = [UIApplication sharedApplication].applicationState;
    LSKLog(@"%ld",state);
    [self actionEventWithUserInfo:data];
}

- (void)actionEventWithUserInfo:(NSDictionary *)userInfo {
    if (userInfo && [userInfo isKindOfClass:[NSDictionary class]]) {
        NSInteger type = [[userInfo objectForKey:@"type"]integerValue];
        if (type == 1) {
            NSDictionary *apns = [userInfo objectForKey:@"aps"];
            id alert = [apns objectForKey:@"alert"];
            NSString *title = nil;
            if ([alert isKindOfClass:[NSDictionary class]]) {
                title = [alert objectForKey:@"body"];
            }else {
                title = alert;
            }
            NSInteger state = [UIApplication sharedApplication].applicationState;
            NSString *content = [userInfo objectForKey:@"url"];
            if (_rootTabBarVC && KJudgeIsNullData(content)) {
                if (state == 0 && !_isFackground) {
                    _isFackground = NO;
                    UIAlertView *alterView = [[UIAlertView alloc]initWithTitle:@"收到消息" message:title delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"去查看", nil];
                    @weakify(self)
                    [alterView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
                        if ([x integerValue] == 1) {
                            @strongify(self)
                            [self jumpWebView:title url:content];
                        }
                        [kUserMessageManager hidenAlertView];
                    }];
                    [kUserMessageManager showAlertView:alterView weight:3];
                }else {
                    _isFackground = NO;
                    [self jumpWebView:title url:content];
                }
            }
        }
    }
}
- (void)jumpWebView:(NSString *)title url:(NSString *)url {
    UINavigationController *navi = _rootTabBarVC.selectedViewController;
    TXXLWebVC *web = [[TXXLWebVC alloc]init];
    web.titleString = title;
    web.loadUrl = url;
    if (navi.viewControllers.count == 1) {
        web.hidesBottomBarWhenPushed = YES;
    }
    [navi pushViewController:web animated:YES];
}

- (NSString*)getOperateType:(NSString*)selector
{
    NSString *ret = nil;
    if ([selector hasPrefix:@"registerMiPush:"] ) {
        ret = @"客户端注册设备";
    }else if ([selector isEqualToString:@"unregisterMiPush"]) {
        ret = @"客户端设备注销";
    }else if ([selector isEqualToString:@"registerApp"]) {
        ret = @"注册App";
    }else if ([selector isEqualToString:@"bindDeviceToken:"]) {
        ret = @"绑定 PushDeviceToken";
    }else if ([selector isEqualToString:@"setAlias:"]) {
        ret = @"客户端设置别名";
    }else if ([selector isEqualToString:@"unsetAlias:"]) {
        ret = @"客户端取消别名";
    }else if ([selector isEqualToString:@"subscribe:"]) {
        ret = @"客户端设置主题";
    }else if ([selector isEqualToString:@"unsubscribe:"]) {
        ret = @"客户端取消主题";
    }else if ([selector isEqualToString:@"setAccount:"]) {
        ret = @"客户端设置账号";
    }else if ([selector isEqualToString:@"unsetAccount:"]) {
        ret = @"客户端取消账号";
    }else if ([selector isEqualToString:@"openAppNotify:"]) {
        ret = @"统计客户端";
    }else if ([selector isEqualToString:@"getAllAliasAsync"]) {
        ret = @"获取Alias设置信息";
    }else if ([selector isEqualToString:@"getAllTopicAsync"]) {
        ret = @"获取Topic设置信息";
    }
    
    return ret;
}
@end
