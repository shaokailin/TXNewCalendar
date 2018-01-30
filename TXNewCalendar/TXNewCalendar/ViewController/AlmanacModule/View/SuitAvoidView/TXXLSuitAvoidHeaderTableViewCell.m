//
//  TXXLSuitAvoidHeaderTableViewCell.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLSuitAvoidHeaderTableViewCell.h"
@interface TXXLSuitAvoidHeaderTableViewCell ()
{
    NSInteger _currentType;
    NSInteger _currentIndex;
}
@property (nonatomic, weak) UILabel *titleLbl;
@property (nonatomic, weak) UIView *conView;
@end
@implementation TXXLSuitAvoidHeaderTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)setupContentWithType:(NSInteger)type setupContent:(NSArray *)content{
    if (_currentType != type) {
        _currentType = type;
        self.titleLbl.text = _currentType == 0?@"宜":@"忌";
        self.titleLbl.backgroundColor = _currentIndex == 0?KColorHexadecimal(kText_LightGreen_Color, 1.0):KColorHexadecimal(kAPP_Main_Color, 1.0);
        [self reloadContentText:content];
    }
    
}
- (void)reloadContentText:(NSArray *)content {
    NSInteger contentCount = content.count;
    CGFloat width = SCREEN_WIDTH - 20 - 40 - 2;
    NSInteger maxIndex = MAX(_currentIndex, contentCount);
    CGFloat height = 12 + 40;
    for (int i = 0; i < maxIndex; i ++ ) {
        UILabel *titleLbl = [self.conView viewWithTag:200 + i];
        UILabel *detailLbl = [self.conView viewWithTag:300 + i];
        if (i < contentCount) {
            height += 21;
            NSDictionary *dict = [content objectAtIndex:i];
            NSString *titleString = [dict objectForKey:@"title"];
            NSString *detailString = [dict objectForKey:@"detail"];
            BOOL isTitleString = KJudgeIsNullData(titleString);
            if (isTitleString) {
                if (titleLbl == nil) {
                    titleLbl = [self customTitleLbl:i];
                    [self.conView addSubview:titleLbl];
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
                    [self.conView addSubview:detailLbl];
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
    _currentIndex = contentCount;
}
- (void)_layoutMainView {
    _currentType = -1;
    _currentIndex = 0;
    self.selectionStyle = 0;
    UIView *conView = [[UIView alloc]init];
    KViewRadius(conView, 4);
    KViewBorderLayer(conView, KColorHexadecimal(kLineMain_Color, 1.0), 1);
    self.conView = conView;
    [self.contentView addSubview:conView];
    WS(ws)
    [conView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.contentView).with.insets(UIEdgeInsetsMake(10, 10, 0, 10));
    }];
    
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"宜" font:17 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(kText_LightGreen_Color, 1.0)];
    KViewBoundsRadius(titleLbl, 20);
    self.titleLbl = titleLbl;
    [conView addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(conView).with.offset(12);
        make.centerX.equalTo(conView);
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
