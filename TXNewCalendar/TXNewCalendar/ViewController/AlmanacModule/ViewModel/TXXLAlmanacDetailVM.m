//
//  TXXLAlmanacDetailVM.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacDetailVM.h"
#import "TXXLAlmanacModuleAPI.h"
@interface TXXLAlmanacDetailVM ()
@property (nonatomic, strong) RACCommand *almanacDetailCommand;
@end
@implementation TXXLAlmanacDetailVM
- (void)getAlmanacDetailData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.almanacDetailCommand execute:nil];
}
- (RACCommand *)almanacDetailCommand {
    if (!_almanacDetailCommand) {
        @weakify(self)
        _almanacDetailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLAlmanacModuleAPI getAlmanacDetailData:self.dateString]];
        }];
        [_almanacDetailCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_almanacDetailCommand.executionSignals.flatten subscribeNext:^(TXXLAlmanacDetailModel *model) {
            @strongify(self)
            if (model.error_code != 0) {
                [self sendFailureResult:0 error:nil];
            }else {
                [self sendSuccessResult:0 model:model];
            }
        }];
    }
    return _almanacDetailCommand;
}
@end
