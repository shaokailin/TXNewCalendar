//
//  TXSMCalculateNoticeView.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/6.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^NoticeBlock)(NSInteger type);//0:最新 1：热门
@interface TXSMCalculateNoticeView : UIView
@property (nonatomic, copy) NoticeBlock noticeBlock;
- (void)setupContentWithNew:(NSString *)topNew hot:(NSString *)hot;
@end
