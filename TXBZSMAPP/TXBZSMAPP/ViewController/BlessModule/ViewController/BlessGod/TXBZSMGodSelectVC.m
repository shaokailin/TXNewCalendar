//
//  TXBZSMGodSelectVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodSelectVC.h"
#import "TXBZSMGodSelectCell.h"
#import "TXBZSMBuddhismGodCell.h"
#import "TXBZSMGodDetailVC.h"
@interface TXBZSMGodSelectVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableDictionary *_dataDictionary;
    NSInteger _currentIndex;
    BOOL _isJumpDetail;
}
@property (nonatomic, weak) UITableView *tableView;
@property (nonatomic, weak) UISegmentedControl *segmentedControl;
@end

@implementation TXBZSMGodSelectVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addYellowNavigationBackButton];
    self.navigationItem.title = @"恭请神明";
    [self initializeMainView ];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_isJumpDetail) {
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
        self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorHexadecimal(0xe2b579, 1.0)};;
        [self.navigationController.navigationBar setBackgroundImage:ImageNameInit(@"god_navi_god") forBarMetrics:UIBarMetricsDefault];
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _isJumpDetail = NO;
}
#pragma mark - method
- (void)selectEvent:(TXBZSMGodSelectSuperCell *)cell index:(NSInteger)index {
    NSString *key = _currentIndex == 0?@"1":@"2";
    NSArray *array = [_dataDictionary objectForKey:key];
    NSInteger indexPath = [self.tableView indexPathForCell:cell].row * 3;
    NSInteger selectIndex = indexPath + index;
    NSDictionary *dict = [array objectAtIndex:selectIndex];
    _isJumpDetail = YES;
    TXBZSMGodDetailVC *detail = [[TXBZSMGodDetailVC alloc]init];
    detail.godDetail = dict;
    @weakify(self)
    detail.selectBlock = ^(NSDictionary *dict) {
        @strongify(self)
        if (self.selectBlock) {
            self.selectBlock(dict);
        }
    };
    [self.navigationController pushViewController:detail animated:YES];
}
- (void)changeSelectShow:(UISegmentedControl *)segmented {
    _currentIndex = segmented.selectedSegmentIndex;
    [self.tableView reloadData];
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *key = _currentIndex == 0?@"1":@"2";
    NSArray *array = [_dataDictionary objectForKey:key];
    return ceil(array.count / 3.0);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TXBZSMGodSelectSuperCell *cell = nil;
    if (_currentIndex == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMGodSelectCell];
    }else {
        cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMBuddhismGodCell];
    }
    NSString *key = _currentIndex == 0?@"1":@"2";
    NSArray *array = [_dataDictionary objectForKey:key];
    NSInteger index = indexPath.row * 3;
    [cell setupContentWithFirst:[array objectAtIndex:index] second:index + 1 >= array.count?nil:[array objectAtIndex:index + 1] third:index + 2 >= array.count?nil:[array objectAtIndex:index + 2]];
    @weakify(self)
    cell.block = ^(NSInteger flag, id clickCell) {
        @strongify(self)
        [self selectEvent:clickCell index:flag];
    };
    return cell;
}
#pragma mark - init
- (void)initializeMainView {
    NSDictionary *dict1 = [NSDictionary dictionaryWithPlist:@"TaoismGod"];
    NSArray *blessArray = kUserMessageManager.blessArray;
    if (blessArray.count > 0) {
        _dataDictionary = [NSMutableDictionary dictionary];
        for (NSString *key in dict1.allKeys) {
            NSMutableArray *array = [NSMutableArray array];
            NSArray *dataArray = [dict1 objectForKey:key];
            for (NSDictionary *dict2 in dataArray) {
                BOOL has = NO;
                for (TXBZSMGodMessageModel *model in blessArray) {
                    if ([model.godType isEqualToString:key] && [model.indexId isEqualToString:[dict2 objectForKey:@"indexId"]]) {
                        has = YES;
                        break;
                    }
                }
                if (has) {
                    NSMutableDictionary *dict3 = [NSMutableDictionary dictionaryWithDictionary:dict2];
                    [dict3 setObject:@(1) forKey:@"has"];
                    [array addObject:dict3];
                }else {
                    [array addObject:dict2];
                }
            }
            [_dataDictionary setObject:array forKey:key];
        }
    }else {
        _dataDictionary = [NSMutableDictionary dictionaryWithDictionary:dict1];
    }
    
    _currentIndex = 0;
    UIView *headerView = [[UIView alloc]init];
    headerView.backgroundColor = KColorHexadecimal(0xf5efe8, 1.0);
    UISegmentedControl *segmentedControl = [[UISegmentedControl alloc]initWithItems:@[@"道教神仙",@"佛教菩萨"]];
    segmentedControl.tintColor = KColorHexadecimal(0xe2b579, 1.0);
    [segmentedControl addTarget:self action:@selector(changeSelectShow:) forControlEvents:UIControlEventValueChanged];
    self.segmentedControl = segmentedControl;
    segmentedControl.selectedSegmentIndex = _currentIndex;
    [headerView addSubview:segmentedControl];
    [segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(headerView).with.insets(UIEdgeInsetsMake(2, 18, 5, 18));
    }];
    [self.view addSubview:headerView];
    [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.mas_equalTo(27);
    }];
    
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    [tableView registerNib:[UINib nibWithNibName:kTXBZSMGodSelectCell bundle:nil] forCellReuseIdentifier:kTXBZSMGodSelectCell];
    tableView.rowHeight = 200;
    [tableView registerNib:[UINib nibWithNibName:kTXBZSMBuddhismGodCell bundle:nil] forCellReuseIdentifier:kTXBZSMBuddhismGodCell];
    self.tableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(27, 0, self.tabbarBetweenHeight, 0));
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
