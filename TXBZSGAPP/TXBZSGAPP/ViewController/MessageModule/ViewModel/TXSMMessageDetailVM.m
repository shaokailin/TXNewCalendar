//
//  TXSMMessageDetailVM.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/14.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageDetailVM.h"
#import "TXSMMessageHomeAPI.h"
#import "TXXLCalculateHomeModel.h"
@interface TXSMMessageDetailVM ()
@property (nonatomic, strong) RACCommand *detailCommand;
@end
@implementation TXSMMessageDetailVM
- (void)getDetailData:(BOOL)isPull {
    if (!isPull) {
        [SKHUD showLoadingDotInWindow];
    }
    [self.detailCommand execute:nil];
}
- (RACCommand *)detailCommand {
    if (!_detailCommand) {
        @weakify(self)
        _detailCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            @strongify(self)
            return [self requestWithPropertyEntity:[TXSMMessageHomeAPI getMessageDetail:self.article_id]];
        }];
        [_detailCommand.errors subscribeNext:^(NSError * _Nullable x) {
            @strongify(self)
            [self sendFailureResult:0 error:nil];
        }];
        [_detailCommand.executionSignals.flatten subscribeNext:^(TXXLCalculateHomeModel *model) {
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
            }
        }];
    }
    return _detailCommand;
}
@end
