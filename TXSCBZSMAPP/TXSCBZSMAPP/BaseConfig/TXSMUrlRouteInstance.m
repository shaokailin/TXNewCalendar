//
//  TXSMUrlRouteInstance.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/20.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMUrlRouteInstance.h"
#import "SynthesizeSingleton.h"
#import "TXXLWebVC.h"
#import "AppDelegate.h"
#import "TXXLCalendarDateProtocol.h"
#import "TXXLHoursDetailVC.h"
#import "TXXLSuitAvoidVC.h"
#import "TXXLSearchDetailVC.h"
NSString * const kAppOpenKey = @"txcalendar://";

//type = 1 跳转url  type == 2 tabbar select :index date  type: 3:现代文 date 4。时辰宜忌 date ，5 吉凶宜忌 title ji:0-1
@implementation TXSMUrlRouteInstance
+ (BOOL)handleOpenURL:(NSURL *)url {
    NSString *urlString = [url.absoluteString stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlString rangeOfString:kAppOpenKey].location != NSNotFound) {
        NSString *content = [urlString substringFromIndex:kAppOpenKey.length];
        if (KJudgeIsNullData(content)) {
            NSDictionary *dict = [LSKPublicMethodUtil jsonDataTransformToDictionary:[content dataUsingEncoding:NSUTF8StringEncoding]];
            if (dict) {
                [[self class]actionEventHandle:dict];
            }
            return NO;
        }
        return NO;
    }
    return NO;
}

+ (BOOL)actionEventHandle:(NSDictionary *)dict {
    if ([dict.allKeys containsObject:@"type"]) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        if ([delegate.window.rootViewController isKindOfClass:[TXXLRootTabBarVC class]]) {
            NSInteger type = [[dict objectForKey:@"type"] integerValue];
            if(type == 1) {
                return [[self class]jumpWebView:[dict objectForKey:@"title"] url:[dict objectForKey:@"url"]];
            }else if (type == 2 && [dict.allKeys containsObject:@"index"]){
                return [[self class]selectTabbarIndex:[[dict objectForKey:@"index"]integerValue] date:[dict objectForKey:@"date"]];
            }else if (type == 3 || type == 4|| type == 5) {
                return [[self class]jumpAlmanacVC:type dict:dict];
            }
        }else {
            return NO;
        }
    }
    return NO;
}
+ (BOOL)jumpAlmanacVC:(NSInteger)type dict:(NSDictionary *)dict {
    if (type < 5) {
        NSString *dateString = [dict objectForKey:@"date"];
        if (KJudgeIsNullData(dateString)) {
            NSDate *dateDate = [NSDate stringTransToDate:dateString withFormat:kCalendarFormatter];
            if (dateDate) {
                UIViewController *controller = nil;
                if (type == 3) {
                    TXXLSuitAvoidVC *suitVC = [[TXXLSuitAvoidVC alloc]init];
                    suitVC.currentDate = dateDate;
                    suitVC.index = 0;
                    controller = suitVC;
                }else if (type == 4) {
                    TXXLHoursDetailVC *hourVC = [[TXXLHoursDetailVC alloc]init];
                    hourVC.currentDate = dateDate;
                    controller = hourVC;
                }
                AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
                UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
                if (navi.viewControllers.count == 1) {
                    controller.hidesBottomBarWhenPushed = YES;
                }
                [navi pushViewController:controller animated:YES];
            }
        }
    }else {
        NSString *searchString = [dict objectForKey:@"title"];
        if (KJudgeIsNullData(searchString)) {
            NSArray *array = [NSArray arrayWithPlist:@"category"];
            BOOL isHas = NO;
            for (int i = 0; i < array.count; i++) {
                NSDictionary *dict = [array objectAtIndex:i];
                NSArray *arr = [dict objectForKey:@"detail"];
                if ([arr containsObject:searchString]) {
                    isHas = YES;
                    break;
                }
            }
            if (!isHas) {
                return NO;
            }
            BOOL isAvoid = [[dict objectForKey:@"ji"]boolValue];
            TXXLSearchDetailVC *detailVC = [[TXXLSearchDetailVC alloc]init];
            detailVC.titleString = searchString;
            detailVC.isAvoid = isAvoid;
            AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
            if (navi.viewControllers.count == 1) {
                detailVC.hidesBottomBarWhenPushed = YES;
            }
            [navi pushViewController:detailVC animated:YES];
        }
    }
    return NO;
}
+ (BOOL)selectTabbarIndex:(NSInteger)index date:(NSString *)date {
    if (index <= 2 && index >= 0) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
        if (navi.viewControllers.count > 1) {
            [navi popToRootViewControllerAnimated:NO];
        }
        delegate.rootTabBarVC.selectedIndex = index;
        if (index < 2 && KJudgeIsNullData(date)) {
            NSDate *dateDate = [NSDate stringTransToDate:date withFormat:kCalendarFormatter];
            if (dateDate) {
                UINavigationController *navi1 = delegate.rootTabBarVC.selectedViewController;
                UIViewController<TXXLCalendarDateProtocol> *vc = (UIViewController<TXXLCalendarDateProtocol> *)navi1.topViewController;
                [vc changeShowDate:dateDate];
            }
        }
        return YES;
    }
    return NO;
}
+ (BOOL)jumpWebView:(NSString *)title url:(NSString *)url {
    if (KJudgeIsNullData(url)) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
        TXXLWebVC *detailVC = [[TXXLWebVC alloc]init];
        detailVC.title = title;
        detailVC.loadUrl = url;
        if (navi.viewControllers.count == 1) {
            detailVC.hidesBottomBarWhenPushed = YES;
        }
        [navi pushViewController:detailVC animated:YES];
    }
    return NO;
}
@end
