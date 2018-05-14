//
//  TXBZSMWishInputView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishInputView.h"
#import "UITextView+Extend.h"
static const NSInteger kMAX_LIMIT_NUMS = 100;
@interface TXBZSMWishInputView ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *contentBgView;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *limitLbl;

@property (weak, nonatomic) IBOutlet UIView *remarkBgView;
@end
@implementation TXBZSMWishInputView
- (void)awakeFromNib {
    [super awakeFromNib];
    [self.textView setPlaceholder:@"请填写愿望" placeholdColor:KColorHexadecimal(0xcecece, 1.0)];
    KViewRadius(self.contentBgView, 5);
    KViewRadius(self.remarkBgView, 5.0);
    KViewBorderLayer(self.contentBgView, KColorHexadecimal(0xcecece, 1.0), 1);
    @weakify(self)
    [[[self.textView.rac_textSignal merge:RACObserve(self.textView, text)]skip:2]subscribeNext:^(id  _Nullable x) {
        @strongify(self)
        self->_contentString = x;
        [self textChange:x];
    }];
    [self.textField.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        self->_userString = x;
    }];
}
- (void)setupGodImage:(NSString *)image {
    self.iconImage.image = ImageNameInit(image);
}
- (void)textChange:(NSString *)text {
    [self changeLimit];
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range
 replacementText:(NSString *)text
{
    NSString *comcatstr = [textView.text stringByReplacingCharactersInRange:range withString:text];
    NSInteger caninputlen = kMAX_LIMIT_NUMS - comcatstr.length;
    if (caninputlen >= 0) {
        return YES;
    } else {
        NSInteger len = text.length + caninputlen;
        //防止当text.length + caninputlen < 0时，使得rg.length为一个非法最大正数出错
        NSRange rg = {0,MAX(len,0)};
        if (rg.length > 0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}
- (void)changeLimit {
    NSString  *nsTextContent = self.textView.text;
    NSInteger existTextNum = nsTextContent.length;
    if (existTextNum > kMAX_LIMIT_NUMS){
        //截取到最大位置的字符
        NSString *s = [nsTextContent substringToIndex:kMAX_LIMIT_NUMS];
        [self.textView setText:s];
    }
    //不让显示负数
    self.limitLbl.text = [NSString stringWithFormat:@"还剩%ld个字",kMAX_LIMIT_NUMS - (long)existTextNum];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.textView resignFirstResponder];
    [self.textField resignFirstResponder];
}
- (void)dealloc {
    _textView.delegate = nil;
}

@end
