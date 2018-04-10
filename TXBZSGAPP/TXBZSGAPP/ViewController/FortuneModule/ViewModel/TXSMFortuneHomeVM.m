//
//  TXSMFortuneHomeVM.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeVM.h"
#import "TXSMFortuneHomeAPI.h"
#import "TXXLCalculateHomeModel.h"
#import "TXSMFortuneHomeModel.h"
@interface TXSMFortuneHomeVM ()
@property (nonatomic, strong) RACCommand *homeCommand;
@property (nonatomic, strong) RACCommand *messageCommand;
@end
@implementation TXSMFortuneHomeVM
- (void)getHomeData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.messageCommand execute:nil];
}
- (RACCommand *)messageCommand {
    if (!_messageCommand) {
        @weakify(self)
        _messageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXSMFortuneHomeAPI getForuneHomeMessage:self.xingzuo]];
        }];
        [_messageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:10 error:nil];
        }];
        [_messageCommand.executionSignals.flatten subscribeNext:^(TXXLCalculateHomeModel *model) {
            @strongify(self)
            if (model.status == 0) {
                if (model.error_code == 10002 && model.status == 0) {
                    [SKHUD showMessageInWindowWithMessage:@"手机时间异常，请到系统时间设置，将其设为最新。"];
                }else {
                    [SKHUD showMessageInWindowWithMessage:model.msg];
                }
                [self sendFailureResult:10 error:nil];
            }else {
                [self sendSuccessResult:10 model:model.data];
//                [self.homeCommand execute:nil];
            }
        }];
    }
    return _messageCommand;
}
- (RACCommand *)homeCommand {
    if (!_homeCommand) {
        @weakify(self)
        _homeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXSMFortuneHomeAPI getForuneHomeData:self.contactId limit:self.limit]];
        }];
        [_homeCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_homeCommand.executionSignals.flatten subscribeNext:^(TXSMFortuneHomeModel *model) {
            @strongify(self)
            if (model.status == 0) {
                if (model.error_code == 10002 && model.status == 0) {
                    [SKHUD showMessageInWindowWithMessage:@"手机时间异常，请到系统时间设置，将其设为最新。"];
                }else {
                    [SKHUD showMessageInWindowWithMessage:model.msg];
                }
                [self sendFailureResult:0 error:nil];
            }else {
                
                [self sendSuccessResult:20 model:model.data];
            }
        }];
    }
    return _homeCommand;
}
@end
