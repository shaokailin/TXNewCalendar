//
//  TXBZSMGodMessageModel.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXBZSMGodMessageModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *godImage;
@property (nonatomic, copy) NSString *godName;
@property (nonatomic, copy) NSString *blessType;
@property (nonatomic, copy) NSString *wishContent;
@property (nonatomic, copy) NSString *wishName;
@property (nonatomic, copy) NSString *godInDate;
@property (nonatomic, copy) NSString * godType;
@property (nonatomic, copy) NSString * indexId;
@property (nonatomic, copy) NSString *godDate;
@property (nonatomic, copy) NSString *huaImage;
@property (nonatomic, copy) NSString *lazhu;
@property (nonatomic, copy) NSString *gongguo;
@property (nonatomic, copy) NSString *chashui;
@property (nonatomic, copy) NSString *xiangyan;
@property (nonatomic, assign) NSInteger hasCount;
@end
