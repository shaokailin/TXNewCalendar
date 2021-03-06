//
//  TXBZSMMyWishMainView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyWishMainView.h"
#import "TXBZSMMyWishCell.h"
@interface TXBZSMMyWishMainView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;
@property (nonatomic, weak) UICollectionView *collectionView;
@end
@implementation TXBZSMMyWishMainView
- (IBAction)backClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(0, nil,-1);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.topValue.constant = STATUSBAR_HEIGHT - 10;
    [self _initMainView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeData) name:kWishDataChangeNotice object:nil];
}
- (void)changeData {
    _dataArr = kUserMessageManager.wishArray;
    [self.collectionView reloadData];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count + 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMMyWishCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXBZSMMyWishCell forIndexPath:indexPath];
    if (indexPath.row == _dataArr.count) {
        [cell setupContent:@"wish_null" title:@"继续许愿"];
    }else {
        TXBZSMWishTreeModel  *model = [_dataArr objectAtIndex:indexPath.row];
        [cell setupContent:model.image title:@"还愿"];
    }
    @weakify(self)
    cell.block = ^(id clickCell) {
        @strongify(self)
        [self clickBtn:clickCell];
    };
    return cell;
}
- (void)clickBtn:(TXBZSMMyWishCell *)cell {
    NSIndexPath *indexPath = [self.collectionView indexPathForCell:cell];
    if (indexPath.row < _dataArr.count) {
        TXBZSMWishTreeModel  *model = [_dataArr objectAtIndex:indexPath.row];
        self.homeBlock(3, model,indexPath.row);
    }else {
        self.homeBlock(2, nil,-1);
    }
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.homeBlock) {
        if (indexPath.row < _dataArr.count) {
//            TXBZSMWishTreeModel  *model = [_dataArr objectAtIndex:indexPath.row];
//            self.homeBlock(1, model);
        }else {
            self.homeBlock(2, nil,-1);
        }
    }
}
- (void)_initMainView {
    _dataArr = kUserMessageManager.wishArray;
    UICollectionViewFlowLayout *flowLaout = [[UICollectionViewFlowLayout alloc]init];
    flowLaout.itemSize = CGSizeMake(70, 155);
    flowLaout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
    UICollectionView *collection = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:flowLaout headRefreshAction:nil footRefreshAction:nil backgroundColor:[UIColor clearColor]];
    [collection registerNib:[UINib nibWithNibName:kTXBZSMMyWishCell bundle:nil] forCellWithReuseIdentifier:kTXBZSMMyWishCell];
    self.collectionView = collection;
    [self addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(100 + STATUSBAR_HEIGHT, 30, 20, 30));
    }];
}
@end
