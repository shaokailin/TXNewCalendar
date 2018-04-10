//
//  TXSMFortuneSelectVC.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseViewController.h"
@protocol FortuneSelectDelegate <NSObject>
- (void)selectXingZuoIndex:(NSInteger)index;
@end
@interface TXSMFortuneSelectVC : LSKBaseViewController
@property (nonatomic, weak) id<FortuneSelectDelegate> delegate;
@property (nonatomic, weak) NSArray *dataArray;
@end
