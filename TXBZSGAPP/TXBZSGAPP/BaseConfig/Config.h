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

static NSString * const kCalculateBannerId = @"51";
static NSString * const kCalculateNavigationId = @"52";
static NSString * const kCalculateHotId = @"53";
static NSString * const kCalculateChoiceId = @"54";
static NSString * const kCalculateSynthesizeId = @"55";

static NSString * const kAppVersionId = @"50";

static const CGFloat kHomeHeadButtonHeight = 44;
static NSString * const kGuide_Is_Has_Show = @"Guide_Is_Has_Show";

static NSString * const kFortune_Show_Change_Notice = @"Fortune_Show_Change_Notice";

static NSString * const kShare_Notice = @"Share_Notice";
#endif /* Config_h */
