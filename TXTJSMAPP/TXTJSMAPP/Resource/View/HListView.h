//
//  HListView.h
//  Hospital_V3
//
//  Created by fyp on 14-4-8.
//  Copyright (c) 2014年 www.yihu.cn健康之路. All rights reserved.
//

#import <UIKit/UIKit.h>

//
typedef enum  {
    HListViewScrollPositionNone,
    HListViewScrollPositionHead,
    HListViewScrollPositionMiddle,
    HListViewScrollPositionEnd
    
}HListViewScrollPosition;

@class HListView;

@protocol HListViewDataSource <NSObject>
@required;
- (NSInteger) numberOfColumnsInListView:(HListView *)listView;
- (CGFloat)widthListView:(HListView *)listView OfColumnForIndex:(NSInteger)index;
- (UITableViewCell*)listView:(UITableView*)tablView columnForIndex:(NSInteger)index;
@optional;
- (CGFloat)widthListView:(HListView *)listView OfHeaderForIndex:(NSInteger)index;
- (CGFloat)widthListView:(HListView *)listView OfFooterForIndex:(NSInteger)index;
- (UIView*)listView:(UITableView*)tablView headerView:(NSInteger)index;
- (UIView*)listView:(UITableView*)tablView footerView:(NSInteger)index;

@end

@protocol HListViewDelegate <NSObject>
@required;
- (void) listView:(HListView*)listView didSelectedListViewAtIndex:(NSInteger)index;
@optional
- (void) hListViewDidEndDecelerating:(UIScrollView *)scrollView;
- (void) hListViewDidEndDisplayingCell:(NSInteger)index;
@end
@interface HListView : UIView

@property (assign, nonatomic) id <HListViewDataSource> dataSource;
@property (assign, nonatomic) id <HListViewDelegate> delegate;
@property (assign,nonatomic)BOOL showHer;
@property (assign,nonatomic)int flag;
@property (retain,nonatomic)UITableView *hTableView;
- (void) deleteRowsAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void) insertRowsAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void) selectedRow:(NSInteger)indexs;
- (void) reloadListData;
- (void) reloadRow:(NSInteger)indexs;
- (void) scrollToPisition:(HListViewScrollPosition)position row:(NSInteger)row;
- (UITableViewCell *) cellForRowAtIndex:(NSInteger)index;
@end
