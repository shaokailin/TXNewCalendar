//
//  TXBZSMWishTreeVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishTreeVC.h"
#import "TXBZSMTreeHomeView.h"
#import "TXBZSMVWishListVC.h"
#import "TXBZSMMyWishListVC.h"
@interface TXBZSMWishTreeVC ()

@end

@implementation TXBZSMWishTreeVC
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
}
- (void)actionWithType:(NSInteger)type data:(NSDictionary *)dict {
    switch (type) {
        case 12:
            [self navigationBackClick];
            break;
        case 10:
            {
                TXBZSMVWishListVC *list = [[TXBZSMVWishListVC alloc]init];
                [self.navigationController pushViewController:list animated:YES];
            }
            break;
        case 11:
            {
                TXBZSMMyWishListVC *list = [[TXBZSMMyWishListVC alloc]init];
                [self.navigationController pushViewController:list animated:YES];
            }
            break;
        default:
            break;
    }
}
- (void)initializeMainView {
    TXBZSMTreeHomeView *mainView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMTreeHomeView" owner:self options:nil]lastObject];
    mainView.topBetween = STATUSBAR_HEIGHT;
    @weakify(self)
    mainView.homeBlock = ^(NSInteger type, NSDictionary *data) {
        @strongify(self)
        [self actionWithType:type data:data];
    };
    [self.view addSubview:mainView];
    [mainView mas_makeConstraints:^(MASConstraintMaker *make) {
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
