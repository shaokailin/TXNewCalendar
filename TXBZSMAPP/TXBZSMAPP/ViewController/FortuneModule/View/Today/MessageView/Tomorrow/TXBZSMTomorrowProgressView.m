//
//  TXBZSMTomorrowProgressView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTomorrowProgressView.h"
@interface TXBZSMTomorrowProgressView ()
@property (weak, nonatomic) IBOutlet UIView *allBgView;
@property (weak, nonatomic) IBOutlet UILabel *allLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *fortuneProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *jobProgress;
@property (weak, nonatomic) IBOutlet UIProgressView *loveProgress;
@property (weak, nonatomic) IBOutlet UILabel *fortuneLbl;
@property (weak, nonatomic) IBOutlet UILabel *jobLbl;
@property (weak, nonatomic) IBOutlet UILabel *loveLbl;

@end
@implementation TXBZSMTomorrowProgressView

- (void)awakeFromNib {
    [super awakeFromNib];
    KViewRadius(self.allBgView, 30);
    KViewBorderLayer(self.allBgView, KColorHexadecimal(0xffb700, 1.0), 2.5);
    KViewBoundsRadius(self.fortuneProgress, 5.0);
    KViewBoundsRadius(self.jobProgress, 5.0);
    KViewBoundsRadius(self.loveProgress, 5.0);
}
- (void)setupContentWithAll:(NSString *)all love:(NSString *)love fortune:(NSString *)fortune work:(NSString *)work  {
    self.loveLbl.text = NSStringFormat(@"%@分",love);
    self.fortuneLbl.text = NSStringFormat(@"%@分",fortune);;
    self.jobLbl.text = NSStringFormat(@"%@分",work);
    NSString *content = NSStringFormat(@"%@分",all);
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:content];
    [att addAttributes:@{NSFontAttributeName:FontNornalInit(9)} range:NSMakeRange(content.length - 1, 1)];
    self.allLbl.attributedText = att;
    self.loveProgress.progress = [love floatValue] / 100.0;
    self.fortuneProgress.progress = [fortune floatValue] / 100.0;
    self.jobProgress.progress = [work floatValue] / 100.0;
}
@end
