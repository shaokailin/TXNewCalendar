//
//  TXBZSMWishInputVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/13.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMWishInputVC.h"
#import "TXBZSMWishInputView.h"
#import "TXBZSMInitWishCardVC.h"
#import "TPKeyboardAvoidingScrollView.h"
@interface TXBZSMWishInputVC ()
@property (nonatomic, strong) TXBZSMWishInputView *inputView;
@end

@implementation TXBZSMWishInputVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addYellowNavigationBackButton];
    self.navigationItem.title = @"填写愿望";
    [self initializeMainView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    self.navigationController.navigationBar.titleTextAttributes = @{NSForegroundColorAttributeName : KColorHexadecimal(0xe2b579, 1.0)};;
    [self.navigationController.navigationBar setBackgroundImage:[ImageNameInit(@"god_navi_god")resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 30, 10) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
}
- (void)nextClick {
    [self.view endEditing:YES];
    NSString *content = [self.inputView.contentString stringBySpaceTrim];
    NSString *titleString = [self.inputView.userString stringBySpaceTrim];
    if (!KJudgeIsNullData(content)) {
        [SKHUD showMessageInWindowWithMessage:@"请输入要许愿的内容"];
        return;
    }
    if (!KJudgeIsNullData(titleString)) {
        [SKHUD showMessageInWindowWithMessage:@"请输入您的名字"];
        return;
    }
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"请确认您的真实心愿内容，向许愿树许愿也不可以当儿戏！" delegate:nil cancelButtonTitle:@"我再想想" otherButtonTitles:@"确认许愿", nil];
    @weakify(self)
    [alertView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        NSInteger buttonIndex = [x integerValue];
        if (buttonIndex == 1) {
            [self addWishCard:content title:titleString];
        }
    }];
    [alertView show];
}
- (void)addWishCard:(NSString *)content title:(NSString *)title {
    TXBZSMWishTreeModel *model = [[TXBZSMWishTreeModel alloc]init];
    model.name = [self.dataDict objectForKey:@"title"];
    model.image = [self.dataDict objectForKey:@"image"];
    model.type = [self.dataDict objectForKey:@"type"];
    model.wishTitle = title;
    model.wishContent = content;
    [kUserMessageManager addWishModel:model];
    [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kWishDataChangeNotice object:nil];
    TXBZSMInitWishCardVC *card = [[TXBZSMInitWishCardVC alloc]init];
    card.model = model;
    [self.navigationController pushViewController:card animated:YES];
}
- (void)initializeMainView {
    [self addRightNavigationButtonWithTitle:@"完成" color:KColorHexadecimal(0xe2b579, 1.0) target:self action:@selector(nextClick)];
    TPKeyboardAvoidingScrollView *scrollView = [LSKViewFactory initializeTPScrollView];
    _inputView = [[[NSBundle mainBundle]loadNibNamed:@"TXBZSMWishInputView" owner:self options:nil]lastObject];
    [_inputView setupGodImage:[self.dataDict objectForKey:@"image"]];
    [scrollView addSubview:_inputView];
    [_inputView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(scrollView);
        make.height.mas_equalTo(self.viewMainHeight - self.tabbarBetweenHeight);
        make.width.mas_equalTo(SCREEN_WIDTH);
    }];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
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
