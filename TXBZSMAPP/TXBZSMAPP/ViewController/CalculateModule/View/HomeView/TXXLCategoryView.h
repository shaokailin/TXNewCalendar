//
//  TXXLCategoryView.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^CategoryBtnBlock)(NSInteger index);
@interface TXXLCategoryView : UIView
@property (nonatomic, copy) CategoryBtnBlock clickBlock;
- (void)setupCategoryBtnArray:(NSArray *)array;
- (CGFloat)returnHeight;
@end
