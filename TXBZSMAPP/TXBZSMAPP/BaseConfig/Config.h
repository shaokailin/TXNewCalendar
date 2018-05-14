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
#import "TXXLDateManager.h"
#import "TXBZSMHappyManager.h"
#import "TXBZSMGodMessageModel.h"
typedef NS_ENUM(NSInteger,PlatformGoodsType){
    PlatformGoodsType_lazhu = 0,
    PlatformGoodsType_chashui = 1,
    PlatformGoodsType_huaping = 2,
    PlatformGoodsType_xiangyan = 3,
    PlatformGoodsType_gongpin = 4,
    PlatformGoodsType_None = -1,
};
typedef void (^WishHomeBlock)(NSInteger type,NSDictionary * data);;

static NSString * const kCalendarFormatter = @"yyyy-MM-dd";

static NSString * const kFortuneHomeHot = @"61";
static NSString * const kFortuneHomeAd = @"62";
static NSString * const kFortuneMessageAd = @"65";
static NSString * const kCalculateHotId = @"58";
static NSString * const kCalculateBannerId = @"56";
static NSString * const kCalculateNavigationId = @"57";
static NSString * const kCalculateChoiceId = @"59";
static NSString * const kCalculateSynthesizeId = @"60";
static NSString * const kBlessNavigationId = @"70";
static NSString * const kBlessAdId = @"68";

static const CGFloat kHomeHeadButtonHeight = 44;
static NSString * const kGuide_Is_Has_Show = @"Guide_Is_Has_Show";

static NSString * const kFortune_Show_Change_Notice = @"Fortune_Show_Change_Notice";

static NSString * const kShare_Notice = @"Share_Notice";

static NSString * const kBlessDataChangeNotice = @"BlessDataChangeNotice";
static NSString * const kWishDataChangeNotice = @"WishDataChangeNotice";
#endif /* Config_h */
