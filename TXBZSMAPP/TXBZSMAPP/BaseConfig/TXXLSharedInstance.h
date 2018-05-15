//
//  TXXLSharedInstance.h
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "LSKMessageManage.h"
#import "TXBZSMWishTreeModel.h"
@interface TXXLSharedInstance : LSKMessageManage
#pragma mark - 用户资料
//
- (void)setupDefaultData;
@property (nonatomic, strong) NSDate *birthDay;
@property (nonatomic, assign) BOOL isBoy;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, strong) UIImage *userPhoto;
- (void)changeUserPhoto:(UIImage *)image;
- (BOOL)hasImage;
@property (nonatomic, copy) NSString *iphoneIdentifier;
+ (TXXLSharedInstance *)sharedInstance;
- (void)hidenAlertView;
- (void)showAlertView:(id)alertView weight:(NSInteger)weight;

//统计
- (void)analiticsViewAppear:(UIViewController *)vc;
- (void)analiticsViewDisappear:(UIViewController *)vc;
- (void)setupViewProperties:(UIViewController *)vc url:(NSString *)url name:(NSString *)name;
- (void)analiticsPay:(NSInteger)payType;
- (void)analiticsEvent:(NSString *)eventName viewName:(NSString *)viewName;

#pragma mark - 祈福数据
@property (nonatomic, strong) NSMutableArray *blessArray;
- (void)removeBlessModel:(NSInteger)index;
- (void)addBlessModel:(TXBZSMGodMessageModel *)model;
- (void)changeBlessWithIndex:(NSInteger)index image:(NSString *)image date:(NSString *)date type:(PlatformGoodsType)type;
- (void)changeBlessWishContent:(NSString *)content user:(NSString *)user index:(NSInteger)index;
#pragma mark - 许愿
@property (nonatomic, strong) NSMutableArray *wishArray;
- (void)getWishTreeData;
- (void)resetWishTreeData;
- (void)removeWishModel:(NSInteger)index;
- (void)addWishModel:(TXBZSMWishTreeModel *)model;
@end
