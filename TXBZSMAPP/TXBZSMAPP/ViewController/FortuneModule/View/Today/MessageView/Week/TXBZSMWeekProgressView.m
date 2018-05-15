//
//  TXBZSMWeekProgressView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWeekProgressView.h"
#import "PNChart.h"
@implementation TXBZSMWeekProgressView
{
    PNRadarChart *_radarChartView;
    NSInteger _type;
}
- (instancetype)initWithFrame:(CGRect)frame type:(NSInteger)type {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupScore:(NSDictionary *)dict {
    CGFloat chushu = 100.0;
    NSMutableArray *dataArray = [NSMutableArray array];
    NSInteger money = [[dict objectForKey:@"fortune"]integerValue];
    NSInteger love = [[dict objectForKey:@"love"]integerValue];
    NSInteger work = [[dict objectForKey:@"work"]integerValue];
    NSInteger health = [[dict objectForKey:@"health"]integerValue];
    chushu = 10.0;
    money *= chushu;
    love *= chushu;
    work *= chushu;
    health *= chushu;
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:health description:NSStringFormat(@"%@%ld%%",[self returnTitle:2],(long)health)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:love description:NSStringFormat(@"%@%ld%%",[self returnTitle:0],(long)love)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:work description:NSStringFormat(@"%@%ld%%",[self returnTitle:3],(long)work)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:money description:NSStringFormat(@"%@%ld%%",[self returnTitle:1],(long)money)]];
    
    _radarChartView.chartData = dataArray;
    [_radarChartView strokeChart];
}
- (void)btnClick:(UIButton *)btn {
    
}
- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    CGFloat x = 0;
    if ([LSKPublicMethodUtil getiOSSystemLevel] < 2 && _type == 0) {
        x = -20;
    }
    _radarChartView = [[PNRadarChart alloc] initWithFrame:CGRectMake(x, 0, SCREEN_WIDTH - (_type == 0? 20:10), CGRectGetHeight(self.frame)) items:@[] valueDivider:20];
    _radarChartView.maxValue = 100;
    _radarChartView.labelStyle = PNRadarChartLabelStyleHorizontal;
    _radarChartView.plotColor = KColorHexadecimal(0xdd33ee, 0.5);
    _radarChartView.fontColor = KColorHexadecimal(0x222222, 1.0);
    _radarChartView.fontSize = WIDTH_RACE_6S(10);
    _radarChartView.webColor = KColorHexadecimal(0xdd33ee, 1.0);
    [self addSubview:_radarChartView];
    if (_type == 0) {
        NSArray *colorArray = [NSArray arrayWithObjects:@{@"title":@"情感",@"color":KColorHexadecimal(0x3631f7, 1.0)},@{@"title":@"财富",@"color":KColorHexadecimal(0x00633d, 1.0)},@{@"title":@"工作",@"color":KColorHexadecimal(0xee5b33, 1.0)},@{@"title":@"健康",@"color":KColorHexadecimal(0xdd33ee, 1.0)}, nil];
        CGFloat width = 28;
        CGFloat height = 13;
        CGFloat viewWidth = CGRectGetWidth(self.frame);
        for (int i = 0; i < colorArray.count; i++) {
            NSDictionary *dict = [colorArray objectAtIndex:i];
            UIButton *btn = [LSKViewFactory initializeButtonWithTitle:[dict objectForKey:@"title"] target:self action:@selector(btnClick:) textfont:7 textColor:[UIColor whiteColor]];
            KViewRadius(btn, 6);
            [btn setBackgroundColor: [dict objectForKey:@"color"]];
            btn.tag = 200 + i;
            btn.frame = CGRectMake(viewWidth - 25 - width, 15 + (height + 15) * i, width, height);
            [self addSubview:btn];
        }
    }
}
- (NSString *)returnTitle:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 0:
            title = @"爱情";
            break;
        case 1:
            title = @"财运";
            break;
        case 2:
            title = @"健康";
            break;
        case 3:
            title = @"工作";
            break;
        case 4:
            title = @"综合";
            break;
            
        default:
            break;
    }
    return title;
}
@end
