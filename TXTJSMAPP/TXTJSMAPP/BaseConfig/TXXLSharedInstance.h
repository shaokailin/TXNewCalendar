//
//  TXXLSharedInstance.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKMessageManage.h"

@interface TXXLSharedInstance : LSKMessageManage
@property (nonatomic, copy) NSString *iphoneIdentifier;
+ (TXXLSharedInstance *)sharedInstance;
- (void)hidenAlertView;
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;

//统计
- (void)analiticsViewAppear:(UIViewController *)vc;
- (void)analiticsViewDisappear:(UIViewController *)vc;
- (void)setupViewProperties:(UIViewController *)vc url:(NSString *)url name:(NSString *)name;
- (void)analiticsPay:(NSInteger)payType;
- (void)analiticsEvent:(NSString *)eventName viewName:(NSString *)viewName;


@end
