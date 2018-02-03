//
//  Config.h
//  LotteryCharts
//
//  Created by hsPlan on 2017/11/6.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#ifndef Config_h
#define Config_h
//单利对象
#import "TXXLSharedInstance.h"
#define kUserMessageManager [TXXLSharedInstance sharedInstance]
//颜色
#import "TXXLColorManager.h"
//自定义View
#import "TXXLViewManager.h"
//公共方法
#import "TXXLPublicMethod.h"
//公司的讨论群
static NSString const *kCompanyContactQQ = @"466438539";
//显示首页非罗盘的点击按钮
typedef void (^ShowTodayDetailBlock)(BOOL isShow);
//节假日加载数据操作
typedef void (^LoadFestivalsBlock)(BOOL isCanLoad);
#endif /* Config_h */
