//
//  TXXLSearchMoreVM.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchMoreVM.h"
#import "TXXLAlmanacModuleAPI.h"
@interface TXXLSearchMoreVM ()
@property (nonatomic, strong) RACCommand *moreListCommand;
@end
@implementation TXXLSearchMoreVM
- (void)getSearchMoreList:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.moreListCommand execute:nil];
}
- (RACCommand *)moreListCommand {
    if (!_moreListCommand) {
        @weakify(self)
        _moreListCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLAlmanacModuleAPI getSearchMoreListWithIsYj:self.isAvoid]];
        }];
        [_moreListCommand.executionSignals.flatten subscribeNext:^(TXXLSearchMoreListModel *model) {
            if (model.status == 1) {
                [self sendSuccessResult:0 model:model.data];
            }else {
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_moreListCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _moreListCommand;
}
@end
