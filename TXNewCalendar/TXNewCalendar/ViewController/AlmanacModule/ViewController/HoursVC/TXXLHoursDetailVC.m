//
//  TXXLHoursDetailVC.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLHoursDetailVC.h"
#import "TXXLHoursDetailCell.h"
@interface TXXLHoursDetailVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation TXXLHoursDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"时辰宜忌";
    [self addNavigationBackButton];
    [self initializeMainView];
    [kUserMessageManager setupViewProperties:self url:nil name:@"时辰宜忌"];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (KJudgeIsArrayAndHasValue(self.hoursArray)) {
        return self.hoursArray.count;
    }
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLHoursDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLHoursDetailCell];
    NSDictionary *dict = [self.hoursArray objectAtIndex:indexPath.row];
    NSArray *hourArr = [dict objectForKey:@"h"];
    NSString *hour = nil;
    if (KJudgeIsArrayAndHasValue(hourArr)) {
        hour = NSStringFormat(@"%@时",[hourArr componentsJoinedByString:@""]);
    }
    NSDictionary *position = [dict objectForKey:@"position"];
    NSArray *shiyiArr = [dict objectForKey:@"shiyi"];
    NSString *shiyi = @"无";
    if (KJudgeIsArrayAndHasValue(shiyiArr)) {
        shiyi = [shiyiArr componentsJoinedByString:@"  "];
    }
    NSArray *shijiArr = [dict objectForKey:@"shiji"];
    NSString *shiji = @"无";
    if (KJudgeIsArrayAndHasValue(shijiArr)) {
        shiji = [shijiArr componentsJoinedByString:@"  "];
    }
    [cell setupCellContent:hour state:[dict objectForKey:@"jix"] timeBetween:[dict objectForKey:@"hour"] timeDetail:NSStringFormat(@"冲%@  (%@)  %@",[dict objectForKey:@"sx_chong"],[dict objectForKey:@"zheng_chong"],[dict objectForKey:@"sha"]) orientation:NSStringFormat(@"财神-%@  福神-%@  生门-%@  喜神-%@",[position objectForKey:@"cai_shen"],[position objectForKey:@"fu_shen"],[dict objectForKey:@"sheng"],[position objectForKey:@"xi_shen"]) suit:shiyi avoid:shiji];
    return cell;
}
#pragma mark - 界面
- (void)initializeMainView {
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerClass:[TXXLHoursDetailCell class] forCellReuseIdentifier:kTXXLHoursDetailCell];
    tableView.rowHeight = 148;
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 10)];
    footView.backgroundColor = [UIColor whiteColor];
    tableView.tableFooterView = footView;
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    WS(ws)
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
