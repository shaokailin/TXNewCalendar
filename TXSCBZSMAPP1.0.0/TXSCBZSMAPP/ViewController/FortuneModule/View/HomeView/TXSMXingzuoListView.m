//
//  TXSMXingzuoListView.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/16.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMXingzuoListView.h"
#import "TXSMXingzuoListCell.h"
@interface TXSMXingzuoListView ()<UITableViewDelegate,UITableViewDataSource>
{
    UIView *_contentView;
    UITableView *_tableView;
    NSArray *_dataArray;
}
@end
@implementation TXSMXingzuoListView

- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)show {
    self.alpha = 1;
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CAKeyframeAnimation* animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.5;// 动画时间
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    [_contentView.layer addAnimation:animation forKey:nil];
}
- (void)closeListView {
    [UIView animateWithDuration:0.25 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TXSMXingzuoListCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXSMXingzuoListCell];
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    [cell setupCellContent:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"] time:[dict objectForKey:@"time"]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [_dataArray objectAtIndex:indexPath.row];
    if (self.changeBlock) {
        self.changeBlock([dict objectForKey:@"title"], [dict objectForKey:@"english"]);
    }
    [self closeListView];
}
- (void)_layoutMainView {
    _dataArray = [NSArray arrayWithPlist:@"xingzuoList"];
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backgroundColor = KColorRGBA(0, 0, 0, 0.5);
    UIView *contentView = [[UIView alloc]init];
    _contentView = contentView;
    CGFloat contentHeight = 0;
    UIButton *closeBtn = [LSKViewFactory initializeButtonNornalImage:@"closelist" selectedImage:nil target:self action:@selector(closeListView)];
    [contentView addSubview:closeBtn];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.equalTo(contentView);
        make.size.mas_equalTo(CGSizeMake(25, 25));
    }];
    contentHeight += 45;
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:@"选择星座" font:17];
    titleLbl.textAlignment = 1;
    titleLbl.backgroundColor = [UIColor whiteColor];
    [contentView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(closeBtn.mas_bottom).with.offset(20);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(43);
    }];
    UIView *lineView = [[UIView alloc]init];
    lineView.backgroundColor = KColorHexadecimal(0xf1f1f1, 1.0);
    [contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLbl.mas_bottom);
        make.left.right.equalTo(contentView);
        make.height.mas_equalTo(1);
    }];
    contentHeight += 44;
    contentHeight += 7.5;
    _tableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:0 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:[UIColor whiteColor]];
    _tableView.rowHeight = 35;
    _tableView.tableFooterView = [[UIView alloc]init];
    [_tableView registerClass:[TXSMXingzuoListCell class] forCellReuseIdentifier:kTXSMXingzuoListCell];
    [contentView addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lineView.mas_bottom);
        make.left.right.bottom.equalTo(contentView);
    }];
    contentHeight += (35 * _dataArray.count);
    contentHeight += 15;
    if (contentHeight > SCREEN_HEIGHT - 40) {
        contentHeight = SCREEN_HEIGHT - 40;
    }
    [self addSubview:_contentView];
    WS(ws)
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(265, contentHeight));
    }];
}

@end
