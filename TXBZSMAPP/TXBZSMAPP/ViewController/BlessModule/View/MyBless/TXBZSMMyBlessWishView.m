//
//  TXBZSMMyBlessWishView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessWishView.h"
#import "UITextView+Extend.h"
//static const NSInteger kMAX_LIMIT_NUMS = 200;
@interface TXBZSMMyBlessWishView ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UILabel *limitLbl;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end
@implementation TXBZSMMyBlessWishView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textView setPlaceholder:@"在这里写下你的愿望......" placeholdColor:KColorHexadecimal(0xb4b4b4, 1.0)];
     KViewRadius(self.contentBgView, 3);
    KViewBorderLayer(self.contentBgView, KColorHexadecimal(kText_Title_Color, 1.0), 0.5);
    KViewRadius(self.textField, 3);
    KViewBorderLayer(self.textField, KColorHexadecimal(kText_Title_Color, 1.0), 0.5);
//    self.textView.delegate = self;
    self.textField.leftViewMode = UITextFieldViewModeAlways;
    self.textField.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 3, 10)];
    @weakify(self)
    [[[self.textView.rac_textSignal merge:RACObserve(self.textView, text)]skip:2]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self->_contentString = x;
//        [self textChange:x];
    }];
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
       @strongify(self)
        self->_userString = x;
    }];
}

- (void)setupGodImage:(NSString *)image {
    self.imageView.image = ImageNameInit(image);
}
//- (void)textChange:(NSString *)text {
//    [self changeLimit];
//}
//- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
// replacementText:(NSString *)text
//{
//    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
//    NSInteger caninputlen = kMAX_LIMIT_NUMS - comcatstr.length;
//    if (caninputlen >= 0) {
//        return YES;
//    } else {
//        NSInteger len = text.length + caninputlen;
//        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
//        NSRange rg = {0,MAX(len,0)};
//        if (rg.length > 0) {
//            NSString *s = [text substringWithRange:rg];
//            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
//        }
//        return NO;
//    }
//
//}
//- (void)changeLimit {
//    NSString  *nsTextContent = self.textView.text;
//    NSInteger existTextNum = nsTextContent.length;
//    if (existTextNum > kMAX_LIMIT_NUMS){
//        //截取到最大位置的字符
//        NSString *s = [nsTextContent substringToIndex:kMAX_LIMIT_NUMS];
//        [self.textView setText:s];
//    }
//    //不让显示负数
//    self.limitLbl.text = [NSString stringWithFormat:@"%ld/%zd",(long)existTextNum];
//}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}
- (void)dealloc {
    _textView.delegate = nil;
}
@end
