//
//  TXXLSuitAvoidContentView.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/1.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidContentView.h"
@interface TXXLSuitAvoidContentView ()
{
    NSInteger _currentIndex;
    NSInteger _currentType;
    CGFloat _defaultHeight;
}
@end
@implementation TXXLSuitAvoidContentView
- (instancetype)initWithHeaderType:(NSInteger)type {
    if (self = [super init]) {
        _defaultHeight = 40 + 15;
        _contentHeight = _defaultHeight + 10;
        [self _layoutMainView:type];
    }
    return self;
}
- (void)setupContentArr:(NSArray *)array {
    if (_currentType == 5) {
        [self setupType5Content:array];
    }
}
- (void)setupContentWithDic:(NSDictionary *)contentDict {
    if (_currentType == 2) {
        [self setupType2Content:contentDict];
    }else if (_currentType == 3) {
        [self setupType3Content:contentDict];
    }else if (_currentType == 4) {
        [self setupType4Content:contentDict];
    }else if (_currentType == 6 || _currentType == 7) {
        [self setupMoreContent:contentDict];
    }
}
- (void)setupType5Content:(NSArray *)array {
    NSString *titleString = nil;
    NSString *detailString = nil;
    if (KJudgeIsArrayAndHasValue(array)) {
        titleString = [array objectAtIndex:0];
        if (array.count > 1) {
            detailString = [array objectAtIndex:1];
        }
    }
    [self setupContentOneType:titleString detailString:detailString];
}
- (void)setupType4Content:(NSDictionary *)dict {
    NSString *titleString = [dict objectForKey:@"shen_sha"];
    NSString *detailString = [dict objectForKey:@"shen_sha_detail"];
    NSString *detail1 = @"古人认为每天都有一个星神值日，若遇青龙、明堂、金匮、天德、玉堂、司令六个吉神值日，诸事皆宜，称为“黄道吉日。\n如遇天刑、朱雀、白虎、天牢、玄武、勾陈六个凶神当道，或遇到天象异常如日食、月食、日中黑子、彗星见、变星见、陨石坠落等，这一天就是不吉日，称为“黑道凶日”。";
    [self setupMoreContentArray:@[@"",titleString] detailArray:@[detail1,detailString]];
}
- (void)setupType2Content:(NSDictionary *)dict {
    NSString *shengxiao = [dict objectForKey:@"shengxiao"];
    NSString *titleString = NSStringFormat(@"六合生肖：%@",shengxiao);
    NSString *detailString = NSStringFormat(@"今日与生肖%@（%@）。六合是一种暗合，该生肖是暗中帮助你的贵人。",shengxiao,[dict objectForKey:@"ganzhi"]);
    [self setupContentOneType:titleString detailString:detailString];
}
- (void)setupType3Content:(NSDictionary *)dict {
    NSString *chong = [dict objectForKey:@"chong"];
    NSString *sha = [dict objectForKey:@"sha"];
    NSString *titleString = NSStringFormat(@"冲%@煞%@",chong,sha);
    NSString *detailString = NSStringFormat(@"本日对属%@的人不太有利\n本日煞神方位在%@方，向%@方行事要小心",chong,sha,sha);
    [self setupContentOneType:titleString detailString:detailString];
}

- (void)setupContentOneType:(NSString *)title detailString:(NSString *)detailString {
    CGFloat width = SCREEN_WIDTH - 20 - 40 - 2;
    CGFloat height = _defaultHeight - 20;
    UILabel *titleLbl = [self viewWithTag:200];
    UILabel *detailLbl = [self viewWithTag:300];
    height += 21;
    if (KJudgeIsNullData(title)) {
        if (titleLbl == nil) {
            titleLbl = [self customTitleLbl:0];
            [self addSubview:titleLbl];
        }
        titleLbl.text = title;
        titleLbl.frame = CGRectMake(20, height, width, 17);
        height += 17;
        height += 18;
    }
    if (detailLbl == nil) {
        detailLbl = [self customDetailLbl:0];
        [self addSubview:detailLbl];
    }
    detailLbl.text = detailString;
    CGFloat detailHeight = [detailString calculateTextHeight:12 width:width];
    detailLbl.frame = CGRectMake(20, height, width, detailHeight);
    height += detailHeight;
    CGFloat heightNew = height > _defaultHeight ? height + 15 : _defaultHeight + 10;
    _contentHeight = heightNew;
}

- (void)setupMoreContent:(NSDictionary *)contentDict {
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
- (void)setupMoreContentArray:(NSArray *)titleArray detailArray:(NSArray *)detailArray {
    NSInteger titleCount = titleArray.count;
    NSInteger detailCount = detailArray.count;
    CGFloat width = SCREEN_WIDTH - 20 - 40 - 2;
    NSInteger maxIndex = MAX(detailCount, titleCount);
    maxIndex = MAX(_currentIndex, maxIndex);
    CGFloat height = _defaultHeight - 20;
    for (int i = 0; i < maxIndex; i ++ ) {
        UILabel *titleLbl = [self viewWithTag:200 + i];
        UILabel *detailLbl = [self viewWithTag:300 + i];
        if (i >= titleCount && i >= detailCount) {
            if (titleLbl) {
                titleLbl.text = nil;
                titleLbl.hidden = YES;
            }
            if (detailLbl) {
                detailLbl.text = nil;
                detailLbl.hidden = YES;
            }
        }else {
            height += 21;
            NSString *titleString = nil;
            NSString *detailString = nil;
            if (i < titleCount) {
                titleString = [titleArray objectAtIndex:i];
            }
            if (i < detailCount) {
                detailString = [detailArray objectAtIndex:i];
            }
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
            
        }
    }
    CGFloat heightNew = height > _defaultHeight ? height + 15 : _defaultHeight + 10;
    _contentHeight = heightNew;
    _currentIndex = maxIndex;
}
- (void)_layoutMainView:(NSInteger)headerType {
    _currentIndex = 0;
    _currentType = headerType;
    KViewRadius(self, 4);
    KViewBorderLayer(self, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    WS(ws)
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:[self returnTitleString:headerType] font:20 textColor:KColorHexadecimal(kAPP_Main_Color, 1.0) textAlignment:1 backgroundColor:nil];
    [self addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(ws).with.offset(18);
        make.left.equalTo(ws).with.offset(20);
        make.height.mas_equalTo(20);
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
- (NSString *)returnTitleString:(NSInteger)headerType {
    NSString *title = nil;
    switch (headerType) {
        case 2:
            title = @"幸运生肖";
            break;
        case 3:
            title = @"冲煞";
            break;
        case 4:
            title = @"值神";
            break;
        case 5:
            title = @"今日五行";
            break;
        case 6:
            title = @"吉神宜趋";
            break;
        case 7:
            title = @"凶神宜忌";
            break;
        case 8:
            title = @"今日胎神";
            break;
        case 9:
            title = @"彭祖百忌";
            break;
        case 10:
            title = @"建除十二神";
            break;
        case 11:
            title = @"二十八星宿";
            break;
            
        default:
            break;
    }
    return title;
}
@end
