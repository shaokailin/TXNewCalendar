//
//  TXSMFortuneMessageDetailView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneMessageDetailView.h"
#import "TXSMTodayFortuneView.h"
#import "TXSMWeekFortuneView.h"
#import "HListView.h"
#import "TXSMFortuneHomeNaviCell.h"
@interface TXSMFortuneMessageDetailView ()<UIScrollViewDelegate,HListViewDataSource,HListViewDelegate>
{
    BOOL _isClickAnimal;
}
@property (strong ,nonatomic) HListView *m_naviListView;
@property (strong ,nonatomic) UIImageView *underLineView;
@property (strong ,nonatomic) NSArray *m_naviTitleArray;
@property (strong ,nonatomic) UIScrollView *m_mainScrollView;
@property (assign ,nonatomic) NSInteger currentIndex;
@end
@implementation TXSMFortuneMessageDetailView
{
    NSInteger _currentIndex;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}

- (void)setupContent:(NSDictionary *)dict {
    for (int i = 0; i < self.m_naviTitleArray.count - 1; i++) {
        UIView<TXSMFortuneHomeProtocol> *view1 = [self.m_mainScrollView.subviews objectAtIndex:i];
        NSString *key = [[self class]returnDataKey:i];
        if (key) {
            [view1 setupContent:[dict objectForKey:key]];
        }
    }
    [self frameChange];
}
#pragma mark 控制产品界面的切换
- (void)changeProductShow:(BOOL)isTap {
    if (!isTap) {
        _isClickAnimal = YES;
        [UIView animateWithDuration:0.25 animations:^{
            [self.m_mainScrollView setContentOffset:CGPointMake(SCREEN_WIDTH * self->_currentIndex, 0)];
        }completion:^(BOOL finished) {
            self->_isClickAnimal = NO;
            [self frameChange];
        }];
        [self.m_naviListView reloadListData];
        [self changeUnderLineFrame];
    }else {
        [self frameChange];
    }
}
- (void)frameChange {
    if (self.selectBlock) {
        self.selectBlock(_currentIndex);
    }
    UIView<TXSMFortuneHomeProtocol> *view = [self.m_mainScrollView.subviews objectAtIndex:_currentIndex];
    CGFloat contentHeight = [view returnViewHeight];
    CGRect frame = self.m_mainScrollView.frame;
    CGFloat scrollHeight = CGRectGetHeight(frame);
    if (contentHeight != scrollHeight) {
        self.m_mainScrollView.contentSize = CGSizeMake(SCREEN_WIDTH * (self.m_naviTitleArray.count - 1), contentHeight);
        frame.size.height = contentHeight;
        CGRect selfFrame = self.frame;
        selfFrame.size.height = contentHeight + kHomeHeadButtonHeight;
        self.frame = selfFrame;
        self.m_mainScrollView.frame = frame;
        if (self.frameBlock) {
            self.frameBlock(contentHeight + kHomeHeadButtonHeight);
        }
    }
}
-(void)changeUnderLineFrame {
    TXSMFortuneHomeNaviCell *cell = (TXSMFortuneHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:_currentIndex];
    CGRect rect = [cell getCellTitleFrame];
    [UIView animateWithDuration:0.2 animations:^{
        self.underLineView.frame = CGRectMake(rect.origin.y + rect.size.height / 2.0 - 7, kHomeHeadButtonHeight - 7, 14, 7);
    }];
}
#pragma mark scroller delegate
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    _isClickAnimal = NO;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat x = self.m_mainScrollView.contentOffset.x;
    if (!_isClickAnimal) {
        CGFloat screenWidth = SCREEN_WIDTH;
        NSInteger indexPage = floor(x / screenWidth) ;
        if (indexPage < self.m_naviTitleArray.count -1) {
            NSInteger lastPage = 0;
            CGFloat rate = 0;
            CGFloat lastrate = 0;
            CGFloat pageWidth = indexPage * screenWidth;
            if (x < pageWidth) {
                rate = (pageWidth - x) / screenWidth;
                lastrate = 1 - rate;
                lastPage = indexPage - 1;
            }else if(x > pageWidth)
            {
                rate = (x - pageWidth) / screenWidth;
                lastrate = 1 - rate;
                lastPage = indexPage + 1;
            }else{
                rate = 1;
                lastrate = 1;
                lastPage = indexPage;
            }
            TXSMFortuneHomeNaviCell *current = (TXSMFortuneHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:indexPage];
            TXSMFortuneHomeNaviCell *last = (TXSMFortuneHomeNaviCell *)[self.m_naviListView cellForRowAtIndex:lastPage];
            [current changeTitleAttribute:[self decimalwithX:lastrate]];
            [last changeTitleAttribute:[self decimalwithX:rate]];
            [self changeLineFrame:rate currentFrame:[current getCellTitleFrame] lastFrame:[last getCellTitleFrame] direction:_currentIndex < lastPage lastRate:lastrate];
        }
        if ((NSInteger)x % (NSInteger)screenWidth == 0) {
            NSInteger indexPage = x / screenWidth ;
            if (_currentIndex != indexPage) {
                _currentIndex = indexPage;
                [self changeProductShow:YES];
            }
        }
    }
}
- (CGFloat )decimalwithX:(CGFloat)floatX {
    return (floorf(floatX * 100 + 0.5))/100;
}
-(void)changeLineFrame:(CGFloat)rate currentFrame:(CGRect)currentFrame lastFrame:(CGRect)lastFrame direction:(NSInteger)direction lastRate:(CGFloat)lastRate{
    if (rate != 1) {
        CGFloat lineWidth = 0;
        if (direction) {
            lineWidth = currentFrame.size.height + (lastFrame.size.height - currentFrame.size.height) * rate;
            CGFloat x = currentFrame.origin.y + (lastFrame.origin.y - currentFrame.origin.y) * rate;
            self.underLineView.frame = CGRectMake(x + lineWidth / 2.0 - 7, kHomeHeadButtonHeight - 7, 14, 7);
        }else {
            CGFloat x = (lastFrame.origin.y - currentFrame.origin.y) * lastRate;
            lineWidth = lastFrame.size.height + (currentFrame.size.height - lastFrame.size.height) * lastRate;
            self.underLineView.frame = CGRectMake(lastFrame.origin.y - x + lineWidth / 2.0 - 7, kHomeHeadButtonHeight - 7, 14, 7);
        }
    }else {
        self.underLineView.frame = CGRectMake(lastFrame.origin.y + lastFrame.size.height / 2.0 - 7, kHomeHeadButtonHeight - 7, 14, 7);
    }
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
    if (index != _currentIndex && index < self.m_naviTitleArray.count - 1) {
        _currentIndex = index;
        [self changeProductShow:NO];
    }else {
        if (self.selectBlock) {
            self.selectBlock(self.m_naviTitleArray.count - 1);
        }
    }
}
-(void)hListViewDidEndDisplayingCell:(NSInteger)index {
    if (index == 0) {
        [self changeUnderLineFrame];
    }
}
#pragma mark - 界面初始化
- (void)_layoutMainView {
    _currentIndex = 0;
    self.m_naviTitleArray = [[NSArray alloc]initWithObjects:@"今日运势",@"明日运势",@"本周运势",@"本月运势",@"今年运势", nil];
    _currentIndex = 0;
    [self customHeadButtonView];
    self.m_mainScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, kHomeHeadButtonHeight, SCREEN_WIDTH,0 )];
    self.m_mainScrollView.delegate = self;
    self.m_mainScrollView.bounces = NO;
    self.m_mainScrollView.pagingEnabled = YES;
    self.m_mainScrollView.showsVerticalScrollIndicator = NO;
    self.m_mainScrollView.showsHorizontalScrollIndicator = NO;
    [self addSubview:self.m_mainScrollView];
    for (int i = 0; i < self.m_naviTitleArray.count - 1; i++) {
        if (i < 2) {
            TXSMTodayFortuneView *view = [[TXSMTodayFortuneView alloc]initWithType:i];
            view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [view returnViewHeight]);
            [self.m_mainScrollView addSubview:view];
        }else {
            TXSMWeekFortuneView *view = [[TXSMWeekFortuneView alloc]initWithType:i - 2];
            view.frame = CGRectMake(SCREEN_WIDTH * i, 0, SCREEN_WIDTH, [view returnViewHeight]);
            [self.m_mainScrollView addSubview:view];
        }
    }
}
//设置头部导航
- (void)customHeadButtonView {
    self.m_naviListView = [[HListView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHomeHeadButtonHeight)];
    self.m_naviListView.delegate = self;
    self.m_naviListView.dataSource = self;
    self.m_naviListView.hTableView.scrollEnabled = NO;
    [self.m_naviListView.hTableView registerClass:[TXSMFortuneHomeNaviCell class] forCellReuseIdentifier:kTXSMFortuneHomeNaviCell];
    [self addSubview:self.m_naviListView];
    self.underLineView = [[UIImageView alloc]initWithImage:ImageNameInit(@"arrowtop")];
    self.underLineView.frame = CGRectMake(WIDTH_RACE_6S(9) + WIDTH_RACE_6S(53.5) / 2.0 - 7, kHomeHeadButtonHeight - 7, 14, 7);
    [self addSubview:_underLineView];
}
+ (NSString *)returnDataKey:(NSInteger)index {
    if (index > 3 || index < 0) {
        return nil;
    }
    NSString *key = nil;
    switch (index) {
        case 0:
            key = @"today";
            break;
        case 1:
            key = @"tomorrow";
            break;
        case 2:
            key = @"week";
            break;
        case 3:
            key = @"month";
            break;
        default:
            break;
    }
    return key;
}
@end
