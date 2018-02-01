//
//  TXXLAlmanacHomeVM.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLAlmanacHomeVM.h"
#import "TXXLAlmanacModuleAPI.h"

@interface TXXLAlmanacHomeVM ()
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSUInteger currentLoading;
@property (nonatomic, strong) RACCommand *almanacHomeCommand;
@end
@implementation TXXLAlmanacHomeVM
- (void)getAlmanacHomeData:(BOOL)isFirst {
    if (isFirst) {
        [SKHUD showLoadingDotInWindow];
    }
    if (self.isLoading && _currentLoading > 0) {
        [self removeLoadingWithIdentifier:_currentLoading];
        _currentLoading = -1;
    }
    [self.almanacHomeCommand execute:nil];
}
- (void)reurnCurrentLoadingIndentifier:(NSUInteger)index {
    _currentLoading = index;
}
- (RACCommand *)almanacHomeCommand {
    if (!_almanacHomeCommand) {
        @weakify(self)
        _currentLoading = -1;
        _almanacHomeCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLAlmanacModuleAPI getAlmanacHomeData:self.dateString]];
        }];
        [_almanacHomeCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self)
            self.currentLoading = -1;
            self.messageModel = nil;
            [self sendFailureResult:0 error:nil];
        }];
        [_almanacHomeCommand.executionSignals.flatten subscribeNext:^(TXXLAlmanacHomeModel *model) {
            @strongify(self)
            self.currentLoading = -1;
            if (model.error_code != 0) {
                self.messageModel = nil;
                [self sendFailureResult:0 error:nil];
            }else {
                self.messageModel = model;
                [self sendSuccessResult:0 model:model];
            }
        }];
        [[_almanacHomeCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self)
            if ([x integerValue] == 1) {
                self.isLoading = YES;
            }else {
                self.isLoading = NO;
            }
        }];
        
    }
    return _almanacHomeCommand;
}
@end
