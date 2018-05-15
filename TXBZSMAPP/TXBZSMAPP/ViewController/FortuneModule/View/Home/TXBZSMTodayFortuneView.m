//
//  TXBZSMTodayFortuneView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTodayFortuneView.h"
@interface TXBZSMTodayFortuneView ()
@property (weak, nonatomic) IBOutlet UIView *circleView;
@property (weak, nonatomic) IBOutlet UILabel *allallLbl;
@property (weak, nonatomic) IBOutlet UILabel *moneyLbl;
@property (weak, nonatomic) IBOutlet UILabel *feelLbl;
@property (weak, nonatomic) IBOutlet UILabel *jobLbl;
@property (weak, nonatomic) IBOutlet UILabel *colorLbl;
@property (weak, nonatomic) IBOutlet UILabel *numberLbl;
@property (weak, nonatomic) IBOutlet UILabel *xingzuoLbl;
@property (weak, nonatomic) IBOutlet UILabel *allCircleLbl;
@property (weak, nonatomic) IBOutlet UIProgressView *allView;
@property (weak, nonatomic) IBOutlet UIProgressView *feelView;
@property (weak, nonatomic) IBOutlet UIProgressView *moneyView;
@property (weak, nonatomic) IBOutlet UIProgressView *jobView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *betweenValue;

@end
@implementation TXBZSMTodayFortuneView
- (void)awakeFromNib {
    [super awakeFromNib];
    KViewRadius(self.circleView, 30);
    KViewBorderLayer(self.circleView, KColorHexadecimal(0xffb700, 1.0), 4);
    KViewBoundsRadius(self.allView, 5.0);
    KViewBoundsRadius(self.feelView, 5.0);
    KViewBoundsRadius(self.moneyView, 5.0);
    KViewBoundsRadius(self.jobView, 5.0);
    if ([LSKPublicMethodUtil getiPhoneType] < 2) {
        self.betweenValue.constant = 35;
    }
}
- (void)setupContent:(NSDictionary *)data {
    NSString *all = [data objectForKey:@"synthesize"];
    NSString *love = [data objectForKey:@"love"];
    NSString *fortune = [data objectForKey:@"fortune"];
    NSString *work = [data objectForKey:@"work"];
    self.allallLbl.text = all;
    self.feelLbl.text = love;
    self.moneyLbl.text = fortune;
    self.jobLbl.text = work;
    NSString *content = NSStringFormat(@"%@分",all);
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc]initWithString:content];
    [att addAttributes:@{NSFontAttributeName:FontNornalInit(9)} range:NSMakeRange(content.length - 1, 1)];
    self.allCircleLbl.attributedText = att;
    self.allView.progress = [all floatValue] / 100.0;
    self.feelView.progress = [love floatValue] / 100.0;
    self.moneyView.progress = [fortune floatValue] / 100.0;
    self.jobView.progress = [work floatValue] / 100.0;
    self.colorLbl.text = [data objectForKey:@"color"];
    self.numberLbl.text = [data objectForKey:@"number"];
    self.xingzuoLbl.text = [data objectForKey:@"constellation"];
}
@end
