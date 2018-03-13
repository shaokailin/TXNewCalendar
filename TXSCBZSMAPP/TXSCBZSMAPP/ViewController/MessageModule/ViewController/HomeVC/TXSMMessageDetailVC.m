//
//  TXSMMessageDetailVC.m
//  TXSCBZSMAPP
//
//  Created by shaokai lin on 2018/3/12.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMMessageDetailVC.h"
#import "LSKWebView.h"
#import "LSKWebProgressView.h"
#import "TXSMShareView.h"
#import "TXSMDetailBottonView.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import "TXSMDetailHeaderView.h"
static const CGFloat kBottonViewHeight = 49;
@interface TXSMMessageDetailVC ()
@property (strong ,nonatomic) LSKWebView *webView;
@property (assign ,nonatomic) BOOL isCanBlack;
@property (assign ,nonatomic) BOOL isClickBack;
@property (assign ,nonatomic) BOOL hasClickLink;
@property (assign ,nonatomic) NSInteger firstHistoryCount;
@property (strong ,nonatomic) LSKWebProgressView *progressView;
@property (nonatomic, strong) TXSMDetailHeaderView *headerView;
@end

@implementation TXSMMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (_progressView) {
        _progressView.hidden = NO;
    }
    [self.webView loadWebViewHtml:@"<a href='http:www.baidu.com'>123</a>" baseUrl:nil];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if (_progressView) {
        _progressView.hidden = YES;
    }
}

- (void)showShareView {
//    if (![WXApi isWXAppInstalled] && ![TencentOAuth iphoneQQInstalled]) {
//        [SKHUD showMessageInWindowWithMessage:@"暂无可分享的平台！"];
//        return;
//    }
    TXSMShareView *shareView = [[TXSMShareView alloc]initWithTabbar:self.tabbarBetweenHeight ];
    @weakify(self)
    shareView.shareBlock = ^(NSInteger type) {
        @strongify(self)
        [self shareContentWithType:type];
    };
    [shareView showInView];
}
- (void)shareContentWithType:(NSInteger)type {
    if (type < 2) {
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = self.model.title;
        message.description = nil;
        [message setThumbData:[NSData dataWithContentsOfURL:[NSURL URLWithString:self.model.pic]]];
        
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = self.model.url;
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        if (type == 0) {
            req.scene = WXSceneSession;
        }else {
            req.scene = WXSceneTimeline;
        }
        [WXApi sendReq:req];
    }else {
        NSURL *previewURL = [NSURL URLWithString:self.model.pic];
        NSURL* url = [NSURL URLWithString:self.model.url];
        QQApiNewsObject* img = [QQApiNewsObject objectWithURL:url title:self.model.title description:nil previewImageURL:previewURL];
        img.shareDestType = ShareDestTypeQQ;
        SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
        if (type == 2) {
             [QQApiInterface sendReq:req];
        }else {
             [QQApiInterface SendReqToQZone:req];
        }
    }
}
- (BOOL)loadReuqestWithUrl:(NSString *)requestUrl {
    return YES;
}
- (void)stopLoading {
    [self.webView stopLoading];
}
- (void)exitLoading:(NSInteger)type {
    if (type == 0) {
        [self.webView goBack];
    }else{
        [self.webView goForward];
    }
}
- (void)backClick {
    _isClickBack = YES;
    if ([self.webView canGoBack] && [self.webView historyCount] > self.firstHistoryCount) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}
#pragma mark - 界面 
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"share_icon" seletedIamge:nil target:self action:@selector(showShareView)];
    self.firstHistoryCount = 0;
    self.webView = [[LSKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight - kBottonViewHeight - self.tabbarBetweenHeight)];
    [self.view addSubview:self.webView];
    
    TXSMDetailBottonView *bottonView = [[TXSMDetailBottonView alloc]initWithFrame:CGRectMake(0, self.viewMainHeight - kBottonViewHeight - self.tabbarBetweenHeight, SCREEN_WIDTH, kBottonViewHeight)];
    [self.view addSubview:bottonView];
    
    self.headerView = [[TXSMDetailHeaderView alloc]init];
    [self.headerView setupArticleTitle:@"凯先生凯先生凯先生凯先生凯先生凯先生" from:@"凯先生" date:@"凯先生凯先生凯先生凯先生凯先生"];
    CGFloat height = self.headerView.contentHeight;
    self.headerView.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
    self.webView.scrollerView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    [self.webView.scrollerView addSubview:self.headerView];
    @weakify(self)
    bottonView.loadBlock = ^(NSInteger type) {
        @strongify(self)
        [self exitLoading:type];
    };
    self.webView.webTitleBlock = ^(NSString *title) {
        
    };
    self.webView.webUrlBlock = ^BOOL(NSString *url,UIWebViewNavigationType navigationType){
        @strongify(self)
        return [self webLoadRequest:url navi:navigationType];
    };
    self.progressView.hidden = NO;
    [self showLoadProgress];
}
#pragma mark 加载导航栏
- (void)showLoadProgress {
    @weakify(self)
    self.webView.progressBlock = ^(CGFloat progress){
        @strongify(self)
        [self progressLoad:progress];
    };
}
- (void)progressLoad:(CGFloat)progress {
    [self.progressView setProgress:progress];
}
- (LSKWebProgressView *)progressView {
    if (!_progressView) {
        UIView *progress = [self.navigationController.navigationBar viewWithTag:kWeb_Progress_View_Tag];
        if (progress) {
            self.progressView = (LSKWebProgressView *)progress;
            _progressView.hidden = NO;
        }else {
            _progressView = [[LSKWebProgressView alloc]initWithFrame:CGRectMake(0, CGRectGetHeight(self.navigationController.navigationBar.bounds) - kWeb_Progress_View_Height, SCREEN_WIDTH, kWeb_Progress_View_Height)];
            _progressView.tag = kWeb_Progress_View_Tag;
            [self.navigationController.navigationBar addSubview:_progressView];
        }
        
    }
    return _progressView;
}

#pragma 绑定js交互
-(BOOL)webLoadRequest:(NSString *)url navi:(UIWebViewNavigationType)navigationType {
    if (navigationType == UIWebViewNavigationTypeLinkClicked) {
        self.firstHistoryCount = [self.webView historyCount];
    }
    if (!self.hasClickLink) {
        NSString *originUrl = [self.webView originRequest];
        if ([url isEqualToString:originUrl] && _isClickBack) {
            
        }
    }
    _isClickBack = NO;
    return [self loadReuqestWithUrl:url];
}
-(void)dealloc {
    if (_progressView) {
        _progressView = nil;
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
