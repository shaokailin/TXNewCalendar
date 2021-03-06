//
//  LSKBaseViewController.m
//  SingleStore
//
//  Created by hsPlan on 2017/9/13.
//  Copyright © 2017年 林少凯. All rights reserved.
//

#import "LSKBaseViewController.h"
#import "UIViewController+Extend.h"

static const NSInteger kNavigationBarButton_Font = 15;
static NSString * const kNavigation_BackImg = @"navi_back";
@interface LSKBaseViewController ()

@end

@implementation LSKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //设置不全局布局
    [self setupNotFullScreen];
    self.view.backgroundColor = KColorHexadecimal(kMainBackground_Color, 1.0);
}
- (CGFloat)viewMainHeight {
    return SCREEN_HEIGHT - STATUSBAR_HEIGHT - [self navibarHeight];
}
- (CGFloat)tabbarHeight {
    return self.tabBarController.tabBar.frame.size.height;
}
- (CGFloat)navibarHeight {
    return self.navigationController.navigationBar.frame.size.height;
}
- (CGFloat)tabbarBetweenHeight {
    if (self.tabbarHeight <= 0) {
        return 0;
    }
    return ([self tabbarHeight] - 49.0);
}

#pragma mark - 添加返回按钮
- (void)addNavigationBackButton {
    [self addLeftNavigationButtonWithNornalImage:kNavigation_BackImg seletedImage:nil target:self action:@selector(navigationBackClick)];
}
//界面的返回 1种是 导航栏多个返回，一种是dismiss过去的导航栏
- (void)navigationBackClick {
    if (self.navigationController.viewControllers.count > 1) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:^{
        }];
    }
}
#pragma mark 添加导航栏按钮
//添加导航栏左按钮
- (void)addLeftNavigationButtonWithNornalImage:(NSString *)nornalImage
                                  seletedImage:(NSString *)seletedImage
                                        target:(id)target
                                        action:(SEL)action {
    UIBarButtonItem *tLeftButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nornalImage seletedImage:seletedImage title:nil font:0 fontColor:nil target:target action:action isRight:NO];
    [self addNavigationLeftButton:tLeftButton];
}
- (void)addLeftNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *tLeftButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nil seletedImage:nil title:title font:kNavigationBarButton_Font fontColor:KColorUtilsString(kNavigationBarButtonTitle_Color) target:target action:action isRight:NO];
    [self addNavigationLeftButton:tLeftButton];
}

//添加导行条右边按钮
- (void)addRightNavigationButtonWithNornalImage:(NSString *)nornalImage
                    seletedIamge:(NSString *)seletedImage
                          target:(id)target
                          action:(SEL)action {
    UIBarButtonItem *tRightButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nornalImage seletedImage:seletedImage title:nil font:0 fontColor:nil target:target action:action isRight:YES];
    [self addNavigationRightButton:tRightButton];
}
- (void)addRightNavigationButtonWithTitle:(NSString *)title target:(id)target action:(SEL)action {
    UIBarButtonItem *tRightButton = [UIBarButtonItem initBarButtonItemWithNornalImage:nil seletedImage:nil title:title font:kNavigationBarButton_Font fontColor:KColorUtilsString(kNavigationBarButtonTitle_Color) target:target action:action isRight:YES];
    [self addNavigationRightButton:tRightButton];
}
#pragma mark - 通知
//添加监听
- (void)addNotificationWithSelector:(SEL)selector name:(NSString *)name {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:selector
                                                 name:name
                                               object:nil];
}
//移除一个通知
- (void)removeNotificationWithName:(NSString *)name {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:name object:nil];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    LSKLog(@"%@:内存回收", NSStringFromClass([self class]));
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
