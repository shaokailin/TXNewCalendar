//
//  TXBZSMWishCardHomeView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishCardHomeView.h"
#import "TXBZSMWishCardCell.h"
@interface TXBZSMWishCardHomeView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_dataArr;
}
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topValue;
@property (nonatomic, weak) UICollectionView *collectionView;
@end
@implementation TXBZSMWishCardHomeView
- (IBAction)backClick:(id)sender {
    if (self.homeBlock) {
        self.homeBlock(0, nil);
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    [self _initMainView];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _dataArr.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXBZSMWishCardCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXBZSMWishCardCell forIndexPath:indexPath];
    NSDictionary *dict = [_dataArr objectAtIndex:indexPath.row];
    [cell setupContent:[dict objectForKey:@"title"] img:[dict objectForKey:@"image"]];
    return cell;
}
- (void)_initMainView {
    _dataArr = [NSArray arrayWithPlist:@"WishList"];
    UICollectionViewFlowLayout *flowLaout = [[UICollectionViewFlowLayout alloc]init];
    flowLaout.itemSize = CGSizeMake(70, 178);
    flowLaout.sectionInset = UIEdgeInsetsMake(0, 15, 15, 15);
    UICollectionView *collection = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:flowLaout headRefreshAction:nil footRefreshAction:nil backgroundColor:[UIColor redColor]];
    [collection registerNib:[UINib nibWithNibName:kTXBZSMWishCardCell bundle:nil] forCellWithReuseIdentifier:kTXBZSMWishCardCell];
    self.collectionView = collection;
    [self addSubview:collection];
    [collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self).with.insets(UIEdgeInsetsMake(96 + STATUSBAR_HEIGHT, 30, 20, 30));
    }];
}


@end
