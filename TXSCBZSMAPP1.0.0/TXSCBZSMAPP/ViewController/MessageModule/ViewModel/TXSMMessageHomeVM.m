//
//  TXSMMessageHomeVM.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/11.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageHomeVM.h"
#import "TXSMMessageHomeAPI.h"
#import "TXXLCalculateHomeModel.h"
@interface TXSMMessageHomeVM ()
@property (nonatomic, strong) RACCommand *homeCommand;
@property (nonatomic, strong) RACCommand *messageCommand;
@end
@implementation TXSMMessageHomeVM
- (void)getHomeData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.messageCommand execute:nil];
}
- (RACCommand *)messageCommand {
    if (!_messageCommand) {
        @weakify(self)
        _page = 0;
        _messageCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXSMMessageHomeAPI getMessageHomeData:self.page type:self.type]];
        }];
        [_messageCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_messageCommand.executionSignals.flatten subscribeNext:^(TXSMMessageListModel *model) {
            @strongify(self)
            if (model.status == 0) {
                if (model.error_code == 10002 && model.status == 0) {
                    [SKHUD showMessageInWindowWithMessage:@"手机时间异常，请到系统时间设置，将其设为最新。"];
                }else {
                    [SKHUD showMessageInWindowWithMessage:model.msg];
                }
                [self sendFailureResult:0 error:nil];
            }else {
                [self sendSuccessResult:10 model:model.data];
                if (!self.adDict) {
                    [self.homeCommand execute:nil];
                }
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
            return [self requestWithPropertyEntity:[TXSMMessageHomeAPI getMessageHomeAd:self.contactId limit:self.limit]];
        }];
        [_homeCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_homeCommand.executionSignals.flatten subscribeNext:^(TXXLCalculateHomeModel *model) {
            @strongify(self)
            if (model.status == 0) {
                if (model.error_code == 10002 && model.status == 0) {
                    [SKHUD showMessageInWindowWithMessage:@"手机时间异常，请到系统时间设置，将其设为最新。"];
                }else {
                    [SKHUD showMessageInWindowWithMessage:model.msg];
                }
                [self sendFailureResult:20 error:nil];
            }else {
                self.adDict = model.data;
                [self sendSuccessResult:20 model:nil];
            }
        }];
    }
    return _homeCommand;
}
@end
