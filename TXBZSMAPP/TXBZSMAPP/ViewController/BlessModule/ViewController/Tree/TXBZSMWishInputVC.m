//
//  TXBZSMWishInputVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishInputVC.h"

@interface TXBZSMWishInputVC ()
@end

@implementation TXBZSMWishInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addYellowNavigationBackButton];
    self.navigationItem.title = @"填写愿望";
    [self initializeMainView ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorHexadecimal(0xe2b579, 1.0)};;
    [self.navigationController.navigationBar setBackgroundImage:ImageNameInit(@"god_navi_god") forBarMetrics:UIBarMetricsDefault];
}
- (void)initializeMainView {
//    self addri
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
