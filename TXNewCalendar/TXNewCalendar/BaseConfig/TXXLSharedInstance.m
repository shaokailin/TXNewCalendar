//
//  TXXLSharedInstance.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSharedInstance.h"
#import "SynthesizeSingleton.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>
@interface TXXLSharedInstance ()
{
    BOOL _isShow;
    NSInteger _currentWeight;
    BOOL _alterCount;
}
@property (nonatomic, strong) NSMutableArray *alertListArray;
@end
@implementation TXXLSharedInstance
SYNTHESIZE_SINGLETON_CLASS(TXXLSharedInstance);


#pragma mark -统计
- (void)analiticsViewAppear:(UIViewController *)vc {
    [[ALBBMANPageHitHelper getInstance] pageAppear:vc];
}
- (void)analiticsViewDisappear:(UIViewController *)vc {
    [[ALBBMANPageHitHelper getInstance] pageDisAppear:vc];
}
- (void)setupViewProperties:(UIViewController *)vc url:(NSString *)url name:(NSString *)name {
    name = KJudgeIsNullData(name)?name:@"未定";
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"pageName", nil];
    if (url) {
        [dict setObject:url forKey:@"h5统计"];
    }
    [[ALBBMANPageHitHelper getInstance] updatePageProperties:vc properties:dict];
}
- (void)analiticsPay:(NSInteger)payType {
    ALBBMANCustomHitBuilder *customBuilder = [[ALBBMANCustomHitBuilder alloc] init];
    // 设置自定义事件标签
    [customBuilder setEventLabel:@"pay_event_label"];
    // 设置自定义事件页面名称
    [customBuilder setEventPage:@"支付页面"];
    // 设置自定义事件持续时间
    [customBuilder setDurationOnEvent:10];
    // 设置自定义事件扩展参数
    NSString *paySting = @"";
    if (payType == 0) {
        paySting = @"支付宝";
    }else if (payType == 1) {
        paySting = @"微信支付";
    }else {
        paySting = @"其他支付";
    }
    [customBuilder setProperty:paySting value:@"payType"];
    
    ALBBMANTracker *traker = [[ALBBMANAnalytics getInstance] getDefaultTracker];
    // 组装日志并发送
    NSDictionary *dic = [customBuilder build];
    [traker send:dic];
}
#pragma mark 提示框的控制
//最大是3个
- (void)showAlertView:(id)alertView weight:(NSInteger)weight {
    if (weight > 3) {
        return;
    }
    if (_isShow) {
        if (weight > _currentWeight) {
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _alterCount ++;
        }else {
            id alterView1 = [self.alertListArray objectAtIndex:_currentWeight];
            if ([alterView1 isKindOfClass:[UIAlertView class]]) {
                UIAlertView *alter = (UIAlertView *)alterView1;
                [alter dismissWithClickedButtonIndex:0 animated:NO];
            }else if ([alterView1 isKindOfClass:[UIView class]]){
                UIView *alter = (UIView *)alterView1;
                [alter removeFromSuperview];
            }
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _currentWeight = weight;
            _alterCount ++;
            [self showView:alertView];
        }
    }else {
        [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
        _currentWeight = weight;
        _alterCount ++;
        _isShow = YES;
        [self showView:alertView];
    }
}
- (void)hidenAlertView {
    if (_alertListArray && _alterCount > 0) {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount --;
        _currentWeight = -1;
        for (int i = 0; i < _alertListArray.count; i++) {
            id alter = [_alertListArray objectAtIndex:i];
            if ([alter isKindOfClass:[UIAlertView class]] || [alter isKindOfClass:[UIView class]]) {
                _currentWeight = i;
//                if (i == 1 || (_currentWeight > 1 && [self isLogin])) {
                    [self showView:alter];;
//                    break;
//                }else {
//                    [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
//                    _alterCount -- ;
//                    _currentWeight = -1;
//                }
            }
        }
        if (_currentWeight < 0) {
            _alterCount = 0;
        }
    }else {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount -- ;
        _currentWeight = -1;
        _isShow = NO;
    }
    if (_alterCount == 0) {
        _isShow = NO;
    }
}
- (void)showView:(id)view {
    if ([view isKindOfClass:[UIAlertView class]]) {
        [((UIAlertView *)view) show];
    }else if ([view isKindOfClass:[UIView class]]){
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}
- (NSMutableArray *)alertListArray {
    if (!_alertListArray) {
        _alterCount = 0;
        _currentWeight = -1;
        _alertListArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _alertListArray;
}
@end
