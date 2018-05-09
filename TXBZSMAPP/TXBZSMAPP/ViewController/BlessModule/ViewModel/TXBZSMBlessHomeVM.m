//
//  TXBZSMBlessHomeVM.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeVM.h"
#import "TXXLCalculateModuleAPI.h"
#import "TXXLCalculateHomeModel.h"
@interface TXBZSMBlessHomeVM ()
@property (nonatomic, strong) RACCommand *homeCommand;
@end
@implementation TXBZSMBlessHomeVM
- (void)getHomeData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.homeCommand execute:nil];
}
- (RACCommand *)homeCommand {
    if (!_homeCommand) {
        @weakify(self)
        _homeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLCalculateModuleAPI getCalculateHomeData:self.contactId limit:self.limit]];
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
                [self sendFailureResult:0 error:nil];
            }else {
                [self sendSuccessResult:0 model:model.data];
            }
        }];
    }
    return _homeCommand;
}
@end
