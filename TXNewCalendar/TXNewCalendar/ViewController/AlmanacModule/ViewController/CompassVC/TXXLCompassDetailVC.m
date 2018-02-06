//
//  TXXLCompassDetailVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/1/31.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLCompassDetailVC.h"
#import "TXXLCompassDetailView.h"
@interface TXXLCompassDetailVC ()
@property (nonatomic, weak) TXXLCompassDetailView *compassView;
@end

@implementation TXXLCompassDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"古神罗盘";
    [self addNavigationBackButton];
    [self initializeMainView];
    [kUserMessageManager setupViewProperties:self url:nil name:@"古神罗盘"];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)initializeMainView {
    TXXLCompassDetailView *compassView = [[TXXLCompassDetailView alloc]init];
    self.compassView = compassView;
    compassView.position = self.position;
    [self.view addSubview:compassView];
    WS(ws)
    [compassView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view).with.insets(UIEdgeInsetsMake(0, 0, ws.tabbarBetweenHeight, 0));
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
