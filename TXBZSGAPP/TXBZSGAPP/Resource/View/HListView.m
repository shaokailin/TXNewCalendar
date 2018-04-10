//
//  HListView.m
//  Hospital_V3
//
//  Created by fyp on 14-4-8.
//  Copyright (c) 2014年 www.yihu.cn健康之路. All rights reserved.
//

#import "HListView.h"

@interface HListView()
<UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>
{
    
}

@end


@implementation HListView

@synthesize dataSource;
@synthesize delegate;
@synthesize hTableView;
/***********************************************************/
/***********************************************************/
#pragma mark -
#pragma mark 基类方法
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect tvFrame = CGRectMake((frame.size.width - frame.size.height)/2.0, -(frame.size.width - frame.size.height)/2.0, frame.size.height, frame.size.width);
        
        if (!hTableView) {
            hTableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
            hTableView.backgroundColor = [UIColor clearColor];
            hTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            hTableView.dataSource = self;
            hTableView .showsHorizontalScrollIndicator = NO;
            hTableView.showsVerticalScrollIndicator = NO;
            hTableView.delegate = self;
            // 将tableview旋转270度
            hTableView.transform = CGAffineTransformMakeRotation(M_PI/2*3);
            [self addSubview:hTableView];
        }
    }
    return self;
}

-(void)awakeFromNib
{
    [super awakeFromNib];
    CGRect tvFrame = CGRectMake((self.frame.size.width - self.frame.size.height)/2.0, -(self.frame.size.width - self.frame.size.height)/2.0, self.frame.size.height, self.frame.size.width);
    
    if (!hTableView) {
        hTableView = [[UITableView alloc] initWithFrame:tvFrame style:UITableViewStylePlain];
        hTableView.backgroundColor = [UIColor clearColor];
        hTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        hTableView.dataSource = self;
        hTableView .showsHorizontalScrollIndicator = NO;
        hTableView.showsVerticalScrollIndicator = NO;
        hTableView.delegate = self;
        // 将tableview旋转270度
        hTableView.transform = CGAffineTransformMakeRotation(M_PI/2*3);
        [self addSubview:hTableView];
    }
}
- (void)dealloc
{
    delegate=nil;
    dataSource=nil;
    hTableView.delegate=nil;
    hTableView.dataSource=nil;
    hTableView = nil;
    
}
-(void)setShowHer:(BOOL)showHer
{
    if (showHer) {
        hTableView.showsHorizontalScrollIndicator = YES;
    }
}
-(void)setFlag:(int)flag
{
    hTableView.tag = flag;
}
/***********************************************************/
/***********************************************************/
#pragma mark -
#pragma mark 实例方法
- (void)setDataSource:(id<HListViewDataSource>)tDataSource {
    
    dataSource = tDataSource;
    [hTableView reloadData];
}
- (void) deleteRowsAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSIndexPath *tIndexPath=[NSIndexPath indexPathForRow:index inSection:0];
    
    [hTableView beginUpdates];
    if (animated) {
        [hTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:tIndexPath]
                          withRowAnimation:UITableViewRowAnimationFade];
    }
    else {
        [hTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:tIndexPath]
                          withRowAnimation:UITableViewRowAnimationNone];
    }
    [hTableView endUpdates];
}
- (void) insertRowsAtIndex:(NSInteger)index animated:(BOOL)animated
{
    NSIndexPath *tIndexPath=[NSIndexPath indexPathForRow:index inSection:0];
    self.userInteractionEnabled=NO;
    NSTimeInterval animatedTime=0.25;
    if (animated==NO) {
        animatedTime=0.0;
    }
    WS(ws)
    [UIView animateWithDuration:animatedTime
                     animations:^{
                         [ws.hTableView beginUpdates];
                         [ws.hTableView insertRowsAtIndexPaths:[NSArray arrayWithObject:tIndexPath]
                                           withRowAnimation:UITableViewRowAnimationNone];
                         [ws.hTableView endUpdates];
                         
                         CGFloat difference=ws.hTableView.contentSize.height-self.bounds.size.width;
                         if (difference>0) {
                             [ws.hTableView setContentOffset:CGPointMake(0.0, difference)];
                         }
                     } completion:^(BOOL finished) {
                         self.userInteractionEnabled=YES;
                     }];
}
-(void)selectedRow:(NSInteger)indexs
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexs inSection:0];
    [hTableView selectRowAtIndexPath:indexpath animated:YES
                      scrollPosition:UITableViewScrollPositionMiddle];
    
    // 点击效果
    if ([self.delegate respondsToSelector:@selector(listView:didSelectedListViewAtIndex:)]) {
        [self.delegate listView:self didSelectedListViewAtIndex:indexs];
    }
}
- (void)reloadListData {
    
    [hTableView reloadData];
}
-(void)reloadRow:(NSInteger)indexs
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:indexs inSection:0];
    [hTableView reloadRowsAtIndexPaths:@[indexpath]
                      withRowAnimation:UITableViewRowAnimationNone];
}
- (UITableViewCell *) cellForRowAtIndex:(NSInteger)index
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:index inSection:0];
    return [hTableView cellForRowAtIndexPath:indexpath];
}
- (void)scrollToPisition:(HListViewScrollPosition)position row:(NSInteger)row{
    
    switch (position) {
        case HListViewScrollPositionNone:
            [hTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionNone animated:YES];
            break;
        case HListViewScrollPositionHead:
            [hTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
            break;
        case HListViewScrollPositionMiddle:
            [hTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
            break;
        case HListViewScrollPositionEnd:
            [hTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
            break;
            
        default:
            break;
    }
}



/***********************************************************/
/***********************************************************/
#pragma mark -
#pragma mark UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfColumnsInListView:self];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.dataSource respondsToSelector:@selector(widthListView:OfColumnForIndex:)]) {
        return [self.dataSource widthListView:self OfColumnForIndex:indexPath.row];
    }
    return 100.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.dataSource respondsToSelector:@selector(listView:columnForIndex:)])
    {
        UITableViewCell *cell = [self.dataSource listView:hTableView columnForIndex:indexPath.row];
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
        return cell;
    }
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleBlue;
        // 将cell旋转90度
        cell.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(widthListView:OfHeaderForIndex:)]) {
        return [self.dataSource widthListView:self OfHeaderForIndex:section];
    }
    return 0;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(widthListView:OfFooterForIndex:)]) {
        return [self.dataSource widthListView:self OfFooterForIndex:section];
    }
    return 0;
}

-(void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.delegate respondsToSelector:@selector(hListViewDidEndDisplayingCell:)]) {
        return [self.delegate hListViewDidEndDisplayingCell:indexPath.row];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(listView:headerView:)])
    {
        UIView *headerView = [self.dataSource listView:hTableView headerView:section];
        headerView.transform = CGAffineTransformMakeRotation(M_PI/2);
        return headerView;
    }
    return nil;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if ([self.dataSource respondsToSelector:@selector(listView:footerView:)])
    {
        UIView *headerView = [self.dataSource listView:hTableView footerView:section];
        headerView.transform = CGAffineTransformMakeRotation(M_PI/2);
        return headerView;
    }
    return nil;
}

/***********************************************************/
/***********************************************************/
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if ([self.delegate respondsToSelector:@selector(listView:didSelectedListViewAtIndex:)]) {
        [self.delegate listView:self didSelectedListViewAtIndex:indexPath.row];
    }
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    
    if ([self.delegate respondsToSelector:@selector(hListViewDidEndDecelerating:)])
    {
        [self.delegate hListViewDidEndDecelerating:scrollView];
    }
}


@end
