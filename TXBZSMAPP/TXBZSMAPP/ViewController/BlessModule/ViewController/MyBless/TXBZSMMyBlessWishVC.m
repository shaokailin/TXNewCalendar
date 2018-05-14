//
//  TXBZSMMyBlessWishVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/10.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyBlessWishVC.h"
#import "TXBZSMMyBlessWishView.h"
@interface TXBZSMMyBlessWishVC ()
@property (nonatomic, weak) TXBZSMMyBlessWishView *wishView;
@end

@implementation TXBZSMMyBlessWishVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.navigationItem.title = @"我的祈福";
    [self initializeMainView];
}
- (void)nextClick {
    [self.view endEditing:YES];
    NSString *content = [self.wishView.contentString stringBySpaceTrim];
    NSString *titleString = [self.wishView.userString stringBySpaceTrim];
    if (!KJudgeIsNullData(content)) {
        [SKHUD showMessageInWindowWithMessage:@"请输入要祈福的内容"];
        return;
    }
    if (!KJudgeIsNullData(titleString)) {
        [SKHUD showMessageInWindowWithMessage:@"请输入要祈福的缘主"];
        return;
    }
    
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"下一步" target:self action:@selector(nextClick)];
    TXBZSMMyBlessWishView *wishView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMMyBlessWishView" owner:self options:nil]lastObject];
    [wishView setupGodImage:self.model.godImage];
    self.wishView = wishView;
    [self.view addSubview:wishView];
    [wishView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    
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
