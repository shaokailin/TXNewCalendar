//
//  TXXLSharedInstance.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKMessageManage.h"

@interface TXXLSharedInstance : LSKMessageManage
+ (TXXLSharedInstance *)sharedInstance;
- (void)hidenAlertView;
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;
@end
