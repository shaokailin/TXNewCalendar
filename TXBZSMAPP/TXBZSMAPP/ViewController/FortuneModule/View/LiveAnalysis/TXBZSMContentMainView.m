//
//  TXBZSMContentMainView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMContentMainView.h"
#import "TXBZSMAnalysisDetailView.h"
#import "TXBZSMAnalysisMessageView.h"
#import "TXBZSMAnalysisMessage1View.h"
@interface TXBZSMContentMainView()
{
    TXBZSMAnalysisMessageView *_messageView;
}
@property (nonatomic, weak) TXBZSMAnalysisMessage1View *xysView;
@property (nonatomic, weak) TXBZSMAnalysisDetailView *loveView;
@property (nonatomic, weak) TXBZSMAnalysisDetailView *allView;
@property (nonatomic, weak) TXBZSMAnalysisDetailView *fortuneView;
@property (nonatomic, weak) TXBZSMAnalysisDetailView *workView;
@end
@implementation TXBZSMContentMainView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)refreshData {
    NSDate *birthday = kUserMessageManager.birthDay;
    [TXXLDateManager sharedInstance].birthdayDate = birthday;
    NSString *dgz = [[TXXLDateManager sharedInstance]getGanzhiDay];
    TXBZSMHappyManager *manager = [TXBZSMHappyManager sharedInstance];
    NSDictionary *xtzy = [manager getXtzyDgz:dgz];
    NSString *xiyongshen = [manager getHappyGod:birthday];
    NSString *xysDetail = [manager getXysDetail:xiyongshen];
    [_messageView refreshData:[xtzy objectForKey:@"message"] date:birthday];
    NSDictionary *loveDict = [manager getXtLoveDgz:dgz];
    NSDictionary *fortuneDict = [manager getXtFortuneDgz:dgz];
    NSDictionary *workDict = [manager getXtWorkDgz:dgz];
    CGFloat contentHeight = 272;
    [self.xysView setupContentWithTitle:xiyongshen content:xysDetail];
    CGFloat height = [self.xysView returnMessageView];
    self.xysView.frame = CGRectMake(5, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    contentHeight += 5;
    
    [self.allView setupContent:xtzy];
    height = [self.allView returnMessageView];
    self.allView.frame = CGRectMake(5, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    contentHeight += 5;
    
    [self.loveView setupContent:loveDict];
    height = [self.loveView returnMessageView];
    self.loveView.frame = CGRectMake(5, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    contentHeight += 5;
    
    [self.fortuneView setupContent:fortuneDict];
    height = [self.fortuneView returnMessageView];
    self.fortuneView.frame = CGRectMake(5, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    contentHeight += 5;
    
    [self.workView setupContent:workDict];
    height = [self.workView returnMessageView];
    self.workView.frame = CGRectMake(5, contentHeight, SCREEN_WIDTH - 10, height);
    contentHeight += height;
    
    if (self.frameBlock) {
        self.frameBlock(contentHeight);
    }
    
}
- (TXBZSMAnalysisMessage1View *)xysView {
    if (!_xysView) {
        TXBZSMAnalysisMessage1View *xysView = [[TXBZSMAnalysisMessage1View alloc]init];
        _xysView = xysView;
        [self addSubview:xysView];
    }
    return _xysView;
}
- (TXBZSMAnalysisDetailView *)allView {
    if (!_allView) {
        TXBZSMAnalysisDetailView *allView = [[TXBZSMAnalysisDetailView alloc]initWithType:0];
        _allView = allView;
        [self addSubview:allView];
    }
    return _allView;
}
- (TXBZSMAnalysisDetailView *)loveView {
    if (!_loveView) {
        TXBZSMAnalysisDetailView *loveView = [[TXBZSMAnalysisDetailView alloc]initWithType:1];
        _loveView = loveView;
        [self addSubview:loveView];
    }
    return _loveView;
}
- (TXBZSMAnalysisDetailView *)fortuneView {
    if (!_fortuneView) {
        TXBZSMAnalysisDetailView *fortuneView = [[TXBZSMAnalysisDetailView alloc]initWithType:2];
        _fortuneView = fortuneView;
        [self addSubview:fortuneView];
    }
    return _fortuneView;
}
- (TXBZSMAnalysisDetailView *)workView {
    if (!_workView) {
        TXBZSMAnalysisDetailView *workView = [[TXBZSMAnalysisDetailView alloc]initWithType:3];
        _workView = workView;
        [self addSubview:workView];
    }
    return _workView;
}
- (void)_layoutMainView {
    _messageView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMAnalysisMessageView" owner:self options:nil]lastObject];
    [self addSubview:_messageView];
    [_messageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(272);
    }];
}
@end
