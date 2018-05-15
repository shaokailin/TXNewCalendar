//
//  TXBZSMInitWishCardVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/14.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMInitWishCardVC.h"
#import "TXBZSMInitWishCardView.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import "TXSMShareView.h"
#import "TXBZSMTreeShareView.h"
#import "LSKImageManager.h"
@interface TXBZSMInitWishCardVC ()
@property (nonatomic, strong) UIImage *shareImage;
@property (nonatomic, weak) TXBZSMTreeShareView *shareView;;
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
        self.shareView.hidden = NO;
        UIImageWriteToSavedPhotosAlbum(self.shareImage,self,@selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:),nil);
    }
}
#pragma mark 保存图片后的回调
- (void)imageSavedToPhotosAlbum:(UIImage*)image didFinishSavingWithError:  (NSError*)error contextInfo:(id)contextInfo {
    if (!error) {
        [SKHUD showMessageInView:self.view withMessage:@"保存成功!~"];
    }else {
        if (error.code == -3310) {
            [SKHUD showMessageInView:self.view withMessage:@"保存失败!!~您不允许访问相册,请到设置界面开启才能保存!"];
        }else {
            [SKHUD showMessageInView:self.view withMessage:@"保存失败!!"];
        }
    }
    [self shareClick];
}
- (UIImage *)shareImage {
    if (!_shareImage) {
        _shareImage = [LSKImageManager makeImageWithView:self.shareView];
    }
    return _shareImage;
}
- (TXBZSMTreeShareView *)shareView {
    if (!_shareView) {
        TXBZSMTreeShareView *share = [[TXBZSMTreeShareView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - self.tabbarBetweenHeight)];
        [share setupContent:self.model.wishContent name:self.model.wishTitle img:self.model.image];
        _shareView = share;
        [self.view insertSubview:share atIndex:0];
    }
    return _shareView;
}
#pragma mark - 分享
- (void)shareClick {
    
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
- (void)shareContentWithType:(NSInteger)type {
    NSData *data = UIImageJPEGRepresentation(self.shareImage, 0.8);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type < 2) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = nil;
            message.description = nil;
            WXImageObject *ext = [WXImageObject object];
            ext.imageData = data;
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
            QQApiImageObject* img = [QQApiImageObject objectWithData:data
                                                    previewImageData:data
                                                               title:@"许愿"
                                                         description:@""];;
            img.shareDestType = ShareDestTypeQQ;
            SendMessageToQQReq* req = [SendMessageToQQReq reqWithContent:img];
            if (type == 2) {
                [QQApiInterface sendReq:req];
            }else {
                [QQApiInterface SendReqToQZone:req];
            }
        }
    });
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
- (void)showShareResult:(NSNotification *)notice {
    BOOL isReuslt = [[notice.userInfo objectForKey:@"result"] boolValue];
    if (isReuslt) {
        [SKHUD showMessageInView:self.view withMessage:@"分享成功"];
    }else {
        [SKHUD showMessageInView:self.view withMessage:@"分享失败"];
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
