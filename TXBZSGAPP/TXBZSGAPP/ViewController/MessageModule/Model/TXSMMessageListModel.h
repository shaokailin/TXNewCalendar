//
//  TXSMMessageListModel.h
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/13.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface TXSMMessageModel : NSObject
@property (nonatomic, copy) NSString *pic;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *from;
@property (nonatomic, copy) NSString *hits;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *article_id;
@end
@interface TXSMMessageListModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *data;
@end
