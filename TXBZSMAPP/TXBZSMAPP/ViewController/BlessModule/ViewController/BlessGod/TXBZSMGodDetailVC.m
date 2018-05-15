//
//  TXBZSMGodDetailVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMGodDetailVC.h"
#import "TXBZSMGodDetailInfoView.h"
#import "TXBZSMGodDetailRuleView.h"
#import "TXBZSMGodDetailMessageView.h"
@interface TXBZSMGodDetailVC ()

@end

@implementation TXBZSMGodDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addYellowNavigationBackButton];
    self.navigationItem.title = @"神明简介";
    [self initializeMainView];
}
- (void)inviteGodClick {
    if (self.selectBlock) {
        self.selectBlock(self.godDetail);
    }
    NSInteger viewCount = self.navigationController.viewControllers.count;
    UIViewController *controller = [self.navigationController.viewControllers objectAtIndex:viewCount - 3];
    [self.navigationController popToViewController:controller animated:YES];
}
- (void)initializeMainView {
    UIScrollView *mainScroll = [LSKViewFactory initializeScrollViewTarget:nil headRefreshAction:nil footRefreshAction:nil];
    [self.view addSubview:mainScroll];
    BOOL has = [[self.godDetail objectForKey:@"has"]boolValue];
    CGFloat contentHeight = 242;
    TXBZSMGodDetailMessageView *message = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMGodDetailMessageView" owner:self options:nil] lastObject];
    [message setupContent:[self.godDetail objectForKey:@"name"] type:[self.godDetail objectForKey:@"blessType"] image:[self.godDetail objectForKey:@"image"] has:has];
    [mainScroll addSubview:message];
    [message mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(mainScroll);
        make.width.mas_equalTo(SCREEN_WIDTH);
        make.height.mas_equalTo(contentHeight);
    }];
    NSString *content = [self.godDetail objectForKey:@"info"];
    CGFloat height = [content calculateTextHeight:12 width:SCREEN_WIDTH - 38] + 73;
    TXBZSMGodDetailInfoView *info = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMGodDetailInfoView" owner:self options:nil] lastObject];
    [info setupContent:content];
    [mainScroll addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(message);
        make.top.equalTo(message.mas_bottom);
        make.height.mas_equalTo(height);
    }];
    contentHeight += height;
    contentHeight += 15;
    
    TXBZSMGodDetailRuleView *rule = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMGodDetailRuleView" owner:self options:nil] lastObject];
    [mainScroll addSubview:rule];
    [rule mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(message);
        make.top.equalTo(info.mas_bottom).with.offset(15);
        make.height.mas_equalTo(130);
    }];
    contentHeight += 130;
    contentHeight += 45;
    mainScroll.contentSize = CGSizeMake(SCREEN_WIDTH, contentHeight);
    UIButton *inviteBtn = [LSKViewFactory initializeButtonWithTitle:@"请神供奉" nornalImage:nil selectedImage:nil target:self action:@selector(inviteGodClick) textfont:0 textColor:[UIColor whiteColor] backgroundColor:KColorHexadecimal(0xe2b579, 1.0) backgroundImage:nil];
    inviteBtn.titleLabel.font = FontBoldInit(16);
    [self.view addSubview:inviteBtn];
    [inviteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-self.tabbarBetweenHeight);
        make.height.mas_equalTo(49);
    }];
    [mainScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.view);
        make.bottom.equalTo(inviteBtn.mas_top);
    }];
    
    if (has) {
        [inviteBtn setBackgroundColor:KColorHexadecimal(0xbfbfbf, 1.0)];
        [inviteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [inviteBtn setTitle:@"已供奉仙" forState:UIControlStateNormal];
        inviteBtn.userInteractionEnabled = NO;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
