//
//  TXBZSMWishTreeCompleteVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishTreeCompleteVC.h"
#import "TXBZSMWishTreeCompleteView.h"
@interface TXBZSMWishTreeCompleteVC ()

@end

@implementation TXBZSMWishTreeCompleteVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addYellowNavigationBackButton];
    self.navigationItem.title = @"提示";
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorHexadecimal(0xe2b579, 1.0)};;
    [self.navigationController.navigationBar setBackgroundImage:[ImageNameInit(@"god_navi_god")resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 10) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
}
- (void)actionEvent {
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您确定已经还愿了？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    @weakify(self)
    [alertView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        if ([x integerValue] == 1) {
            @strongify(self)
            [kUserMessageManager removeWishModel:self.index];
            [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kWishDataChangeNotice object:nil];
            [self navigationBackClick];
        }
    }];
    [alertView show];
}
- (void)initializeMainView {
    TXBZSMWishTreeCompleteView *mainView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMWishTreeCompleteView" owner:self options:nil]lastObject];
    [mainView setupContent:self.name];
    @weakify(self)
    mainView.block = ^(NSInteger type) {
        @strongify(self)
        [self actionEvent];
    };
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
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
