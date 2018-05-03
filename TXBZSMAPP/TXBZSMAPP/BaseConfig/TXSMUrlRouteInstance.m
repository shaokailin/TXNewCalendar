//
//  TXSMUrlRouteInstance.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/20.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMUrlRouteInstance.h"
#import "SynthesizeSingleton.h"
#import "TXSMMessageDetailVC.h"
#import "AppDelegate.h"
NSString * const kAppOpenKey = @"txbzsm://";

//type = 1 跳转url  type == 2 tabbar select :index
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
                return [[self class]selectTabbarIndex:[[dict objectForKey:@"index"]integerValue]];
            }
        }else {
            return NO;
        }
    }
    return NO;
}
+ (BOOL)selectTabbarIndex:(NSInteger)index {
    if (index <= 2 && index >= 0) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
        if (navi.viewControllers.count > 1) {
            [navi popToRootViewControllerAnimated:NO];
        }
        delegate.rootTabBarVC.selectedIndex = index;
        return YES;
    }
    return NO;
}
+ (BOOL)jumpWebView:(NSString *)title url:(NSString *)url {
    if (KJudgeIsNullData(url)) {
        AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UINavigationController *navi = delegate.rootTabBarVC.selectedViewController;
        TXSMMessageDetailVC *detailVC = [[TXSMMessageDetailVC alloc]init];
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
