//
//  PPSSAppVersionManager.m
//  PPSSBusiness
//
//  Created by PPSSlan on 2017/10/12.
//  Copyright © 2017年 厦门花生计划网络科技有限公司. All rights reserved.
//

#import "PPSSAppVersionManager.h"
#import "PPSSAppVersionModel.h"
#import "PPSSAppVersionViewModel.h"
#import <YYModel/YYModel.h>
#import "NSDate+Extend.h"
#import "PPSSAppUpdateView.h"
static NSString * const kHomeAppVersionData = @"HomeAppVersionData";//缓存版本的数据
static NSString * const kHomeVersionData = @"HomeVersionData";//版本号的数据
static NSString * const kAppVersionShowDate = @"kTimeAppVersionCacheDate";//提示框显示时间
static NSString * const kAppVersionShowIsNotOpen = @"kAppVersionShowIsOpen";//是否打开提示框
@interface PPSSAppVersionManager()
//是否已经加载
@property (nonatomic, assign) BOOL m_hasLoadingAppVersion;
//是否获取了版本信息
@property (assign ,nonatomic) BOOL m_isHasAppVersion;
//是否显示提示
@property (assign ,nonatomic) BOOL m_isShowAlertAppVersion;

@property (nonatomic, strong) NSDictionary *m_appVersionDict;

@property (nonatomic, strong) PPSSAppVersionViewModel *m_appVersionViewModel;

@end
@implementation PPSSAppVersionManager
- (instancetype)init {
    if (self = [super init]) {
        [self getAppDefaultData];
    }
    return self;
}
//加载获取版本号
- (void)loadAppVersion {
    if (!_m_hasLoadingAppVersion && !_m_isHasAppVersion) {
        [kUserMessageManager setMessageManagerForObjectWithKey:kHomeVersionData value:[LSKPublicMethodUtil getAppVersion]];
        self.m_hasLoadingAppVersion = YES;
        [self.m_appVersionViewModel getAppVersionData];
    }
    if(self.m_appVersionDict) {
        [self showAppVersionAlert];
    }
}

- (PPSSAppVersionViewModel *)m_appVersionViewModel {
    if (!_m_appVersionViewModel) {
        @weakify(self)
        _m_appVersionViewModel = [[PPSSAppVersionViewModel alloc]initWithSuccessBlock:^(NSUInteger identifier, PPSSAppVersionModel *model) {
            @strongify(self)
            self.m_hasLoadingAppVersion = NO;
            self.m_isHasAppVersion = YES;
            if (model.status == 1 && KJudgeIsArrayAndHasValue(model.data)) {
                NSDictionary *dict = [model.data objectAtIndex:0];
                
                if ([NSString compareVersionWithCurrent:[LSKPublicMethodUtil getAppVersion] newVersion:KNullTransformString([dict objectForKey:@"v"])]) {
                    self.m_appVersionDict = dict;
                    [kUserMessageManager setMessageManagerForObjectWithKey:kHomeAppVersionData value:dict];
                    [self showAppVersionAlert];
                }else
                {
                    self.m_appVersionDict = nil;
                    [kUserMessageManager removeMessageManagerForKey:kHomeAppVersionData];
                    [kUserMessageManager removeMessageManagerForKey:kAppVersionShowDate];
                    [kUserMessageManager removeMessageManagerForKey:kAppVersionShowIsNotOpen];
                }
            }else {
                self.m_appVersionDict = nil;
                [kUserMessageManager removeMessageManagerForKey:kHomeAppVersionData];
                [kUserMessageManager removeMessageManagerForKey:kAppVersionShowDate];
                [kUserMessageManager removeMessageManagerForKey:kAppVersionShowIsNotOpen];
            }
        } failure:^(NSUInteger identifier, NSError *error) {
            @strongify(self)
            self.m_hasLoadingAppVersion = NO;
            self.m_isHasAppVersion = NO;
            [self showAppVersionAlert];
        }];
        _m_appVersionViewModel.isShowAlertAndHiden = NO;
    }
    return _m_appVersionViewModel;
}

-(void)showAppVersionAlert {
    if ([NSString compareVersionWithCurrent:[LSKPublicMethodUtil getAppVersion] newVersion:KNullTransformString([self.m_appVersionDict objectForKey:@"v"])]) {
        NSInteger type = [[self.m_appVersionDict objectForKey:@"ismust"] integerValue];
        
        if (!_m_isShowAlertAppVersion && type != 0) {
            if (type == 2) {
                BOOL isNotOpen = [kUserMessageManager getMessageManagerForBoolWithKey:kAppVersionShowIsNotOpen];
                NSInteger time = [kUserMessageManager getMessageManagerForIntegerWithKey:kAppVersionShowDate];
                if (isNotOpen) {
                    return;
                }
                if ([NSDate isTimestampToToday:time])
                {
                    return;
                }else
                {
                    [kUserMessageManager setMessageManagerForIntegerWithKey:kAppVersionShowDate value:[[NSDate date]timeIntervalSince1970]];
                }
            }
            self.m_isShowAlertAppVersion = YES;
            @weakify(self)
            PPSSAppUpdateView *updateView = [[PPSSAppUpdateView alloc]initWithTitle:KNullTransformString([self.m_appVersionDict objectForKey:@"title"]) content:KNullTransformString([self.m_appVersionDict objectForKey:@"content"]) type:type];
            updateView.clickblock = ^(NSInteger index) {
                @strongify(self)
                if (index == 2) {
                    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[self.m_appVersionDict objectForKey:@"url"]]];
                }else {
                    if (type == 1) {
                        exit(0);
                    }else if(type == 2) {
                        [kUserMessageManager setMessageManagerForBoolWithKey:kAppVersionShowIsNotOpen value:YES];
                    }
                }
                if (type != 1) {
                    self.m_appVersionDict = nil;
                }
                self.m_isShowAlertAppVersion = NO;
                [kUserMessageManager hidenAlertView];
            };
            [kUserMessageManager showAlertView:updateView weight:0];
        }
    }
}

//获取缓存版本的数据
-(void)getAppDefaultData
{
    NSString *version = [kUserMessageManager getMessageManagerForObjectWithKey:kHomeVersionData];
    if (version && ([version isEqualToString:[LSKPublicMethodUtil getAppVersion]])) {
        NSDictionary *dict = [kUserMessageManager getMessageManagerForObjectWithKey:kHomeAppVersionData];
        if (dict) {
            self.m_appVersionDict = dict;
            
            if (![NSString compareVersionWithCurrent:[LSKPublicMethodUtil getAppVersion] newVersion:KNullTransformString([self.m_appVersionDict objectForKey:@"v"])]) {
                self.m_appVersionDict = nil;
                [kUserMessageManager removeMessageManagerForKey:kHomeAppVersionData];
                [kUserMessageManager removeMessageManagerForKey:kAppVersionShowDate];
                [kUserMessageManager removeMessageManagerForKey:kAppVersionShowIsNotOpen];
            }
        }
    }else
    {
        [kUserMessageManager removeMessageManagerForKey:kHomeAppVersionData];
        [kUserMessageManager removeMessageManagerForKey:kAppVersionShowDate];
        [kUserMessageManager removeMessageManagerForKey:kAppVersionShowIsNotOpen];
    }
    
}

+ (BOOL)isHasNewVersion {
    NSDictionary *dict = [kUserMessageManager getMessageManagerForObjectWithKey:kHomeAppVersionData];
    NSString *version = [dict objectForKey:@"version"];
    if (dict && KJudgeIsNullData(version)) {
        return [NSString compareVersionWithCurrent:[LSKPublicMethodUtil getAppVersion] newVersion:KNullTransformString(version)];
    }
    return false;
}

+ (void)jumpUpdateVersion {
    NSDictionary *dict = [kUserMessageManager getMessageManagerForObjectWithKey:kHomeAppVersionData];
    if (dict && KJudgeIsNullData([dict objectForKey:@"url"])) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[dict objectForKey:@"url"]]];
    }
}
@end
