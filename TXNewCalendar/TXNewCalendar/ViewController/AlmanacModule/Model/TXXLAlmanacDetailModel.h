//
//  TXXLAlmanacDetailModel.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface TXXLAlmanacDetailModel : LSKBaseResponseModel
@property (nonatomic, strong) NSArray *jian_chu;
@property (nonatomic, strong) NSArray *na_yin;
@property (nonatomic, strong) NSArray *tai_shen;
@property (nonatomic, strong) NSArray *peng_zu;
@property (nonatomic, strong) NSArray *xing_su;

@property (nonatomic, strong) NSDictionary *chong_sha;
@property (nonatomic, strong) NSDictionary *zhi_shen;
@property (nonatomic, strong) NSDictionary *lucky;
@property (nonatomic, strong) NSDictionary *jishen;
@property (nonatomic, strong) NSDictionary *xiong;
@property (nonatomic, strong) NSDictionary *yi;
@property (nonatomic, strong) NSDictionary *ji;
@end
