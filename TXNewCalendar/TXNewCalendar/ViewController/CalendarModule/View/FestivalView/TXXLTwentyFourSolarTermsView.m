//
//  TXXLTwentyFourSolarTermsView.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/30.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLTwentyFourSolarTermsView.h"
#import "TXXLSolarTermsCell.h"
static NSString * const kDataPlistName = @"twenty-fourSolarTerms";
@interface TXXLTwentyFourSolarTermsView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    NSArray *_dataArray;
    NSArray *_messageArray;
    CGFloat _itemHeight;
    CGFloat _itemWidth;
}
@property (nonatomic, weak) UICollectionView *mainCollectionView;
@end
@implementation TXXLTwentyFourSolarTermsView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)pullDownRefresh {
    if (self.loadBlock) {
        self.loadBlock(YES);
    }
}
- (void)selectCurrentView {
    if (!KJudgeIsArrayAndHasValue(_messageArray)) {
        if (self.loadBlock) {
            self.loadBlock(NO);
        }
    }
}
- (void)loadError {
    [self.mainCollectionView.mj_header endRefreshing];
}
- (void)loadSucess:(id)data {
    _messageArray = data;
    [self.mainCollectionView reloadData];
}
#pragma mark --UICollectionViewDataSource
//定义展示的UICollectionViewCell的个数
-( NSInteger )collectionView:( UICollectionView *)collectionView numberOfItemsInSection:( NSInteger )section{
    return _dataArray.count ;
}
//定义展示的Section的个数
-( NSInteger )numberOfSectionsInCollectionView:( UICollectionView *)collectionView{
    return 1 ;
}
//每个UICollectionView展示的内容
-( UICollectionViewCell *)collectionView:( UICollectionView *)collectionView cellForItemAtIndexPath:( NSIndexPath *)indexPath{
    TXXLSolarTermsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXXLSolarTermsCell forIndexPath:indexPath];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    NSString *title = nil;
    NSString *time = nil;
    if (_messageArray &&  indexPath.row < _messageArray.count) {
        NSDictionary *messageDic = [_messageArray objectAtIndex:indexPath.row];
        title = [messageDic objectForKey:@"title"];
        NSString *timeString = [messageDic objectForKey:@"time"];
        if (KJudgeIsNullData(timeString)) {
            NSArray *timeArr = [timeString componentsSeparatedByString:@" "];
             time = [timeArr objectAtIndex:0];
        }
       
    }
    [cell setupCellContentWithIcon:[dict objectForKey:@"image"] title:title time:time];
    return cell;
}

#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-( void )collectionView:( UICollectionView *)collectionView didSelectItemAtIndexPath:( NSIndexPath *)indexPath{
}
#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的边距(次序: 上，左，下，右边)
-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(_itemWidth, _itemHeight);
}

//设置单元格间的横向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return (SCREEN_WIDTH - 20 - _itemWidth * 3) / 2;
}

//设置单元格间的竖向间距
- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
#pragma mark -界面初始化
- (void)_layoutMainView {
    BOOL isNoSmall = [LSKPublicMethodUtil getiPhoneType] > 1;
    if (isNoSmall) {
        _itemHeight = 108 + 38;
        _itemWidth = 114;
    }else {
        _itemHeight = WIDTH_RACE_6S(108) + 38;
        _itemWidth = WIDTH_RACE_6S(114);
    }
    _dataArray = [NSArray arrayWithPlist:kDataPlistName];
    self.backgroundColor = [UIColor whiteColor];
    UICollectionViewFlowLayout *layout=[[ UICollectionViewFlowLayout alloc ] init ];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    UICollectionView *collectView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:[UIColor whiteColor]];
    
    [collectView registerClass:[TXXLSolarTermsCell class] forCellWithReuseIdentifier:kTXXLSolarTermsCell];
    self.mainCollectionView = collectView;
    [self addSubview:collectView];
    WS(ws)
    [collectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws);
    }];

}

@end
