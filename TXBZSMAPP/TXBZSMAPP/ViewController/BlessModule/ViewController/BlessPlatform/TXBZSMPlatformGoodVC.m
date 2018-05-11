//
//  TXBZSMPlatformGoodView.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/11.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMPlatformGoodVC.h"
#import "LSKImageManager.h"
#import "UIImageView+LBBlurredImage.h"
@interface TXBZSMPlatformGoodVC ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation TXBZSMPlatformGoodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationBackButton];
    [self initializeMainView];
}
- (void)initializeMainView {
    [self setupNavigationTitle];
    UIImageView *bgViewView = [[UIImageView alloc]initWithImage:self.bgImageView];
    bgViewView.frame = CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight - self.tabbarBetweenHeight);
    bgViewView.contentMode = UIViewContentModeScaleToFill;
    [self.view addSubview:bgViewView];
    
    
}
- (NSString *)returnDataKey {
    NSString *title = @"";
    switch (self.goodsType) {
        case PlatformGoodsType_lazhu:
            title = @"lazhu";
            break;
        case PlatformGoodsType_chashui:
            title = @"shengshui";
            break;
        case PlatformGoodsType_huaping:
            title = @"gonghua";
            break;
        case PlatformGoodsType_gongpin:
            title = @"gongguo";
            break;
        case PlatformGoodsType_xiangyan:
            title = @"xiangtan";
            break;
        default:
            break;
    }
    return title;
}
- (void)setupNavigationTitle {
    switch (self.goodsType) {
        case PlatformGoodsType_lazhu:
            self.navigationItem.title = @"蜡烛";
            break;
        case PlatformGoodsType_chashui:
            self.navigationItem.title = @"水杯";
            break;
        case PlatformGoodsType_huaping:
            self.navigationItem.title = @"花";
            break;
        case PlatformGoodsType_gongpin:
            self.navigationItem.title = @"果";
            break;
        case PlatformGoodsType_xiangyan:
            self.navigationItem.title = @"香";
            break;
        default:
            break;
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
