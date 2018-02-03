//
//  TXXLPublicFestivelCell.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
static NSString * const kTXXLPublicFestivelCell = @"TXXLPublicFestivelCell";
typedef void (^TimeAddBlock)(id clickCell);
@interface TXXLPublicFestivelCell : UITableViewCell
@property (nonatomic, copy) TimeAddBlock timeBlock;
- (void)setupContentWithDate:(NSString *)date week:(NSString *)week title:(NSString *)title hasCount:(NSString *)hasCount;
@end
