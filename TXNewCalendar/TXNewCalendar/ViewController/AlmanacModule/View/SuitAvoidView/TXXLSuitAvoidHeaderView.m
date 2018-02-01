//
//  TXXLSuitAvoidHeaderView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidHeaderView.h"
@interface TXXLSuitAvoidHeaderView ()
{
    NSInteger _currentIndex;
    CGFloat _defaultHeight;
}
@end
@implementation TXXLSuitAvoidHeaderView

- (instancetype)initWithHeaderType:(NSInteger)type {
    if (self = [super init]) {
        _defaultHeight = 52 + 15 + 2;
        _contentHeight = _defaultHeight + 10;
        [self _layoutMainView:type];
    }
    return self;
}
- (void)setupContent:(NSDictionary *)contentDict {
    NSInteger contentCount = contentDict.allKeys.count;
    CGFloat width = SCREEN_WIDTH - 20 - 40 - 2;
    NSInteger maxIndex = MAX(_currentIndex, contentCount);
    CGFloat height = _defaultHeight - 20;
    for (int i = 0; i < maxIndex; i ++ ) {
        UILabel *titleLbl = [self viewWithTag:200 + i];
        UILabel *detailLbl = [self viewWithTag:300 + i];
        if (i < contentCount) {
            height += 21;
            NSString *titleString = [contentDict.allKeys objectAtIndex:i];
            NSString *detailString = [contentDict objectForKey:titleString];
            BOOL isTitleString = KJudgeIsNullData(titleString);
            if (isTitleString) {
                if (titleLbl == nil) {
                    titleLbl = [self customTitleLbl:i];
                    [self addSubview:titleLbl];
                }
                titleLbl.text = titleString;
                titleLbl.frame = CGRectMake(20, height, width, 17);
                height += 17;
            }else if(titleLbl) {
                titleLbl.text = nil;
                titleLbl.hidden = YES;
            }
            if (KJudgeIsNullData(detailString)) {
                height += isTitleString?18 :0;
                if (detailLbl == nil) {
                    detailLbl = [self customDetailLbl:i];
                    [self addSubview:detailLbl];
                }
                detailLbl.text = detailString;
                CGFloat detailHeight = [detailString calculateTextHeight:12 width:width];
                detailLbl.frame = CGRectMake(20, height, width, detailHeight);
                height += detailHeight;
            }else if (detailLbl) {
                detailLbl.text = nil;
                detailLbl.hidden = YES;
            }
        }else {
            if (titleLbl) {
                titleLbl.text = nil;
                titleLbl.hidden = YES;
            }
            if (detailLbl) {
                detailLbl.text = nil;
                detailLbl.hidden = YES;
            }
        }
    }
    CGFloat heightNew = height > _defaultHeight ? height + 15 : _defaultHeight + 10;
    _contentHeight = heightNew;
    _currentIndex = contentCount;
}
- (void)_layoutMainView:(NSInteger)headerType {
    _currentIndex = 0;
    KViewRadius(self, 4);
    KViewBorderLayer(self, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    WS(ws)
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:headerType == 0?@"宜":@"忌" font:17 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:headerType == 0?KColorHexadecimal(kText_LightGreen_Color, 1.0):KColorHexadecimal(kAPP_Main_Color, 1.0)];
    KViewBoundsRadius(titleLbl, 20);
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(12);
        make.centerX.equalTo(ws);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
}
- (UILabel *)customTitleLbl:(NSInteger)flag {
    UILabel *titleLbl = [TXXLViewManager customTitleLbl:nil font:17];
    titleLbl.tag = flag + 200;
    return titleLbl;
}
- (UILabel *)customDetailLbl:(NSInteger)flag {
    UILabel *detailLbl = [TXXLViewManager customDetailLbl:nil font:12];
    detailLbl.tag = flag + 300;
    detailLbl.numberOfLines = 0;
    return detailLbl;
}
@end
