//
//  TXBZSMInitWishCardVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMInitWishCardVC.h"
#import "TXBZSMInitWishCardView.h"
@interface TXBZSMInitWishCardVC ()

@end

@implementation TXBZSMInitWishCardVC
- (BOOL)fd_interactivePopDisabled {
    return YES;
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)actionClick:(NSInteger)type {
    if (type == 0) {
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:1] animated:YES];
    }else {
#warning - share
        
    }
}
- (void)initializeMainView {
    TXBZSMInitWishCardView *card = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMInitWishCardView" owner:self options:nil]lastObject];
    [card setupContent:self.model];
    @weakify(self)
    card.block = ^(NSInteger type) {
        @strongify(self)
        [self actionClick:type];
    };
    [self.view addSubview:card];
    [card mas_makeConstraints:^(MASConstraintMaker *make) {
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
