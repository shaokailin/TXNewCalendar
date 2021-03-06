//
//  TXBZSMUserMessageView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/4.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMUserMessageView.h"
@interface TXBZSMUserMessageView ()
@property (weak, nonatomic) IBOutlet UIImageView *userPhoto;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UILabel *xiyongLbl;
@property (weak, nonatomic) IBOutlet UILabel *birthdayLbl;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *between;
@property (weak, nonatomic) IBOutlet UIView *bottomView;

@end
@implementation TXBZSMUserMessageView

- (void)awakeFromNib {
    [super awakeFromNib];
    KViewBoundsRadius(self.userPhoto, 35);
    BOOL isIphone5 = [LSKPublicMethodUtil getiPhoneType] < 2?YES:NO;
    if (isIphone5) {
        self.between.constant = 15;
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(jumpBzmp)];
    [self.bottomView addGestureRecognizer:tap];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadData) name:kUserMessageChangeNotice object:nil];
    [self reloadData];
}
- (IBAction)jumpMeClick:(id)sender {
    if (self.block) {
        self.block(0);
    }
}
- (void)jumpBzmp {
    if (self.block) {
        self.block(1);
    }
}
- (void)reloadData {
    if (kUserMessageManager.birthDay) {
        self.userPhoto.image = kUserMessageManager.userPhoto;
        self.nickName.text = NSStringFormat(@"%@%@",kUserMessageManager.nickName,(kUserMessageManager.isBoy?@"帅哥":@"美女"));
        NSDate *birthday = kUserMessageManager.birthDay;
        self.birthdayLbl.text = [birthday dateTransformToString:@"yyyy年MM月dd日 HH时"];
        self.xiyongLbl.text = NSStringFormat(@"喜用神%@",[[TXBZSMHappyManager sharedInstance] getHappyGod:kUserMessageManager.birthDay]);
        NSString *dgz = [[TXXLDateManager sharedInstance]getGanzhiDay];
        [self setupLuckRemark:dgz];
    }
}
- (void)setupLuckRemark:(NSString *)dgz {
    NSDictionary *dict = [[TXBZSMHappyManager sharedInstance]getXtzyDgz:dgz];
    NSString *content = [dict objectForKey:@"message"];
    NSArray *array = [content componentsSeparatedByString:@"，"];
    NSInteger maxRow = ceil(array.count / 3.0);
    BOOL isIphone5 = [LSKPublicMethodUtil getiPhoneType] < 2?YES:NO;
    for (int i = 0; i < maxRow; i ++) {
        CGFloat x = isIphone5? (i == 0? 158:118):170;
        
        for (int j = 0; j < 3; j ++) {
            NSInteger index = i * 3 + j;
            if (index >= array.count) {
                break;
            }
            UILabel *lbl = [self viewWithTag:300 + index];
            NSString *text = [array objectAtIndex:index];
            CGFloat width = [text calculateTextWidth:9] + 6;
            if (!lbl) {
                lbl = [LSKViewFactory initializeLableWithText:nil font:9 textColor:[UIColor whiteColor] textAlignment:1 backgroundColor:KColorHexadecimal(0xdd33ee, 1.0)];
                KViewBoundsRadius(lbl, 2.0);
                lbl.tag = 300 + index;
                [self addSubview:lbl];
            }
            lbl.text = text;
            lbl.frame = CGRectMake(x, 65 + 22 * i, width, 15);
            x += (width + 5);
        }
        
        
    }
    
}
@end
