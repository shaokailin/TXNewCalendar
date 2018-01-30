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
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 12;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXXLHoursDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXXLHoursDetailCell];
    [cell setupCellContent:@"甲子时" state:indexPath.row % 2 timeBetween:@"23:00-00:59" timeDetail:@"冲马（戊午）煞南" orientation:@"财神-东北" suit:@"财神-东北" avoid:@"开市  力券"];
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
