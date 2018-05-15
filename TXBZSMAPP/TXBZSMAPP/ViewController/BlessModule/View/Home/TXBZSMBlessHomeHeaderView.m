//
//  TXBZSMBlessHomeHeaderView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/8.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMBlessHomeHeaderView.h"
#import "TXBZSMBlessHomeNaviButton.h"
@implementation TXBZSMBlessHomeHeaderView
{
    UIImageView *_userPhoto;
    UILabel *_countLbl;
    UIView *_btnView;
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _layoutMainView];
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeUserPhoto) name:kUserMessageChangeNotice object:nil];
    }
    return self;
}
- (void)setupContent:(NSArray *)array {
    [self customBtnView:array];
}
- (void)jumpBlessEvent {
    if (self.block) {
        self.block(1, 1);
    }
}
- (void)changeUserPhoto {
    _userPhoto.image = kUserMessageManager.userPhoto;
}
- (void)btnClick:(UIButton *)btn {
    if (self.block) {
        self.block(2, btn.tag - 600);
    }
}
- (void)myBlessClick {
    if (self.block) {
        self.block(0, 1);
    }
}
- (void)changeData {
    NSArray *data = kUserMessageManager.blessArray;
    NSInteger count = 0;
    if (data.count > 0) {
        for (TXBZSMGodMessageModel *model in data) {
            count += (model.hasCount * 20);
        }
    }
    _countLbl.text = NSStringFormat(@"%ld",count);
}
- (void)_layoutMainView {
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeData) name:kBlessDataChangeNotice object:nil];
    UIView *userMessage = [[UIView alloc]init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(myBlessClick)];
    [userMessage addGestureRecognizer:tap];
    [self addSubview:userMessage];
    [userMessage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self);
        make.height.mas_equalTo(119);
    }];
    _userPhoto = [[UIImageView alloc]init];
    KViewBoundsRadius(_userPhoto, 35);
    [userMessage addSubview:_userPhoto];
    [_userPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(userMessage).with.offset(20);
        make.top.equalTo(userMessage);
        make.size.mas_equalTo(CGSizeMake(70, 70));
    }];
    UILabel *titleLbl = [LSKViewFactory initializeLableWithText:@"我的祈福" font:14 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    titleLbl.font = FontBoldInit(14);
    [userMessage addSubview:titleLbl];
    [titleLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(userMessage).with.offset(28);
        make.left.equalTo(self->_userPhoto.mas_right).with.offset(15);
    }];
    UILabel *englishLbl = [LSKViewFactory initializeLableWithText:@"My blessing" font:9 textColor:[UIColor whiteColor] textAlignment:0 backgroundColor:nil];
    [userMessage addSubview:englishLbl];
    [englishLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(titleLbl);
        make.top.equalTo(titleLbl.mas_bottom).with.offset(4);
    }];
    
    UILabel *valueLbl = [TXXLViewManager customTitleLbl:@"祈福总值:" font:14];
    _countLbl = [TXXLViewManager customTitleLbl:@"0" font:14];
    [userMessage addSubview:valueLbl];
    [userMessage addSubview:_countLbl];
    [valueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self->_userPhoto.mas_bottom).with.offset(16);
        make.centerX.equalTo(self->_userPhoto);
    }];
    [_countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(valueLbl.mas_right);
        make.centerY.equalTo(valueLbl);
    }];
    
    UIButton *blessBtn = [LSKViewFactory initializeButtonWithTitle:nil nornalImage:nil selectedImage:nil target:self action:@selector(jumpBlessEvent) textfont:0 textColor:nil backgroundColor:nil backgroundImage:@"blessIn"];
    [self addSubview:blessBtn];
    [blessBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).with.offset(5);
        make.width.mas_equalTo(SCREEN_WIDTH - 10);
        make.top.equalTo(userMessage.mas_bottom);
        make.height.mas_equalTo(128);
    }];
    _btnView = [[UIView alloc]init];
    _btnView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_btnView];
    [_btnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.top.equalTo(blessBtn.mas_bottom).with.offset(5);
    }];
    [self changeUserPhoto];
    [self customBtnView:nil];
    [self changeData];
}
- (void)customBtnView:(NSArray *)data {
    CGFloat btnWidth = SCREEN_WIDTH / 4.0;
    CGFloat btnHeight = 101;
    CGFloat top = 9;
    NSInteger count = KJudgeIsArrayAndHasValue(data)? data.count:0;
    CGFloat currentX = 0;
    CGFloat index  = 0;
    if (count < 2) {
        index = count;
    }else {
        index = 2;
    }
    for (int i = 0; i < 4; i++) {
        TXBZSMBlessHomeNaviButton *btn = [_btnView viewWithTag:i == index ? 604:600 + i];
        if (i < index) {
            currentX = btnWidth * i;
        }else if (i == index) {
            currentX = btnWidth * index;
        }else {
            currentX = count * btnWidth;
        }
        if (i == index) {
            if (!btn) {
                btn = [[TXBZSMBlessHomeNaviButton alloc]init];
                [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                btn.tag = 600 + 4;
                [_btnView addSubview:btn];
            }
            btn.frame = CGRectMake(currentX, top, btnWidth, btnHeight);
            [btn setupTitle:@"许愿树" image:@"tree"];
        }else {
            if ((count == 0 || count < i) && btn) {
                [btn removeFromSuperview];
            }else if(count >= i) {
                NSDictionary *dict = [data objectAtIndex:(i > index? i - 1:i)];
                if (!btn) {
                    btn = [[TXBZSMBlessHomeNaviButton alloc]init];
                    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
                    btn.tag = 600 + i;
                    [_btnView addSubview:btn];
                }
                btn.frame = CGRectMake(currentX, top, btnWidth, btnHeight);
                [btn setupTitle:[dict objectForKey:@"title"] image:[dict objectForKey:@"image"]];
            }
        }
    }
}
@end
