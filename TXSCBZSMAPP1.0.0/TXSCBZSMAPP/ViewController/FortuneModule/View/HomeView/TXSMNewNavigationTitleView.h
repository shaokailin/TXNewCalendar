//
//  TXSMNewNavigationTitleView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/15.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NavigationClickBlock) (BOOL isClick);
@interface TXSMNewNavigationTitleView : UIView
@property (nonatomic, copy) NavigationClickBlock clickBlock;
- (void)setupXingZuoName:(NSString *)name;
@end
