//
//  TXXLMoreCollectionViewCell.m
//  TXNewCalendar
//
//  Created by linshaokai on 2018/1/29.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLMoreCollectionViewCell.h"
@interface TXXLMoreCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;


@end
@implementation TXXLMoreCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
- (void)setupContentWithTitle:(NSString *)title {
    self.titleLbl.text = title;
}
- (void)changeSelectState:(BOOL)isSelect {
    self.titleLbl.textColor = isSelect? [UIColor whiteColor]:KColorHexadecimal(kText_Title_Color, 1.0);
    self.bgImageView.image = isSelect? ImageNameInit(@"more_s"):ImageNameInit(@"more_n");
}
- (NSString *)returnTitleString {
    return _titleLbl.text;
}
@end
