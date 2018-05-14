//
//  TXBZSMWishCardDetailVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishCardDetailVC.h"
#import "TXBZSMWishCardDetailView.h"
#import "TXBZSMWishInputVC.h"
@interface TXBZSMWishCardDetailVC ()

@end

@implementation TXBZSMWishCardDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)actionWithType:(NSInteger)type data:(NSDictionary *)dict {
    switch (type) {
        case 0:
            [self navigationBackClick];
            break;
        case 1:
        {
            TXBZSMWishInputVC *detail = [[TXBZSMWishInputVC alloc]init];
            detail.dataDict = self.dataDict;
            [self.navigationController pushViewController:detail animated:YES];
        }
            break;
        default:
            break;
    }
}
- (void)initializeMainView {
    TXBZSMWishCardDetailView *mainView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMWishCardDetailView" owner:self options:nil]lastObject];
    @weakify(self)
    mainView.homeBlock = ^(NSInteger type, NSDictionary *data) {
        @strongify(self)
        [self actionWithType:type data:data];
    };
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view).with.insets(UIEdgeInsetsMake(0, 0, self.tabbarBetweenHeight, 0));
    }];
    [mainView setupContentWithData:self.dataDict];
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
