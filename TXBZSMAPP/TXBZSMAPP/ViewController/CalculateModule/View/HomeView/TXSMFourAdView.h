//
//  TXSMFourAdView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TXSMCalculateHeaderProtocol.h"
@interface TXSMFourAdView : UIView<TXSMCalculateHeaderProtocol>
@property (nonatomic, copy) NSString *key;
- (instancetype)initWithType:(NSInteger)type;
@end
