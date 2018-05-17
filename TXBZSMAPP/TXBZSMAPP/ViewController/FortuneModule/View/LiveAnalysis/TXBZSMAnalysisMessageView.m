//
//  TXBZSMAnalysisMessageView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMAnalysisMessageView.h"
@interface TXBZSMAnalysisMessageView()
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *sexLbl;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLbl;
@property (weak, nonatomic) IBOutlet UILabel *chinessLbl;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end
@implementation TXBZSMAnalysisMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    for (int i = 0; i < 6; i++) {
        UILabel *lbl = [self viewWithTag:400 + i];
        KViewBoundsRadius(lbl, 8);
    }
}
- (void)refreshData:(NSString *)content date:(NSDate *)date {
    self.nickName.text = kUserMessageManager.nickName;
    self.sexLbl.text = kUserMessageManager.isBoy?@"帅哥":@"美女";
    if (!KJudgeIsNullData(self.nickName.text)) {
        self.lineView.hidden = YES;
    }else {
        self.lineView.hidden = NO;
    }
    self.birthdayLbl.text = [date dateTransformToString:@"yyyy年MM月dd日HH时"];
    TXXLDateManager *dateManager = [TXXLDateManager sharedInstance];
    self.chinessLbl.text = NSStringFormat(@"%@年%@%@%@时",[dateManager tgdzString],dateManager.chineseMonthString,dateManager.chineseDayString,[dateManager getHourChinese]);
    NSArray *data = [content componentsSeparatedByString:@"，"];
    for (int i = 0; i < 6; i++) {
        UILabel *lbl = [self viewWithTag:400 + i];
        if (i < data.count) {
            lbl.hidden = NO;
            lbl.text = NSStringFormat(@"   %@   ",[data objectAtIndex:i]);
        }else {
            lbl.hidden = YES;
        }
    }
}
@end
