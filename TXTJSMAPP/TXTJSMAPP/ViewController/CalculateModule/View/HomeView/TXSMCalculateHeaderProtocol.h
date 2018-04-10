//
//  TXSMCalculateHeaderProtocol.h
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^CalculateHeaderClickBlock)(NSInteger index);
@protocol TXSMCalculateHeaderProtocol <NSObject>
@property (nonatomic, copy) CalculateHeaderClickBlock clickBlock;
- (void)setupCategoryBtnArray:(NSArray *)array;
- (CGFloat)returnHeight;
@end
