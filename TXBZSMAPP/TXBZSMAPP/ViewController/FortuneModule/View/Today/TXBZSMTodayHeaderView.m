//
//  TXBZSMTodayHeaderView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/7.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMTodayHeaderView.h"

@implementation TXBZSMTodayHeaderView
{
    UIImageView *_userPhoto;
    UILabel *_nickName;
    UILabel *_birthdayLbl;
    UILabel *_chinesedayLbl;
    UILabel *_sexLbl;
    UIView *_lineView;
}
- (instancetype)init {
    if (self = [super init]) {
        [self _layoutMainView];
    }
    return self;
}
- (void)_layoutMainView {
    _userPhoto = [[UIImageView alloc]init];
    [self addSubview:_userPhoto];
    [_userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).with.offset(-WIDTH_RACE_6S(28));
        make.left.equalTo(self).with.offset(WIDTH_RACE_6S(45));
        make.size.mas_equalTo(CGSizeMake(WIDTH_RACE_6S(106), WIDTH_RACE_6S(106)));
    }];
    
    _nickName = [LSKViewFactory initializeLableWithText:nil font:16 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _nickName.font = FontBoldInit(16);
    [self addSubview:_nickName];
    [_nickName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userPhoto).with.offset(23);
        make.left.equalTo(self->_userPhoto.mas_right).with.offset(28);
    }];
    _sexLbl = [LSKViewFactory initializeLableWithText:nil font:16 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    _sexLbl.font = FontBoldInit(16);
    [self addSubview:_sexLbl];
    [_sexLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_nickName.mas_right);
        make.centerY.equalTo(self->_nickName);
    }];
    _lineView = [[UIView alloc]init];
    _lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_lineView];
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self->_sexLbl);
        make.top.equalTo(self->_sexLbl.mas_bottom).with.offset(5);
        make.height.mas_equalTo(1);
    }];
    
    _birthdayLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    [self addSubview:_birthdayLbl];
    [_birthdayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_nickName);
        make.top.equalTo(self->_nickName.mas_bottom).with.offset(14);
    }];
    _chinesedayLbl = [LSKViewFactory initializeLableWithText:nil font:12 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    [self addSubview:_chinesedayLbl];
    [_chinesedayLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self->_birthdayLbl);
        make.top.equalTo(self->_birthdayLbl.mas_bottom).with.offset(4);
    }];
    [self setupContent];
}
- (void)setupContent {
    _userPhoto.image = kUserMessageManager.userPhoto;
    _nickName.text = kUserMessageManager.nickName;
    if (!KJudgeIsNullData(_nickName.text)) {
        _lineView.hidden = YES;
    }else {
        _lineView.hidden = NO;
    }
    _sexLbl.text = kUserMessageManager.isBoy?@"帅哥":@"美女";
    NSDate *date = kUserMessageManager.birthDay;
    _birthdayLbl.text = [date dateTransformToString:@"yyyy年MM月dd日HH时"];
    TXXLDateManager *dateManager = [TXXLDateManager sharedInstance];
    dateManager.birthdayDate = date;
    _chinesedayLbl.text = NSStringFormat(@"%@年%@%@%@时",[dateManager tgdzString],dateManager.chineseMonthString,dateManager.chineseDayString,[dateManager getHourChinese]);
}
@end
