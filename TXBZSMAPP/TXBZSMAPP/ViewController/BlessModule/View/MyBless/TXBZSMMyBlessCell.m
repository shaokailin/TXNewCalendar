//
//  TXBZSMMyBlessCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/9.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessCell.h"
@interface TXBZSMMyBlessCell ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *timeLbl;
@property (weak, nonatomic) IBOutlet UILabel *allCountLbl;
@property (weak, nonatomic) IBOutlet UILabel *hasCountLbl;
@property (weak, nonatomic) IBOutlet UIButton *blessBtn;
@property (weak, nonatomic) IBOutlet UIImageView *stateImage;


@end
@implementation TXBZSMMyBlessCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    KViewRadius(self.blessBtn, 3.0);
    KViewBorderLayer(self.blessBtn, KColorHexadecimal(0x21A8E4, 1.0), 0.5);
}
- (void)setFrame:(CGRect)frame {
    frame.size.height -= 5;
    [super setFrame:frame];
}
- (void)setupCellContent:(TXBZSMGodMessageModel *)model {
    self.iconImage.image = ImageNameInit(model.godImage);
    NSString *timeString = NSStringFormat(@"恭请于%@",model.godInDate);
    self.timeLbl.text = timeString;
    NSInteger count = model.hasCount;
    self.allCountLbl.text = NSStringFormat(@"累计祈福 %ld 天",count);
    self.hasCountLbl.text = NSStringFormat(@"连续祈福 %ld 天",count);
    if (KJudgeIsNullData(model.wishContent)) {
        [self.blessBtn setTitle:@"前往还愿" forState:UIControlStateNormal];
    }else {
        [self.blessBtn setTitle:@"前往祈福" forState:UIControlStateNormal];
    }
    if (count < 27) {
        self.stateImage.image = ImageNameInit(@"mybless_wan");
    }else if (count < 54){
        self.stateImage.image = ImageNameInit(@"mybless_wan1");
    }else if (count < 81){
        self.stateImage.image = ImageNameInit(@"mybless_wan2");
    }else {
        self.stateImage.image = ImageNameInit(@"mybless_wan3");
    }
}
- (IBAction)jumpBless:(id)sender {
    if (self.block) {
        self.block(1, self);
    }
}
- (IBAction)wanClick:(id)sender {
    if (self.block) {
        self.block(2, self);
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
