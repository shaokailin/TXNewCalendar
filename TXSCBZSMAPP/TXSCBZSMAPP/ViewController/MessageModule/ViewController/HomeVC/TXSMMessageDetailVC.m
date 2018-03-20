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
#import "TXSMMessageDetailVM.h"
#import "UIImageView+WebCache.h"
static const CGFloat kBottonViewHeight = 49;
@interface TXSMMessageDetailVC ()
{
    BOOL _isChange;
    BOOL _isNeedChange;
    BOOL _isHasLoading;
}
@property (nonatomic, strong) UIImageView *shareImgView;
@property (nonatomic, strong) NSString *contentHtmlString;
@property (strong ,nonatomic) LSKWebView *webView;
@property (assign ,nonatomic) NSInteger firstHistoryCount;
@property (strong ,nonatomic) LSKWebProgressView *progressView;
@property (nonatomic, strong) TXSMDetailHeaderView *headerView;
@property (nonatomic, strong) TXSMMessageDetailVM *viewModel;
@end

@implementation TXSMMessageDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    [self initializeMainView];
    if (self.model) {
        [kUserMessageManager setupViewProperties:self url:self.model.url name:KJudgeIsNullData(self.model.title)?self.model.title:@"h5"];
        self.pic = self.model.pic;
    }else {
        [kUserMessageManager setupViewProperties:self url:self.loadUrl name:KJudgeIsNullData(self.titleString)?self.titleString:@"h5"];
    }
    [self addNotificationWithSelector:@selector(showShareResult:) name:kShare_Notice];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
    if (_progressView) {
        _progressView.hidden = YES;
    }
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
    if (_progressView) {
        _progressView.hidden = NO;
    }
    if (!_isHasLoading) {
        _isHasLoading = YES;
        if (self.model) {
            [self bindSignal];
        }else {
            [self.webView loadWebViewUrl:self.loadUrl];
        }
    }
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXSMMessageDetailVM alloc]initWithSuccessBlock:^(NSUInteger identifier, NSDictionary *model) {
        @strongify(self)
        [self.webView.scrollerView.mj_header endRefreshing];
        self.contentHtmlString = NSStringFormat(@"<!DOCTYPE html> \
                                                <html lang=\"en\"> \
                                                <head> \
                                                <style>img{width:%.0fpx !important;}</style>\
                                               <meta charset=\"UTF-8\"> \
                                                <meta content=\"width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0\" name=\"viewport\" /> \
                                                </head> \
                                                <body> \
                                                %@ \
                                                </body>\
                                                <html>;",SCREEN_WIDTH,[model objectForKey:@"content"]);
        self.model.url = [model objectForKey:@"url"];
        NSString *dateString = [model objectForKey:@"article_date"];
        if (KJudgeIsNullData(dateString)) {
            NSArray *dateArray = [dateString componentsSeparatedByString:@" "];
            if (KJudgeIsArrayAndHasValue(dateArray)) {
                dateString = [dateArray objectAtIndex:0];
            }
        }
        [self.headerView setupArticleTitle:[model objectForKey:@"title"] from:[model objectForKey:@"from"] date:dateString];
        [self.webView loadWebViewHtml:self.contentHtmlString baseUrl:self.model.url];
        
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        [self.webView.scrollerView.mj_header endRefreshing];
    }];
    _viewModel.article_id = self.model.article_id;
    [_viewModel getDetailData:NO];
}
- (void)pullDownRefresh {
    if (self.model && !KJudgeIsNullData(self.contentHtmlString)) {
        [_viewModel getDetailData:YES];
    }else {
        [self stopLoading];
        [self.webView reload];
        [self.webView.scrollerView.mj_header endRefreshing];
    }
}
#pragma mark - 分享
- (void)showShareView {
    if (![WXApi isWXAppInstalled] && ![TencentOAuth iphoneQQInstalled]) {
        [SKHUD showMessageInWindowWithMessage:@"暂无可分享的平台！"];
        return;
    }
    TXSMShareView *shareView = [[TXSMShareView alloc]initWithTabbar:self.tabbarBetweenHeight ];
    @weakify(self)
    shareView.shareBlock = ^(NSInteger type) {
        @strongify(self)
        [self shareContentWithType:type];
    };
    [shareView showInView];
}
- (void)showShareResult:(NSNotification *)notice {
    BOOL isReuslt = [[notice.userInfo objectForKey:@"result"] boolValue];
    if (isReuslt) {
        [SKHUD showMessageInView:self.view withMessage:@"分享成功"];
    }else {
        [SKHUD showMessageInView:self.view withMessage:@"分享失败"];
    }
}
- (void)shareContentWithType:(NSInteger)type {
    NSString *title = nil;
    NSString *url = nil;
    if (self.model) {
        title = self.model.title;
        url = self.model.url;
    }else {
        title = self.titleString;
        url = self.loadUrl;
    }
    if (type < 2) {
        if (KJudgeIsNullData(self.pic)) {
            if (_shareImgView.image) {
                [self shareForWX:type image:_shareImgView.image title:title url:url];
            }else {
                [SKHUD showLoadingDotInView:self.view];
                [self.shareImgView sd_setImageWithURL:[NSURL URLWithString:self.pic] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [SKHUD dismiss];
                        if (image) {
                            self.shareImgView.image = image;
                            [self shareForWX:type image:_shareImgView.image title:title url:url];
                        }else {
                            [self shareForWX:type image:nil title:title url:url];
                        }
                    });
                    
                }];
            }
            
        }else {
            [self shareForWX:type image:nil title:title url:url];
        }
    }else {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSURL *previewURL = nil;
            if (self.pic) {
                previewURL = [NSURL URLWithString:self.pic];
            }
            NSURL* urlUrl = [NSURL URLWithString:url];
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:urlUrl title:title description:nil previewImageURL:previewURL];
            img.shareDestType = ShareDestTypeQQ;
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            if (type == 2) {
                [QQApiInterface sendReq:req];
            }else {
                [QQApiInterface SendReqToQZone:req];
            }
        });
        
    }
}
- (void)shareForWX:(NSInteger)type image:(UIImage *)image title:(NSString *)title url:(NSString *)url {
    dispatch_async(dispatch_get_main_queue(), ^{
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = nil;
        if (image) {
            [message setThumbImage:image];
        }else {
            [message setThumbImage:ImageNameInit(@"appicon")];
        }
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = url;
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
    });
}
- (UIImageView *)shareImgView {
    if (!_shareImgView) {
        _shareImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    }
    return _shareImgView;
}
#pragma mark - 网络前后
- (void)stopLoading {
    [self.webView stopLoading];
}
- (void)exitLoading:(NSInteger)type {
    if (type == 0) {
        if ([self.webView canGoBack]) {
            [self.webView stopLoading];
            [self.webView goBack];
        }else if(self.model){
            if (![self.webView.currentRequest isEqualToString:self.model.url]) {
                self.webView.currentRequest = nil;
                [self.webView loadWebViewHtml:self.contentHtmlString baseUrl:self.model.url];
            }
        }
    }else{
        [self.webView goForward];
    }
}

- (void)changeHeaderView:(BOOL)isFirst {
    CGFloat height = 0;
    if (isFirst) {
        height = self.headerView.contentHeight;
        self.headerView.frame = CGRectMake(0, -height, SCREEN_WIDTH, height);
        [self.webView.scrollerView addSubview:self.headerView];
    }else {
        [self.headerView removeFromSuperview];
    }
    self.webView.scrollerView.mj_header.ignoredScrollViewContentInsetTop = height;
    self.webView.scrollerView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
}
- (void)loadStatus:(NSInteger)state {
    if (state == 2 && _isNeedChange) {
        _isNeedChange = NO;
        [self changeHeaderView:_isChange];
    }
}
- (void)changeHeaderViewWithUrl:(NSString *)url {
    if ([url isEqualToString:self.model.url] && self.firstHistoryCount == 0  && self.headerView.superview == nil) {
        _isNeedChange = YES;
        _isChange = YES;
    }else if (![url isEqualToString:self.model.url] && self.headerView.superview) {
        _isNeedChange = YES;
        _isChange = NO;
    }
}
#pragma 绑定js交互
-(BOOL)webLoadRequest:(NSString *)url navi:(UIWebViewNavigationType)navigationType {
    if (self.model) {
        if (navigationType == UIWebViewNavigationTypeLinkClicked || navigationType == UIWebViewNavigationTypeOther) {
            self.firstHistoryCount = [self.webView historyCount];
            [self changeHeaderViewWithUrl:url];
        }
    }
    if ([url containsString:@"alipay://"]) {
        [kUserMessageManager analiticsPay:0];
    }else if ([url containsString:@"weixin://"]) {
        [kUserMessageManager analiticsPay:1];
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:url]]) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            return NO;
        }
    }else if ([url containsString:@"mqqapi://"]){
        if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:url]]) {
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:url]];
            return NO;
        }
    }
    return YES;
}
#pragma mark - 界面 
- (void)initializeMainView {
    [self addRightNavigationButtonWithNornalImage:@"share_icon" seletedIamge:nil target:self action:@selector(showShareView)];
    self.firstHistoryCount = 0;
    self.webView = [[LSKWebView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.viewMainHeight - kBottonViewHeight - self.tabbarBetweenHeight)];
    self.webView.backgroundColor = KColorHexadecimal(0xf5f5f5, 1.0);
    [self.view addSubview:self.webView];
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(pullDownRefresh)];
    self.webView.scrollerView.mj_header = header;
    TXSMDetailBottonView *bottonView = [[TXSMDetailBottonView alloc]initWithFrame:CGRectMake(0, self.viewMainHeight - kBottonViewHeight - self.tabbarBetweenHeight, SCREEN_WIDTH, kBottonViewHeight)];
    [self.view addSubview:bottonView];
    @weakify(self)
    bottonView.loadBlock = ^(NSInteger type) {
        @strongify(self)
        [self exitLoading:type];
    };
    if (!self.model) {
        self.webView.webTitleBlock = ^(NSString *title) {
             @strongify(self)
            self.title = title;
        };
    }
    self.webView.webUrlBlock = ^BOOL(NSString *url,UIWebViewNavigationType navigationType){
        @strongify(self)
        return [self webLoadRequest:url navi:navigationType];
    };
    self.webView.loadStatusBlock = ^(NSInteger status) {
        @strongify(self)
        [self loadStatus:status];
    };
    self.progressView.hidden = NO;
    [self showLoadProgress];
}
- (TXSMDetailHeaderView *)headerView {
    if (!_headerView) {
        _headerView = [[TXSMDetailHeaderView alloc]init];
    }
    return _headerView;
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
