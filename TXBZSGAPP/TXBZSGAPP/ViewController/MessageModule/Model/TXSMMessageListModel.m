//
//  TXSMMessageListModel.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageListModel.h"
@implementation TXSMMessageModel

@end
@implementation TXSMMessageListModel
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{@"data" : [TXSMMessageModel class],
             };
}
@end
