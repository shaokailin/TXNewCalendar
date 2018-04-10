//
//  TXSMFortuneMainVC.m
//  TXSCBZSMAPP
//
//  Created by linshaokai on 2018/3/5.
//  Copyright © 2018年 厦门集网文化传播有限公司. All rights reserved.
//

#import "TXSMFortuneMainVC.h"
#import "TXSMFortuneHomeCell.h"
#import "TXSMFortuneHomeVM.h"
#import "TXSMMessageDetailVC.h"
#import "TXSMFortuneHeaderView.h"
#import "TXSMFortuneHomeReusableView.h"
#import "TXSMFortuneSelectVC.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <WXApi.h>
#import "TXSMShareView.h"
@interface TXSMFortuneMainVC ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,FortuneSelectDelegate>
{
    CGFloat _height;
    NSInteger _currentIndex;
    NSInteger _selectIndex;
    NSArray *_messageArray;
}
@property (nonatomic, weak) UICollectionView *mainCollectionView;
@property (nonatomic, strong) TXSMFortuneHomeVM *viewModel;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) TXSMFortuneHeaderView *headerView;
@property (nonatomic, weak) UIButton *shareBtn;
@end

@implementation TXSMFortuneMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initializeMainView];
    [self bindSignal];
    [kUserMessageManager setupViewProperties:self url:nil name:@"运势首页"];
    [self addNotificationWithSelector:@selector(changeShowClick) name:kFortune_Show_Change_Notice];
}
- (BOOL)fd_prefersNavigationBarHidden {
    return YES;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [kUserMessageManager analiticsViewAppear:self];
    [self addNotificationWithSelector:@selector(showShareResult:) name:kShare_Notice];
}
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [kUserMessageManager analiticsViewDisappear:self];
    [self removeNotificationWithName:kShare_Notice];;
}
- (void)bindSignal {
    @weakify(self)
    _viewModel = [[TXSMFortuneHomeVM alloc]initWithSuccessBlock:^(NSUInteger identifier, id model) {
        @strongify(self)
        if (identifier == 10) {
            if (self->_selectIndex != -1) {
                self->_currentIndex = self->_selectIndex;
                self->_selectIndex = -1;
            }
            self.shareBtn.hidden = NO;
            [self setupContent:model];
        }else {
            [self.mainCollectionView.mj_header endRefreshing];
            self.dataArray = model;
            [self.mainCollectionView reloadData];
        }
    } failure:^(NSUInteger identifier, NSError *error) {
        @strongify(self)
        if (identifier == 10) {
            if (self->_selectIndex != -1) {
                [self changeLoadingKey];
                self->_selectIndex = -1;
            }
        }
        [self.mainCollectionView.mj_header endRefreshing];
    }];
    _viewModel.contactId = @"48";
    _viewModel.limit = @"30";
    [self changeLoadingKey];
    [self.mainCollectionView.mj_header beginRefreshing];
}
- (void)changeLoadingKey {
    NSDictionary *dict = [_messageArray objectAtIndex:_currentIndex];
    _viewModel.xingzuo = [dict objectForKey:@"english"];
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
//    UIImage *image = [self.headerView getMessageViewImage];
    NSString *url = @"https://itunes.apple.com/cn/app/id1367030369?mt=8";
    NSString *title = @"十二星座每日运势";
    NSDictionary *dict = [_messageArray objectAtIndex:_currentIndex];
    UIImage *image = ImageNameInit([dict objectForKey:@"image"]);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (type < 2) {
            WXMediaMessage *message = [WXMediaMessage message];
            message.title = title;
            message.description = nil;
            [message setThumbImage:image];
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
        }else {
            NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
            QQApiNewsObject* img = [QQApiNewsObject objectWithURL:[NSURL URLWithString:url] title:title description:nil previewImageData:imageData];
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
#pragma mark -切换星座
- (void)selectXingZuoIndex:(NSInteger)index {
    if (_currentIndex != index) {
        _selectIndex = index;
        NSDictionary *dict = [_messageArray objectAtIndex:index];
        _viewModel.xingzuo = [dict objectForKey:@"english"];
        [self.viewModel getHomeData:NO];
    }
}
- (void)changeShowClick {
    TXSMFortuneSelectVC *selectVC = [[TXSMFortuneSelectVC alloc]init];
    selectVC.dataArray = _messageArray;
    selectVC.delegate = self;
    selectVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:selectVC animated:YES];
}
#pragma mark - 数据刷新问题
- (void)pullDownRefresh {
    [self.viewModel getHomeData:YES];
}
- (void)setupContent:(NSDictionary *)dict {
    [self.headerView setupContent:dict messageDict:[_messageArray objectAtIndex:_currentIndex]];
}
- (void)changeFrame:(CGFloat)height {
    _height = height;
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, _height);
    [self.mainCollectionView reloadData];
}

#pragma mark - delegate
#pragma mark collectionView代理方法
//每个section的item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (KJudgeIsArrayAndHasValue(self.dataArray)) {
        return self.dataArray.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TXSMFortuneHomeCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kTXSMFortuneHomeCell forIndexPath:indexPath];
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    [cell setupCellContentWithImg:[dict objectForKey:@"image"] title:[dict objectForKey:@"description"]];
    
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = [self.dataArray objectAtIndex:indexPath.row];
    NSString *url = [dict objectForKey:@"url"];
    if (KJudgeIsNullData(url)) {
        [self jumpWebViewEnent:url image:[dict objectForKey:@"image"] title:[dict objectForKey:@"title"]];
    }
}
- (void)jumpWebViewEnent:(NSString *)url image:(NSString *)image title:(NSString *)title {
    TXSMMessageDetailVC *webVC = [[TXSMMessageDetailVC alloc]init];
    webVC.titleString = title;
    webVC.loadUrl = url;
    webVC.pic = image;
    webVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:webVC animated:YES];
}
- (void)jumpWebView {
    [self jumpWebViewEnent:@"https://www.6669667.com/liunian2018/?spread=tianjimsapp" image:nil title:@"2018运势详批"];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(SCREEN_WIDTH, _height + 37);
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        TXSMFortuneHomeReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXSMFortuneHomeReusableView forIndexPath:indexPath];
        [headerView setupContentIsHiden:!KJudgeIsArrayAndHasValue(self.dataArray)];
        return headerView;
    }
    return  nil;
}
#pragma marak - init view
- (void)initializeMainView {
    _height = 0;
    _currentIndex = [self getXingzuo];
    _selectIndex = -1;
    _messageArray = [NSArray arrayWithPlist:@"xingzuoList"];
    WS(ws)
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 2.5, 10);
    
    layout.itemSize =CGSizeMake(WIDTH_RACE_6S(166), WIDTH_RACE_6S(100) + 20 + 15);
    layout.minimumLineSpacing = 2.5;
    layout.minimumInteritemSpacing = 5;
    UICollectionView *collectionView = [LSKViewFactory initializeCollectionViewWithDelegate:self collectionViewLayout:layout headRefreshAction:@selector(pullDownRefresh) footRefreshAction:nil backgroundColor:nil];
    self.mainCollectionView = collectionView;
    [collectionView registerNib:[UINib nibWithNibName:kTXSMFortuneHomeCell bundle:nil] forCellWithReuseIdentifier:kTXSMFortuneHomeCell];
    [collectionView registerNib:[UINib nibWithNibName:kTXSMFortuneHomeReusableView bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kTXSMFortuneHomeReusableView];
    [collectionView addSubview:self.headerView];
    
    [self.view addSubview:collectionView];
    [collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(ws.view);
    }];
}
- (UIButton *)shareBtn {
    if (!_shareBtn) {
        UIButton *shareBtn = [LSKViewFactory initializeButtonNornalImage:@"share_icon" selectedImage:nil target:self action:@selector(shareClick)];
        _shareBtn = shareBtn;
        [self.view addSubview:shareBtn];
        [shareBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view).with.offset(STATUSBAR_HEIGHT);
            make.right.equalTo(self.view);
            make.size.mas_equalTo(CGSizeMake(60, 50));
        }];
    }
    return _shareBtn;
}
- (UIView *)headerView {
    if (!_headerView) {
        _headerView = [[TXSMFortuneHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
        WS(ws)
        _headerView.frameBlock = ^(CGFloat height) {
            [ws changeFrame:height];
        };
        _headerView.jumpBlock = ^(BOOL isJump) {
            [ws jumpWebView];
        };
    }
    return _headerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)getXingzuo {
    NSCalendar *calendar =  [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    [calendar setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:+28800]];
    NSDateComponents *comps = [calendar components:NSCalendarUnitMonth|NSCalendarUnitDay fromDate:[NSDate date]];
    NSInteger i_month = comps.month;
    NSInteger i_day = comps.day;
    NSInteger index = 0;
    /*
     摩羯座 12月22日------1月19日
     水瓶座 1月20日-------2月18日
     双鱼座 2月19日-------3月20日
     白羊座 3月21日-------4月19日
     金牛座 4月20日-------5月20日
     双子座 5月21日-------6月21日
     巨蟹座 6月22日-------7月22日
     狮子座 7月23日-------8月22日
     处女座 8月23日-------9月22日
     天秤座 9月23日------10月23日
     天蝎座 10月24日-----11月21日
     射手座 11月22日-----12月21日
     */
    switch (i_month) {
        case 1:
            if(i_day>=20 && i_day<=31){
                index = 10;
            }
            if(i_day>=1 && i_day<=19){
                index = 9;
            }
            break;
        case 2:
            if(i_day>=1 && i_day<=18){
                index = 10;
            }
            if(i_day>=19 && i_day<=31){
                index = 11;
            }
            break;
        case 3:
            if(i_day>=1 && i_day<=20){
                index = 11;
            }
            if(i_day>=21 && i_day<=31){
                index = 0;
            }
            break;
        case 4:
            if(i_day>=1 && i_day<=19){
                index = 0;
            }
            if(i_day>=20 && i_day<=31){
                index = 1;
            }
            break;
        case 5:
            if(i_day>=1 && i_day<=20){
               index = 1;
            }
            if(i_day>=21 && i_day<=31){
                index = 2;
            }
            break;
        case 6:
            if(i_day>=1 && i_day<=21){
                index = 2;
            }
            if(i_day>=22 && i_day<=31){
                index = 3;
            }
            break;
        case 7:
            if(i_day>=1 && i_day<=22){
                index = 3;
            }
            if(i_day>=23 && i_day<=31){
                index = 4;
            }
            break;
        case 8:
            if(i_day>=1 && i_day<=22){
                index = 4;
            }
            if(i_day>=23 && i_day<=31){
                index = 5;
            }
            break;
        case 9:
            if(i_day>=1 && i_day<=22){
                index = 5;
            }
            if(i_day>=23 && i_day<=31){
                index = 6;
            }
            break;
        case 10:
            if(i_day>=1 && i_day<=23){
                index = 6;
            }
            if(i_day>=24 && i_day<=31){
                index = 7;
            }
            break;
        case 11:
            if(i_day>=1 && i_day<=21){
                index = 7;
            }
            if(i_day>=22 && i_day<=31){
                index = 8;
            }
            break;
        case 12:
            if(i_day>=1 && i_day<=21){
                index = 8;
            }
            if(i_day>=21 && i_day<=31){
                index = 9;
            }
            break;
    }
    return index;
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
