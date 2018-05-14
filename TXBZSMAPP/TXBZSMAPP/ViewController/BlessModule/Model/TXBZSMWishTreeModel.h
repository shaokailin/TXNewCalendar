//
//  TXBZSMWishTreeModel.h
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXBZSMWishTreeModel : NSObject<NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *wishContent;
@property (nonatomic, copy) NSString *wishTitle;
@end
