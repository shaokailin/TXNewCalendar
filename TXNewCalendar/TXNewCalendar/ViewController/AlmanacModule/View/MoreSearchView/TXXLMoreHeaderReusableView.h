//
//  TXXLMoreHeaderReusableView.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLMoreHeaderReusableView = @"TXXLMoreHeaderReusableView";
typedef void (^HeaderAlertBlock)(BOOL isAlert);
@interface TXXLMoreHeaderReusableView : UICollectionReusableView
@property (copy, nonatomic) HeaderAlertBlock alertBlock;
@property (weak, nonatomic) IBOutlet UIButton *alertBtn;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@end
