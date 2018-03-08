//
//  TXSMFortuneHomeNaviTitleView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/7.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneHomeNaviTitleView.h"
#import "HListView.h"
#import "TXSMFortuneHomeNaviCell.h"
@interface TXSMFortuneHomeNaviTitleView ()<HListViewDataSource,HListViewDelegate>
@property (strong ,nonatomic) HListView *m_naviListView;
@property (strong ,nonatomic) UIView *underLineView;
@property (strong ,nonatomic) NSMutableArray *m_naviTitleArray;
@property (assign ,nonatomic) NSInteger currentIndex;
@end
@implementation TXSMFortuneHomeNaviTitleView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    self.m_naviTitleArray = [[NSMutableArray alloc]initWithObjects:@"今日运势",@"明日运势",@"本周运势",@"本月运势",@"今年运势", nil];
    _currentIndex = 0;
    [self customHeadButtonView];
}
//设置头部导航
- (void)customHeadButtonView {
    self.m_naviListView = [[HListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHomeHeadButtonHeight)];
    self.m_naviListView.delegate = self;
    self.m_naviListView.dataSource = self;
    self.m_naviListView.hTableView.scrollEnabled = NO;
    [self.m_naviListView.hTableView registerClass:[TXSMFortuneHomeNaviCell class] forCellReuseIdentifier:kTXSMFortuneHomeNaviCell];
    self.m_naviListView.backgroundColor = [UIColor redColor];
    [self addSubview:self.m_naviListView];
    self.underLineView = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_RACE_6S(15.9), kHomeHeadButtonHeight - WIDTH_RACE_6S(1.5), WIDTH_RACE_6S(31.2), WIDTH_RACE_6S(1.5))];
    _underLineView.backgroundColor = KColorHexadecimal(kNavi_Yellow_Color, 1.0);
    [self addSubview:_underLineView];
}
-(void)changeUnderLineFrame {
    TXSMFortuneHomeNaviCell *cell = (TXSMFortuneHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:_currentIndex];
    CGRect rect = [cell getCellTitleFrame];
    [UIView animateWithDuration:0.2 animations:^{
        self.underLineView.frame = CGRectMake(rect.origin.y, kHomeHeadButtonHeight - WIDTH_RACE_6S(1.5), rect.size.height, WIDTH_RACE_6S(1.5));
    }];
}
- (void)layoutSubviews {
    [super layoutSubviews];
    [self changeProductShow:NO];
}
#pragma mark 控制产品界面的切换
- (void)changeProductShow:(BOOL)isTap {
    [self.m_naviListView reloadListData];
    [self changeUnderLineFrame];
}
#pragma mark hlist delegate
- (NSInteger) numberOfColumnsInListView:(HListView *)listView {
    return self.m_naviTitleArray.count;
}
- (CGFloat)widthListView:(HListView *)listView OfColumnForIndex:(NSInteger)index {
    CGFloat width = SCREEN_WIDTH / self.m_naviTitleArray.count;
    return width;
}
- (UITableViewCell*)listView:(UITableView*)tablView columnForIndex:(NSInteger)index {
    TXSMFortuneHomeNaviCell *cell = [tablView dequeueReusableCellWithIdentifier:kTXSMFortuneHomeNaviCell];
    BOOL isSelect = NO;
    if (_currentIndex == index) {
        isSelect = YES;
    }
    [cell setupContentWithTitle:[self.m_naviTitleArray objectAtIndex:index] isSeleted:isSelect];
    return cell;
}

- (void) listView:(HListView*)listView didSelectedListViewAtIndex:(NSInteger)index {
    if (index != _currentIndex) {
        _currentIndex = index;
        if (self.selectBlock) {
            self.selectBlock(index);
        }
        [self changeProductShow:NO];
    }
}
-(void)hListViewDidEndDisplayingCell:(NSInteger)index {
    if (index == 0) {
        [self changeUnderLineFrame];
    }
}
@end
