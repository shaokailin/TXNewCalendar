//
//  TXBZSMMessageAlertView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMessageAlertView.h"
#import "LSKActionSheetView.h"
#import "HSPDatePickView.h"
@interface TXBZSMMessageAlertView()<UITextFieldDelegate>
{
    NSDate *_selectDate;
    BOOL _isBoy;
}
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *sexTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextField;
@property (weak, nonatomic) IBOutlet UIView *contentView;

@end
@implementation TXBZSMMessageAlertView
- (void)awakeFromNib {
    [super awakeFromNib];
    KViewRadius(self.contentView, 5.0);
    KViewBorderLayer(self.contentView, KColorHexadecimal(0xe8e7e2, 1.0), 1.0);
    self.nameTextField.delegate = self;
    self.sexTextField.delegate = self;
    self.birthdayTextField.delegate = self;
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField == self.nameTextField) {
        return YES;
    }else {
        [self.nameTextField resignFirstResponder];
        if (textField == self.sexTextField) {
            @weakify(self)
            LSKActionSheetView *sheetView = [[LSKActionSheetView alloc]initWithCancelButtonTitle:@"取消" clcikIndex:^(NSInteger seletedIndex) {
                if (seletedIndex != 0) {
                    @strongify(self)
                    self->_isBoy = seletedIndex == 1?YES:NO;
                    self.sexTextField.text = seletedIndex == 1?@"男":@"女";
                }
            } otherButtonTitles:@"男",@"女", nil];
            [sheetView showInView];
        }else {
            HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbar:self.tabHeight];
            datePick.title = @"出生日期";
            datePick.maxDate = [NSDate date];
            datePick.minDate = [NSDate stringTransToDate:@"1940-01-01" withFormat:@"yyyy-MM-dd"];
            datePick.datePickerMode = UIDatePickerModeDateAndTime;
            @weakify(self)
            datePick.dateBlock = ^(NSDate *date) {
                @strongify(self);
                self->_selectDate = date;
                self.birthdayTextField.text = [date dateTransformToString:@"yyyy-MM-dd HH:mm"];
            };
            [[UIApplication sharedApplication].keyWindow addSubview:datePick];
            [datePick showInView];
        }
        return NO;
    }
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancleClick:(id)sender {
    [self.nameTextField resignFirstResponder];
    [kUserMessageManager setupDefaultData];
    if (self.block) {
        self.block(0);
    }
    [self removeFromSuperview];
}
- (IBAction)sureClick:(id)sender {
    [self.nameTextField resignFirstResponder];
    if (!KJudgeIsNullData([self.nameTextField.text stringBySpaceTrim])) {
        [SKHUD showMessageInWindowWithMessage:@"请输入名字"];
        return;
    }
    if (!KJudgeIsNullData(self.sexTextField.text)) {
        [SKHUD showMessageInWindowWithMessage:@"请选择性别"];
        return;
    }
    if (!KJudgeIsNullData(self.birthdayTextField.text)) {
        [SKHUD showMessageInWindowWithMessage:@"请选择出生日期"];
        return;
    }
    kUserMessageManager.nickName = [self.nameTextField.text stringBySpaceTrim];
    kUserMessageManager.isBoy = _isBoy;
    kUserMessageManager.birthDay = _selectDate;
    if (self.block) {
        self.block(1);
    }
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
