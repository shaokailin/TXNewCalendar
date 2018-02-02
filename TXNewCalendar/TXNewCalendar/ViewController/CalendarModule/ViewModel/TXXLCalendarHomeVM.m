//
//  TXXLCalendarHomeVM.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCalendarHomeVM.h"
#import "TXXLCalendarModuleAPI.h"
@interface TXXLCalendarHomeVM ()
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSUInteger currentLoading;
@property (nonatomic, strong) RACCommand *festivalsCommand;
@end
@implementation TXXLCalendarHomeVM
- (void)getFestivalsList {
    if (self.isLoading && _currentLoading > 0) {
        [self removeLoadingWithIdentifier:_currentLoading];
        _currentLoading = -1;
    }
    [self.festivalsCommand execute:nil];
}
- (void)reurnCurrentLoadingIndentifier:(NSUInteger)index {
    _currentLoading = index;
}
- (RACCommand *)festivalsCommand {
    if (!_festivalsCommand) {
        @weakify(self)
        _currentLoading = -1;
        _festivalsCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLCalendarModuleAPI getFestivalsList:self.time]];
        }];
        [_festivalsCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            self.currentLoading = -1;
            [self sendFailureResult:0 error:nil];
        }];
        [_festivalsCommand.executionSignals.flatten subscribeNext:^(TXXLFestivalsListModel *model) {
            @strongify(self)
            self.currentLoading = -1;
            if (model.status == 1) {
                [self sendFailureResult:0 error:nil];
            }else {
                self.festivalsList = model.data;
                [self sendSuccessResult:0 model:model];
            }
        }];
        [[_festivalsCommand.executing skip:1] subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self)
            if ([x integerValue] == 1) {
                self.isLoading = YES;
            }else {
                self.isLoading = NO;
            }
        }];
        
    }
    return _festivalsCommand;
}

@end
