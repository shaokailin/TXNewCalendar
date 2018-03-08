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

static NSString * const kCalculateBannerId = @"11";
static NSString * const kCalculateNavigationId = @"13";
static NSString * const kCalculateFeelingId = @"14";
static NSString * const kCalculateFortuneId = @"15";
static NSString * const kCalculateUnbindNameId = @"17";
static NSString * const kCalculateNoticeId = @"17";
static const CGFloat kHomeHeadButtonHeight = 44;
static NSString * const kGuide_Is_Has_Show = @"Guide_Is_Has_Show";
#endif /* Config_h */
