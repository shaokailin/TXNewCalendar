//
//  TXSMFortuneSelectVC.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/4.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneSelectVC.h"
#import "TXSMFortuneSelectCell.h"
@interface TXSMFortuneSelectVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@end

@implementation TXSMFortuneSelectVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXSMFortuneSelectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXSMFortuneSelectCell forIndexPath:indexPath];
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"title"] img:[dict objectForKey:@"image"] time:[dict objectForKey:@"time"]];
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectXingZuoIndex:)]) {
        [self.delegate selectXingZuoIndex:indexPath.row];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)initializeMainView {
    UIImageView *bgImage = [[UIImageView alloc]initWithImage:ImageNameInit(@"bgViewimage")];
    [self.view addSubview:bgImage];
    [bgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    
    UIScrollView *scrollerView = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    scrollerView.showsVerticalScrollIndicator = NO;
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0);
    layout.itemSize =CGSizeMake((SCREEN_WIDTH - 20 - 20) / 3.0, 130);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 10;
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:[UIColor whiteColor]];
    collectionView.scrollEnabled = NO;
    KViewRadius(collectionView, 10);
    [collectionView registerNib:[UINib nibWithNibName:kTXSMFortuneSelectCell bundle:nil] forCellWithReuseIdentifier:kTXSMFortuneSelectCell];
    [scrollerView addSubview:collectionView];
    CGFloat contentHeight = 30 + 130 * 4;
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(scrollerView).with.offset(111);
        make.left.equalTo(scrollerView).with.offset(10);
        make.width.mas_equalTo(SCREEN_WIDTH - 20);
        make.height.mas_equalTo(contentHeight);
    }];
    contentHeight += 111;
    contentHeight += 10;
    scrollerView.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    [self.view addSubview:scrollerView];
    [scrollerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    UIButton *backBtn = [LSKViewFactory initializeButtonNornalImage:@"navi_back" selectedImage:nil target:self action:@selector(backClick)];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(STATUSBAR_HEIGHT);
        make.left.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(35, 35));
    }];
}
- (void)backClick {
    [self navigationBackClick];
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
