//
//  TXXLSolarTermAndFestivalVM.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSolarTermAndFestivalVM.h"
#import "TXXLCalendarModuleAPI.h"
#import "TXXLHolidaysListModel.h"
#import "TXXLFestivalsListModel.h"
@interface TXXLSolarTermAndFestivalVM ()
@property (nonatomic, strong) RACCommand *festivalCommand;
@end
@implementation TXXLSolarTermAndFestivalVM
- (void)getSolarTermAndFestivalList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.festivalCommand execute:nil];
}
- (RACCommand *)festivalCommand {
    if (!_festivalCommand) {
        @weakify(self)
        _festivalCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLCalendarModuleAPI getFestivalsList:self.time type:self.type]];
        }];
        [_festivalCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_festivalCommand.executionSignals.flatten subscribeNext:^(LSKBaseResponseModel *model) {
            @strongify(self)
            if (model.status == 0) {
                if (model.error_code == 10002 && model.status == 0) {
                    [SKHUD showMessageInWindowWithMessage:@"手机时间异常，请到系统时间设置，将其设为最新。"];
                }else {
                    [SKHUD showMessageInWindowWithMessage:model.msg];
                }
                [self sendFailureResult:0 error:nil];
            }else {
                if (self.type != 2) {
                    TXXLFestivalsListModel *model1 = (TXXLFestivalsListModel *)model;
                    [self sendSuccessResult:0 model:model1.data];
                }else {
                    TXXLHolidaysListModel *model1 = (TXXLHolidaysListModel *)model;
                    [self sendSuccessResult:0 model:model1.data];
                }
            }
        }];
    }
    return _festivalCommand;
}
@end
