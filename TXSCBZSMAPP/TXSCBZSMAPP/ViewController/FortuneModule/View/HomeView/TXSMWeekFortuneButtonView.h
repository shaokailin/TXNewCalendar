//
//  TXSMWeekFortuneButtonView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/8.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ButtonClickBlock) (NSInteger flag);
@interface TXSMWeekFortuneButtonView : UIView
@property (nonatomic, copy) ButtonClickBlock clickBlock;
@end
