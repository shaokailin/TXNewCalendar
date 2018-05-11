//
//  TXBZSMMyBlessVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessVC.h"
#import "TXBZSMMyBlessNoView.h"
#import "TXBZSMMyBlessCell.h"
#import "TXBZSMGodSelectVC.h"
#import "TXBZSMMyBlessWishVC.h"
@interface TXBZSMMyBlessVC ()<UITableViewDataSource,UITabBarDelegate>
{
    BOOL _isHasData;
    BOOL _isChangeNavi;
    UIImage *_naviImage;
    UIColor *_nornalColor;
}
@property (nonatomic, weak) TXBZSMMyBlessNoView *noDataView;
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation TXBZSMMyBlessVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (_isChangeNavi) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : _nornalColor};;
        [self.navigationController.navigationBar setBackgroundImage:_naviImage forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isChangeNavi = NO;
}
#pragma mark - 事件
- (void)needChange {
    _isChangeNavi = YES;
    if (!_naviImage) {
        _naviImage = ImageNameInit(@"navigationbg");
        _nornalColor = KColorUtilsString(kNavigationTitle_Color);
    }
}
- (void)jumpBlessSelect {
    [self needChange];
    TXBZSMGodSelectVC *select = [[TXBZSMGodSelectVC alloc]init];
    [self.navigationController pushViewController: select animated:YES];
}
//type 2:碗 1.前往祈福
- (void)cellClickEvent:(NSInteger)type cell:(TXBZSMMyBlessCell *)cell {
    NSIndexPath *indexpath = [self.mainTableView indexPathForCell:cell];
    if (type == 2) {
        
    }else {
        TXBZSMMyBlessWishVC *wish = [[TXBZSMMyBlessWishVC alloc]init];
        [self.navigationController pushViewController:wish animated:YES];
    }
}
#pragma mark - tableview
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMMyBlessCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMMyBlessCell];
    @weakify(self)
    cell.block = ^(NSInteger type, id clickCell) {
       @strongify(self)
        [self cellClickEvent:type cell:clickCell];
    };
    return cell;
}
#pragma mark - 初始化
- (void)initializeMainView {
    if (_isHasData) {
        self.navigationItem.title = @"许愿祈福";
        self.noDataView.hidden = NO;
    }else {
        self.navigationItem.title = @"我的祈福";
        self.mainTableView.hidden = NO;
    }
}
- (UITableView *)mainTableView {
    if (!_mainTableView) {
        UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
        tableView.rowHeight = 160;
        [tableView registerNib:[UINib nibWithNibName:kTXBZSMMyBlessCell bundle:nil] forCellReuseIdentifier:kTXBZSMMyBlessCell];
        _mainTableView = tableView;
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
        }];
    }
    return _mainTableView;
}
- (TXBZSMMyBlessNoView *)noDataView {
    if (!_noDataView) {
        TXBZSMMyBlessNoView *view = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMMyBlessNoView" owner:self options:nil]lastObject];
        _noDataView = view;
        @weakify(self)
        view.block = ^(BOOL isClick) {
          @strongify(self)
            [self jumpBlessSelect];
        };
        [self.view addSubview:view];
        [view mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
        }];
    }
    return _noDataView;
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
