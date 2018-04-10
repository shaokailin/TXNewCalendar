//
//  TXSMFortuneMessageDetailView.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ChangeFrameBlock)(CGFloat height);
typedef void (^ChangeSelectBlock)(NSInteger currentIndex);
@interface TXSMFortuneMessageDetailView : UIView
@property (nonatomic, copy) ChangeFrameBlock frameBlock;
@property (nonatomic, copy) ChangeSelectBlock selectBlock;
- (void)setupContent:(NSDictionary *)dict;
+ (NSString *)returnDataKey:(NSInteger)index;
@end
