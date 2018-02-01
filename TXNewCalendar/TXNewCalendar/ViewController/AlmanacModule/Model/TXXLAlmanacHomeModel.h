//
//  TXXLAlmanacHomeModel.h
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKBaseResponseModel.h"

@interface TXXLAlmanacHomeModel : LSKBaseResponseModel
@property (nonatomic, strong) NSDictionary *nongli;//农历中文(y,m,d分别代表年月日)
@property (nonatomic, strong) NSDictionary *nongliNum;//农历数字
@property (nonatomic, strong) NSDictionary *jinian;//农历干支纪年（y,m,d分别代表年月日）
@property (nonatomic, copy) NSString *shengxiao;//生肖
@property (nonatomic, copy) NSString *jie_ri;//当天节日
@property (nonatomic, copy) NSString *gongli;//公历
@property (nonatomic, copy) NSString *week;//星期几
@property (nonatomic, strong) NSDictionary *jieqi;//节气【current（当前），next（下一 节气）】
@property (nonatomic, strong) NSDictionary *position;//方位方位 （fu_shen：福神，xi_shen：喜神，cai_shen：财神，yang_gui_ren：阳贵人，yin_gui_ren：阴贵人）
@property (nonatomic, strong) NSDictionary *bamen;//八门方位
@property (nonatomic, strong) NSArray *peng_zu;//彭祖
@property (nonatomic, copy) NSString *jianchu;//建除
@property (nonatomic, strong) NSDictionary *hehai;//今日合害（san_he:三合，liu_he：六合,xian_chong：相冲,san_hui:三会，xian_hai：相害，xian_po:相破，xian_xing:相刑）
@property (nonatomic, strong) NSDictionary *na_yin;//纳音(y,m,d分别代表年月日)
@property (nonatomic, strong) NSArray *xing_su;//星宿
@property (nonatomic, strong) NSDictionary *kong_wang;
@property (nonatomic, strong) NSDictionary *zhi_ri;//值日 (huan_dao:黄道，xing_shen：星神,shen_sha:神煞)
@property (nonatomic, strong) NSArray *tai_shen;//胎神【胎神，解释】
@property (nonatomic, strong) NSDictionary *san_sha;//三煞(y,m,d分别代表年月日) 【煞方    劫煞    灾煞    岁煞】
@property (nonatomic, copy) NSString *xing_zuo;//星座
@property (nonatomic, strong) NSArray *h_detail;//时详情
@property (nonatomic, strong) NSDictionary *yi_ji;//宜忌和吉凶【jishen(吉神)，xiong(凶神),ji(忌)，yi(宜)】
@end
