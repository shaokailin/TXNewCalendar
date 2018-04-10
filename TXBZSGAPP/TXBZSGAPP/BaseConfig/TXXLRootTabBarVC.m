//
//  TXXLRootTabBarVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/22.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLRootTabBarVC.h"
#import "PPSSAppVersionManager.h"
static NSString * const kTabBarViewController_Plist = @"TabBarSetting";
@interface TXXLRootTabBarVC ()
@property (nonatomic, strong) PPSSAppVersionManager *appVersionManager;
@end

@implementation TXXLRootTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupTabbarData:kTabBarViewController_Plist];
    self.selectedIndex = 0;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateVersion) name:@"App_Update_Version" object:nil];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
- (void)updateVersion {
    [self.appVersionManager loadAppVersion];
}
#pragma mark -版本更新
- (PPSSAppVersionManager *)appVersionManager {
    if (!_appVersionManager) {
        _appVersionManager = [[PPSSAppVersionManager alloc]init];
    }
    return _appVersionManager;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
