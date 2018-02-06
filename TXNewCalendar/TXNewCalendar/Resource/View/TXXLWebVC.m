//
//  TXXLWebVC.m
//  TXNewCalendar
//
//  Created by shaokai lin on 2018/2/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXXLWebVC.h"

@interface TXXLWebVC ()

@end

@implementation TXXLWebVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [kUserMessageManager setupViewProperties:self url:self.loadUrl name:KJudgeIsNullData(self.titleString)?self.titleString:@"h5"];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
}
- (void)initializeMainView {
    [self changeWebFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight - self.tabbarBetweenHeight)];
//    if (KJudgeIsNullData(self.titleString)) {
//        self.title = self.titleString;
//    }else {
    @weakify(self)
    self.titleBlock = ^(NSString *title) {
        @strongify(self)
        self.title = title;
     };
//    }
    self.isShowBack = YES;
    self.isGetJsBrirge = YES;
    self.isShowProgress = YES;
    [self loadMainWebViewUrl:self.loadUrl];
}
- (BOOL)loadReuqestWithUrl:(NSString *)requestUrl {
    if ([requestUrl containsString:@"alipay://"]) {
        [kUserMessageManager analiticsPay:0];
    }else if ([requestUrl containsString:@"weixin://"]) {
        [kUserMessageManager analiticsPay:1];
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:requestUrl]]) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:requestUrl]];
            return NO;
        }
    }
    return YES;
//    alipay://alipayclient/?%7B%22dataString%22%3A%22h5_route_token%3D%5C%22RZ25L3RsYa6bPYSSJOyYzq9OMwdjPimobilecashierRZ25%5C%22%26is_h5_route%3D%5C%22true%5C%22%22%2C%22requestType%22%3A%22SafePay%22%2C%22fromAppUrlScheme%22%3A%22alipays%22%7D
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
