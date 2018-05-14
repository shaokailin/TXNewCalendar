//
//  TXBZSMMyWishListVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMMyWishListVC.h"
#import "TXBZSMMyWishMainView.h"
#import "TXBZSMWishTreeCompleteVC.h"
@interface TXBZSMMyWishListVC ()

@end

@implementation TXBZSMMyWishListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}

- (void)actionWithType:(NSInteger)type data:(TXBZSMWishTreeModel *)dict index:(NSInteger)index {
    switch (type) {
        case 0:
            [self navigationBackClick];
            break;
        case 3:
        {
            TXBZSMWishTreeCompleteVC *complete = [[TXBZSMWishTreeCompleteVC alloc]init];
            complete.index = index;
            complete.name = dict.name;
            [self.navigationController pushViewController:complete animated:YES];
        }
            break;
        
        default:
            break;
    }
}
- (void)initializeMainView {
    TXBZSMMyWishMainView *mainView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMMyWishMainView" owner:self options:nil]lastObject];
    mainView.topBetween = STATUSBAR_HEIGHT;
    @weakify(self)
    mainView.homeBlock = ^(NSInteger type, TXBZSMWishTreeModel *model, NSInteger index) {
        @strongify(self)
        [self actionWithType:type data:model index:index];
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
