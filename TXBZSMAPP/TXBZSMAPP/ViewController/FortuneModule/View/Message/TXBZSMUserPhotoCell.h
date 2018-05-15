//
//  TXBZSMUserPhotoCell.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhotoBlock)(BOOL isPhoto);
static NSString * const kTXBZSMUserPhotoCell = @"TXBZSMUserPhotoCell";
@interface TXBZSMUserPhotoCell : UITableViewCell
@property (nonatomic, copy) PhotoBlock block;
- (void)setupUserPhoto:(UIImage *)photoString;
@end
