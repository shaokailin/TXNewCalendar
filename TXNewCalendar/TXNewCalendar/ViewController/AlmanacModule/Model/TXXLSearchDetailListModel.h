//
//  TXXLSearchDetailListModel.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/2.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"
@interface TXXLSearchDetailModel : NSObject
@property (nonatomic, strong) NSDictionary *nongli;
@property (nonatomic, copy) NSString *shengxiao;
//@property (nonatomic, strong) NSDictionary *nongliNum;
@property (nonatomic, strong) NSDictionary *jinian;
@property (nonatomic, copy) NSString *jie_ri;
@property (nonatomic, copy) NSString *week;
@property (nonatomic, strong) NSDictionary *time;
@property (nonatomic, copy) NSString *xing_su;
@property (nonatomic, strong) NSDictionary *zhi_ri;
@property (nonatomic, copy) NSString *jian_chu;
@property (nonatomic, copy) NSString *tian;
@end
@interface TXXLSearchDetailListModel : LSKBaseResponseModel
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) NSInteger num;
@property (nonatomic, strong) NSArray *detail;
@end
