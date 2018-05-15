//
//  TXBZSMNameInputCell.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMNameInputCell.h"
@interface TXBZSMNameInputCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameField;

@end
@implementation TXBZSMNameInputCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    @weakify(self)
    [[self.nameField.rac_textSignal skip:1] subscribeNext:^(NSString * _Nullable x) {
        @strongify(self)
        if (self.nameBlock) {
            self.nameBlock(x);
        }
    }];
}
- (void)setupCellContentWithName:(NSString *)name {
    self.nameField.text = name;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.nameField resignFirstResponder];
    return YES;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
