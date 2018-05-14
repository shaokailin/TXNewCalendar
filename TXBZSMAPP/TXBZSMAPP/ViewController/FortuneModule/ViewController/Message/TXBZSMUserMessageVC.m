//
//  TXBZSMUserMessageVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMUserMessageVC.h"

@interface TXBZSMUserMessageVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TXBZSMUserMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.navigationItem.title = @"我的";
    [self addRightNavigationButtonWithTitle:@"完成" target:self action:@selector(completeChange)];
    [self initializeMainView];
}
- (void)completeChange {
    
}
- (void)initializeMainView {
    
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
