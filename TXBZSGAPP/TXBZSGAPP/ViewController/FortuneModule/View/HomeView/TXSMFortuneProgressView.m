//
//  TXSMFortuneProgressView.m
//  TXTJSMAPP
//
//  Created by shaokai lin on 2018/4/3.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneProgressView.h"
#import "PNChart.h"
@interface TXSMFortuneProgressView ()
{
    ProgressType _type;
    PNRadarChart *_radarChartView;
}
@end

@implementation TXSMFortuneProgressView

- (instancetype)initWithFrame:(CGRect)frame progressType:(ProgressType)type {
    if (self = [super initWithFrame:frame]) {
        _type = type;
        [self _layoutMainView];
    }
    return self;
}
- (void)setupScore:(NSDictionary *)dict {
//     _timeLbl.text = time;
    CGFloat chushu = 100.0;
    NSMutableArray *dataArray = [NSMutableArray array];
    NSInteger money = [[dict objectForKey:@"fortune"]integerValue];
    NSInteger love = [[dict objectForKey:@"love"]integerValue];
    NSInteger work = [[dict objectForKey:@"work"]integerValue];
    NSInteger health = [[dict objectForKey:@"health"]integerValue];
    if (_type == ProgressType_Week) {
        chushu = 10.0;
        money *= chushu;
        love *= chushu;
        work *= chushu;
        health *= chushu;
    }
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:love description:NSStringFormat(@"%@%ld%%",[self returnTitle:0],(long)love)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:money description:NSStringFormat(@"%@%ld%%",[self returnTitle:1],(long)money)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:health description:NSStringFormat(@"%@%ld%%",[self returnTitle:2],(long)health)]];
    [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:work description:NSStringFormat(@"%@%ld%%",[self returnTitle:3],(long)work)]];
    if (_type == ProgressType_Today) {
        NSInteger synthesize = [[dict objectForKey:@"synthesize"]integerValue];
        [dataArray addObject:[PNRadarChartDataItem dataItemWithValue:synthesize description:NSStringFormat(@"%@%ld%%",[self returnTitle:4],(long)synthesize)]];
    }
    _radarChartView.chartData = dataArray;
    [_radarChartView strokeChart];
}

- (void)_layoutMainView {
    self.backgroundColor = [UIColor whiteColor];
    _radarChartView = [[PNRadarChart alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, CGRectGetHeight(self.frame)) items:@[] valueDivider:20];
    _radarChartView.maxValue = 100;
    _radarChartView.labelStyle = PNRadarChartLabelStyleHorizontal;
    _radarChartView.plotColor = KColorHexadecimal(0x8cb3f3, 0.5);
    _radarChartView.fontColor = KColorHexadecimal(kText_Title_Color, 1.0);
    _radarChartView.fontSize = WIDTH_RACE_6S(18);
    _radarChartView.webColor = KColorHexadecimal(0xeeeeee, 1.0);
    [self addSubview:_radarChartView];
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
