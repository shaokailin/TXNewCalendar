//
//  TXXLCalculateHomeVM.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalculateHomeVM.h"
#import "TXXLCalculateModuleAPI.h"
@interface TXXLCalculateHomeVM ()
@property (nonatomic, strong) RACCommand *homeCommand;
@end
@implementation TXXLCalculateHomeVM
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
                [self sendFailureResult:0 error:nil];
            }else {
                [self sendSuccessResult:0 model:model.data];
            }
        }];
    }
    return _homeCommand;
}
@end
