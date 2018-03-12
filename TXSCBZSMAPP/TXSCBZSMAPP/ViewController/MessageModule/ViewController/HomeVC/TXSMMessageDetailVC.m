//
//  TXSMMessageDetailVC.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/12.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageDetailVC.h"

@interface TXSMMessageDetailVC ()

@end

@implementation TXSMMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"share_icon" seletedIamge:nil target:self action:@selector(showShareView)];
}
- (void)showShareView {
    
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
