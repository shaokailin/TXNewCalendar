//
//  TXBZSMInitWishCardView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMInitWishCardView.h"
#import "SCAdView.h"
@interface TXBZSMInitWishCardView ()
//@property (weak, nonatomic) IBOutlet UIView *contentView;
//@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIView *remarkView;
//@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
//@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (nonatomic, weak) SCAdView *adView;
//110 193  126
@end
@implementation TXBZSMInitWishCardView
- (void)awakeFromNib {
    [super awakeFromNib];
    KViewRadius(self.remarkView, 5.0);
    CGFloat top = WIDTH_RACE_6S(120);
    if ([LSKPublicMethodUtil getiPhoneType] == 0) {
        top = 70;
    }
    SCAdView *adView = [[SCAdView alloc] initWithBuilder:^(SCAdViewBuilder *builder) {
        builder.adArray = @[];
        builder.viewFrame = (CGRect){0,top,SCREEN_WIDTH,WIDTH_RACE_6S(240)};
        builder.adItemSize = (CGSize){WIDTH_RACE_6S(110),WIDTH_RACE_6S(193)};//{78.6,137.86}
        builder.minimumLineSpacing = WIDTH_RACE_6S(100);
        builder.secondaryItemMinAlpha = 1;
        builder.threeDimensionalScale = 1.0;
        builder.allowedInfinite = NO;
        builder.itemCellNibName = @"TXBZSMCardCell";
    }];
    adView.backgroundColor = [UIColor clearColor];
    self.adView = adView;
    [self addSubview:adView];
}

- (IBAction)backClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (IBAction)shareClick:(id)sender {
    if (self.block) {
        self.block(1);
    }
}

- (void)setupContent:(TXBZSMWishTreeModel *)model {
    [self.adView reloadWithDataArray:[NSMutableArray arrayWithObjects:@{@"type":@(0),@"image":model.image},@{@"type":@"1",@"content":model.wishContent,@"title":model.wishTitle}, nil]];
//    self.iconImageView.image = ImageNameInit(model.image);
//    self.contentLbl.text = model.wishContent;
//    self.nameLbl.text = NSStringFormat(@"--%@",model.wishTitle);
}
@end
