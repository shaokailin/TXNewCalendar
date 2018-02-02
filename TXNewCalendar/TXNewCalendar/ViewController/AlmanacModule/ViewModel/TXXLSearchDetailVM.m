//
//  TXXLSearchDetailVM.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSearchDetailVM.h"
#import "TXXLAlmanacModuleAPI.h"
@interface TXXLSearchDetailVM ()
@property (nonatomic, assign) BOOL isChangeResult;
@property (nonatomic, strong) RACCommand *detailCommand;
@end
@implementation TXXLSearchDetailVM
- (void)getSearchDetail:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInView:self.currentView];
    }
    [self.detailCommand execute:nil];
}
- (RACCommand *)detailCommand {
    if (!_detailCommand) {
        @weakify(self)
        _isChangeResult = YES;
        _detailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXXLAlmanacModuleAPI getSearchDetailWithStart:self.startTime endTime:self.endTime text:self.text isShowWeekend:self.isShowWeenken isYj:self.isAvoid]];
        }];
        [_detailCommand.executionSignals.flatten subscribeNext:^(TXXLSearchDetailListModel *model) {
            @strongify(self)
            if (model.status == 1) {
                self.detailModel = model;
                self.isChangeResult = NO;
                [self sendSuccessResult:0 model:nil];
            }else {
                [self setupErrorData];
                [self sendFailureResult:0 error:nil];
            }
        }];
        [_detailCommand.errors subscribeNext:^(NSError * _Nullable x) {
           @strongify(self)
            [self setupErrorData];
            [self sendFailureResult:0 error:nil];
        }];
    }
    return _detailCommand;
}
- (void)setupErrorData {
    if (self.isChangeResult) {
        if (self.detailModel) {
            self.detailModel.detail = nil;
            self.detailModel.num = 0;
        }
    }
}

- (void)setIsAvoid:(BOOL)isAvoid {
    _isChangeResult = _isAvoid == isAvoid;
    _isAvoid = isAvoid;
}
- (void)setStartTime:(NSString *)startTime {
    _isChangeResult = ![startTime isEqualToString:_startTime];
    _startTime = startTime;
}
- (void)setEndTime:(NSString *)endTime {
    _isChangeResult = ![endTime isEqualToString:_endTime];
    _endTime = endTime;
}
@end
