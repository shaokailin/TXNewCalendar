//
//  TXBZSMPlatformGoodView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/11.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMPlatformGoodVC.h"
#import "LSKImageManager.h"
#import "UIImageView+LBBlurredImage.h"
#import "GPUImageGaussianBlurFilter.h"
#import "TXBZSMPlatformGoodsCell.h"
@interface TXBZSMPlatformGoodVC ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray *_dataArray;
}
@property (nonatomic, weak) UITableView *mainTableView;
@end

@implementation TXBZSMPlatformGoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)selectEvent:(TXBZSMPlatformGoodsCell *)cell index:(NSInteger)index {
    NSInteger indexPath = [self.mainTableView indexPathForCell:cell].row * 3;
    NSInteger selectIndex = indexPath + index;
    NSDictionary *dict = [_dataArray objectAtIndex:selectIndex];
    LSKLog(@"%@",dict);
}
#pragma mark - delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return ceil(_dataArray.count / 3.0);;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMPlatformGoodsCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMPlatformGoodsCell];
    NSInteger index = indexPath.row * 3;
    [cell setupContentWithFirst:[_dataArray objectAtIndex:index] second:[_dataArray objectAtIndex:index + 1] third:[_dataArray objectAtIndex:index + 2]];
    @weakify(self)
    cell.selectBlock = ^(NSInteger flag, id clickCell) {
        @strongify(self)
        [self selectEvent:clickCell index:flag];
    };
    return cell;
}
#pragma mark - init
- (void)initializeMainView {
    [self setupNavigationTitle];
    [self addBackImage];
    NSDictionary *dict = [NSDictionary dictionaryWithPlist:@"gongpingoods"];
    NSDictionary *data = [dict objectForKey:[self returnDataKey]];
    _dataArray = [data objectForKey:@"data"];
    UITableView *tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:[UIColor clearColor]];
    [tableView registerNib:[UINib nibWithNibName:kTXBZSMPlatformGoodsCell bundle:nil] forCellReuseIdentifier:kTXBZSMPlatformGoodsCell];
    tableView.rowHeight = 190;
    tableView.tableHeaderView = [self returnHeaderView:[data objectForKey:@"info"]];
    self.mainTableView = tableView;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
}
- (UIView *)returnHeaderView:(NSString *)info {
    CGFloat contentHeight = [info calculateTextHeight:14 width:SCREEN_WIDTH - 24] + 12 + 30;
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, contentHeight)];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:info font:14 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    titleLbl.numberOfLines = 0;
    [headerView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(headerView).with.offset(12);
        make.right.equalTo(headerView).with.offset(-12);
    }];
    return headerView;
}
- (void)addBackImage{
    GPUImageGaussianBlurFilter * blurFilter = [[GPUImageGaussianBlurFilter alloc] init];
    blurFilter.blurRadiusInPixels = 12.0;
    dispatch_queue_t queue = dispatch_queue_create("lable1", DISPATCH_QUEUE_SERIAL);
    UIImageView *bgViewView = [[UIImageView alloc]init];
    bgViewView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight);
    
    bgViewView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgViewView];
    dispatch_async(queue, ^{
        UIImage *blurredImage = [blurFilter imageByFilteringImage:self.bgImageView];
        dispatch_async(dispatch_get_main_queue(), ^{
            bgViewView.image = blurredImage;
        });
    });
}

- (NSString *)returnDataKey {
    NSString *title = @"";
    switch (self.goodsType) {
        case PlatformGoodsType_lazhu:
            title = @"lazhu";
            break;
        case PlatformGoodsType_chashui:
            title = @"shengshui";
            break;
        case PlatformGoodsType_huaping:
            title = @"gonghua";
            break;
        case PlatformGoodsType_gongpin:
            title = @"gongguo";
            break;
        case PlatformGoodsType_xiangyan:
            title = @"xiangtan";
            break;
        default:
            break;
    }
    return title;
}
- (void)setupNavigationTitle {
    switch (self.goodsType) {
        case PlatformGoodsType_lazhu:
            self.navigationItem.title = @"蜡烛";
            break;
        case PlatformGoodsType_chashui:
            self.navigationItem.title = @"水杯";
            break;
        case PlatformGoodsType_huaping:
            self.navigationItem.title = @"花";
            break;
        case PlatformGoodsType_gongpin:
            self.navigationItem.title = @"果";
            break;
        case PlatformGoodsType_xiangyan:
            self.navigationItem.title = @"香";
            break;
        default:
            break;
    }
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
