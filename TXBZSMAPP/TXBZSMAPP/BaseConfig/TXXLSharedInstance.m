
//  TXXLSharedInstance.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSharedInstance.h"
#import "SynthesizeSingleton.h"
#import <AlicloudMobileAnalitics/ALBBMAN.h>
#import <AdSupport/AdSupport.h>
#import "YYModel.h"
static NSString * const kBirthdayFormatter = @"yyyy-MM-dd HH:mm";
static NSString * const KEY_UUID_INSTEAD = @"com.tx.yyyc";
static NSString * const kUserPhotoName = @"userPhoto12";
static NSString * const kUserNickname = @"Nickname34";
static NSString * const kUserBirthday = @"Birthday23";
static NSString * const kUserSex = @"Sex45";
static NSString * const kWishDataSave_key = @"WishDataSave_key.data";
static NSString * const kBlessDataSave_key = @"kBlessDataSave_key.data";
@interface TXXLSharedInstance ()
{
    BOOL _isShow;
    NSInteger _currentWeight;
    BOOL _alterCount;
}
@property (nonatomic, strong) NSMutableArray *alertListArray;
@end
@implementation TXXLSharedInstance
SYNTHESIZE_SINGLETON_CLASS(TXXLSharedInstance);
- (instancetype)init {
    if (self = [super init]) {
        _iphoneIdentifier = [self getDeviceIDInKeychain];
        [self getUserMessage];
    }
    return self;
}
- (void)getUserMessage {
    NSString *birthday = [self getMessageManagerForObjectWithKey:kUserBirthday];
    if (KJudgeIsNullData(birthday)) {
        _isBoy = [self getMessageManagerForBoolWithKey:kUserSex];
        NSString *string = [NSString stringWithContentsOfFile:[self returnPhotoPath] encoding:NSUTF8StringEncoding error:nil];
        NSData *data = [[NSData alloc]initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
        if (data) {
            _userPhoto = [UIImage imageWithData:data];
        }else {
            _userPhoto = _isBoy == YES? ImageNameInit(@"boy"):ImageNameInit(@"girl");
        }
        _nickName = [self getMessageManagerForObjectWithKey:kUserNickname];
    }else {
        birthday = @"1991-06-05 21:30";
        _isBoy = YES;
        _userPhoto = _isBoy == YES? ImageNameInit(@"boy"):ImageNameInit(@"girl");
        _nickName = _isBoy == YES? @"小帅":@"小靓";
    }
    _birthDay = [NSDate stringTransToDate:birthday withFormat:kBirthdayFormatter];
    [self getBlessData];
}
- (void)setBirthDay:(NSDate *)birthDay {
    _birthDay = birthDay;
    [self setMessageManagerForObjectWithKey:kUserBirthday value:[birthDay dateTransformToString:kBirthdayFormatter]];
}
- (void)changeUserPhoto:(UIImage *)image {
    self.userPhoto = image;
    NSData *data = UIImageJPEGRepresentation(image, 0.8);
    NSData *base64Data = [data base64EncodedDataWithOptions:0];
    NSString *baseString = [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
    NSError *error = nil;
    [baseString writeToFile:[self returnPhotoPath] atomically:YES encoding:NSUTF8StringEncoding error:&error];
    if (error == nil) {
        LSKLog(@"成功");
    }else {
        LSKLog(@"失败----%@",error);
    }
}
- (NSString *)returnPhotoPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = NSStringFormat(@"%@%@",[paths lastObject],kUserPhotoName);
    return path;
}
#pragma mark - 祈福
- (void)addBlessModel:(TXBZSMGodMessageModel *)model {
    model.godInDate = [[NSDate getTodayDate]dateTransformToString:@"yyyy年MM月dd日"];
    [_blessArray insertObject:model atIndex:0];
    [self saveObject:_blessArray key:kBlessDataSave_key];
    [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kBlessDataChangeNotice object:nil];
}
- (void)changeBlessWithIndex:(NSInteger)index image:(NSString *)image date:(NSString *)date type:(PlatformGoodsType)type {
    TXBZSMGodMessageModel *model = [_blessArray objectAtIndex:index];
    switch (type) {
        case 0:
            model.lazhu = image;
            break;
        case 1:
            model.chashui = image;
            break;
        case 2:
            model.huaImage = image;
            break;
        case 3:
            model.xiangyan = image;
            break;
        case 4:
            model.gongguo = image;
            break;
            
        default:
            break;
    }
    if (date) {
        model.godDate = date;
        [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kBlessDataChangeNotice object:nil];
    }
    [self saveObject:_blessArray key:kBlessDataSave_key];
}
- (void)getBlessData {
    if (!_blessArray) {
        _blessArray = [NSMutableArray array];
    }else {
        [_blessArray removeAllObjects];
    }
    [_blessArray addObjectsFromArray:[self getObject:kBlessDataSave_key]];
}

- (void)saveObject:(NSArray *)array key:(NSString *)key {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:key];//sale1.data是你归档的数组的名字
    [NSKeyedArchiver archiveRootObject:array toFile:filePath];
}
- (NSArray *)getObject:(NSString *)key {
    NSString *path = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [path stringByAppendingPathComponent:key];//取出名
    NSArray *data = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    return data;
}
#pragma mark - 许愿树

#pragma mark -统计
- (void)analiticsViewAppear:(UIViewController *)vc {
    [[ALBBMANPageHitHelper getInstance] pageAppear:vc];
}
- (void)analiticsViewDisappear:(UIViewController *)vc {
    [[ALBBMANPageHitHelper getInstance] pageDisAppear:vc];
}
- (void)setupViewProperties:(UIViewController *)vc url:(NSString *)url name:(NSString *)name {
    name = KJudgeIsNullData(name)?name:@"未定";
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:name,@"pageName", nil];
    if (url) {
        [dict setObject:url forKey:@"h5统计"];
    }
    [[ALBBMANPageHitHelper getInstance] updatePageProperties:vc properties:dict];
}
- (void)analiticsEvent:(NSString *)eventName viewName:(NSString *)viewName {
    ALBBMANCustomHitBuilder *customBuilder = [[ALBBMANCustomHitBuilder alloc] init];
    // 设置自定义事件标签
    [customBuilder setEventLabel:eventName];
    // 设置自定义事件页面名称
    [customBuilder setEventPage:viewName];
    ALBBMANTracker *traker = [[ALBBMANAnalytics getInstance] getDefaultTracker];
    // 组装日志并发送
    NSDictionary *dic = [customBuilder build];
    [traker send:dic];
}
- (void)analiticsPay:(NSInteger)payType {
    ALBBMANCustomHitBuilder *customBuilder = [[ALBBMANCustomHitBuilder alloc] init];
    // 设置自定义事件标签
    [customBuilder setEventLabel:@"pay_event_label"];
    // 设置自定义事件页面名称
    [customBuilder setEventPage:@"支付页面"];
    // 设置自定义事件持续时间
    [customBuilder setDurationOnEvent:10];
    // 设置自定义事件扩展参数
    NSString *paySting = @"";
    if (payType == 0) {
        paySting = @"支付宝";
    }else if (payType == 1) {
        paySting = @"微信支付";
    }else {
        paySting = @"其他支付";
    }
    [customBuilder setProperty:paySting value:@"payType"];
    
    ALBBMANTracker *traker = [[ALBBMANAnalytics getInstance] getDefaultTracker];
    // 组装日志并发送
    NSDictionary *dic = [customBuilder build];
    [traker send:dic];
}
#pragma mark - 手机的唯一标识

- (NSString *)getDeviceIDInKeychain {
    NSString *getUDIDInKeychain = (NSString *)[self load:KEY_UUID_INSTEAD];
    if (!getUDIDInKeychain || [getUDIDInKeychain isEqualToString:@""] || [getUDIDInKeychain isKindOfClass:[NSNull class]]) {
        CFUUIDRef puuid = CFUUIDCreate(nil);
        CFStringRef uuidString  = CFUUIDCreateString(nil, puuid);
        NSString *result        = (NSString *)CFBridgingRelease(CFStringCreateCopy(NULL, uuidString));
        CFRelease(puuid);
        CFRelease(uuidString);
//        LSKLog(@"\n \n \n ______重新存储uuid __________\n \n \n %@",result);
        [self save:KEY_UUID_INSTEAD data:result];
        getUDIDInKeychain = (NSString *)[self load:KEY_UUID_INSTEAD];
    }
//    LSKLog(@"最终——————UDID_INSTEAD %@",getUDIDInKeychain);
    return getUDIDInKeychain;
}
- (void)deleteKeyChain {
    [self delete:KEY_UUID_INSTEAD];
}
- (NSMutableDictionary *)getKeychainQuery:(NSString *)service {
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,(__bridge_transfer id)kSecClass,
            service, (__bridge_transfer id)kSecAttrService,
            service, (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,(__bridge_transfer id)kSecAttrAccessible,
            nil];
}

- (id) load:(NSString *)service {
    id ret = nil;
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    //Configure the search setting
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge_retained CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = [NSKeyedUnarchiver unarchiveObjectWithData:(__bridge_transfer NSData *)keyData];
        } @catch (NSException *e) {
//            NSLog(@"Unarchive of %@ failed: %@", service, e);
        } @finally {
        }
    }
    return ret;
}

- (void)delete:(NSString *)service {
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
}

- (void)save:(NSString *)service data:(id)data {
    // Get search dictionary
    NSMutableDictionary *keychainQuery = [self getKeychainQuery:service];
    // Delete old item before add new item
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    // Add new object to search dictionary(Attention:the data format)
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:data] forKey:(__bridge_transfer id)kSecValueData];
    // Add item to keychain with the search dictionary
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
}

#pragma mark 提示框的控制
//最大是3个
- (void)showAlertView:(id)alertView weight:(NSInteger)weight {
    if (weight > 3) {
        return;
    }
    if (_isShow) {
        if (weight > _currentWeight) {
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _alterCount ++;
        }else {
            id alterView1 = [self.alertListArray objectAtIndex:_currentWeight];
            if ([alterView1 isKindOfClass:[UIAlertView class]]) {
                UIAlertView *alter = (UIAlertView *)alterView1;
                [alter dismissWithClickedButtonIndex:0 animated:NO];
            }else if ([alterView1 isKindOfClass:[UIView class]]){
                UIView *alter = (UIView *)alterView1;
                [alter removeFromSuperview];
            }
            [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
            _currentWeight = weight;
            _alterCount ++;
            [self showView:alertView];
        }
    }else {
        [self.alertListArray replaceObjectAtIndex:weight withObject:alertView];
        _currentWeight = weight;
        _alterCount ++;
        _isShow = YES;
        [self showView:alertView];
    }
}
- (void)hidenAlertView {
    if (_alertListArray && _alterCount > 0) {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount --;
        _currentWeight = -1;
        for (int i = 0; i < _alertListArray.count; i++) {
            id alter = [_alertListArray objectAtIndex:i];
            if ([alter isKindOfClass:[UIAlertView class]] || [alter isKindOfClass:[UIView class]]) {
                _currentWeight = i;
//                if (i == 1 || (_currentWeight > 1 && [self isLogin])) {
                    [self showView:alter];;
//                    break;
//                }else {
//                    [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
//                    _alterCount -- ;
//                    _currentWeight = -1;
//                }
            }
        }
        if (_currentWeight < 0) {
            _alterCount = 0;
        }
    }else {
        [_alertListArray replaceObjectAtIndex:_currentWeight withObject:@""];
        _alterCount -- ;
        _currentWeight = -1;
        _isShow = NO;
    }
    if (_alterCount == 0) {
        _isShow = NO;
    }
}
- (void)showView:(id)view {
    if ([view isKindOfClass:[UIAlertView class]]) {
        [((UIAlertView *)view) show];
    }else if ([view isKindOfClass:[UIView class]]){
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}
- (NSMutableArray *)alertListArray {
    if (!_alertListArray) {
        _alterCount = 0;
        _currentWeight = -1;
        _alertListArray = [NSMutableArray arrayWithObjects:@"",@"",@"",@"", nil];
    }
    return _alertListArray;
}
@end
