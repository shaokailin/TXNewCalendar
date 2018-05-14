//
//  TXBZSMBlessPlatformView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessPlatformView.h"
@interface TXBZSMBlessPlatformView ()
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *nameLbl;
@property (weak, nonatomic) IBOutlet UILabel *countLbl;
@property (weak, nonatomic) IBOutlet UILabel *directionLbl;
@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (nonatomic, weak) UILabel *titleLbl;

@end
@implementation TXBZSMBlessPlatformView
- (void)awakeFromNib {
    [super awakeFromNib];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeData) name:kBlessDataChangeNotice object:nil];
    [self changeData];
}
- (void)changeData {
    NSArray *data = kUserMessageManager.blessArray;
    if (KJudgeIsArrayAndHasValue(data)) {
        self.contentView.hidden = NO;
        if (_titleLbl) {
            [_titleLbl removeFromSuperview];
        }
        TXBZSMGodMessageModel *model = [data objectAtIndex:0];
        self.iconImg.image = ImageNameInit(model.godImage);
        self.nameLbl.text = model.godName;
        self.countLbl.text = NSStringFormat(@"已供奉了%ld天，连续祈福%ld天",model.hasCount,model.hasCount);
        self.directionLbl.text = NSStringFormat(@"保佑方向：%@",model.blessType);
        
    }else {
        self.iconImg.image = ImageNameInit(@"nogod");
        self.contentView.hidden = YES;
        self.titleLbl.hidden = NO;
    }
}
- (UILabel *)titleLbl {
    if (!_titleLbl) {
        UILabel * title = [LSKViewFactory initializeLableWithText:@"您还没有祈福记录" font:13 textColor:KColorHexadecimal(kText_Title_Color, 1.0) textAlignment:1 backgroundColor:nil];
        _titleLbl = title;
        [self addSubview:title];
        [title mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconImg.mas_right).with.offset(15);
            make.centerY.equalTo(self).with.offset(5);
            make.right.equalTo(self).with.offset(-15);
        }];
    }
    return _titleLbl;
}
@end
