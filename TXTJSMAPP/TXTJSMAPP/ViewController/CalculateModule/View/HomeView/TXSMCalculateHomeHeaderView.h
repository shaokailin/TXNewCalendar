//
//  TXSMCalculateHomeHeaderView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^HearderViewFrameChangeBlock)(CGFloat height);
typedef void (^HeaderViewEventBlock)(NSString *key,NSInteger index);
@interface TXSMCalculateHomeHeaderView : UIView
@property (nonatomic, copy) HearderViewFrameChangeBlock frameBlock;
@property (nonatomic, copy) HeaderViewEventBlock eventBlock;
- (void)setupContent:(NSDictionary *)dict;
- (void)viewDidAppearStartRun;
- (void)viewDidDisappearStop;
@end
