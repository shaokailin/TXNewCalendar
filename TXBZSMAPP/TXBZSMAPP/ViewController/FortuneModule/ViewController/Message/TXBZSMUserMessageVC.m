//
//  TXBZSMUserMessageVC.m
//  TXBZSMAPP
//
//  Created by shaokai lin on 2018/5/15.
//  Copyright © 2018年 厦门天象文化传播有限公司. All rights reserved.
//

#import "TXBZSMUserMessageVC.h"
#import "RSKImageCropper.h"
#import "LSKImageManager.h"
#import <AVFoundation/AVFoundation.h>
#import "HSPDatePickView.h"
#import "TXBZSMUserPhotoCell.h"
#import "TXBZSMNameInputCell.h"
#import "TXBZSMUserSelectCell.h"
#import "LSKActionSheetView.h"
@interface TXBZSMUserMessageVC ()<UITableViewDelegate,UITableViewDataSource,UIImagePickerControllerDelegate,UINavigationControllerDelegate,RSKImageCropViewControllerDelegate,UIScrollViewDelegate>
{
    NSString *_selectDate;
    NSDate *_changeDate;
    BOOL _isBoy;
    UIImage *_selectImg;
    NSString *_userName;
    BOOL _hasImage;
}
@property (nonatomic, weak) UITableView *mainTableView;
@property (nonatomic, strong) HSPDatePickView *datePickView;
@end

@implementation TXBZSMUserMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBackButton];
    self.navigationItem.title = @"我的";
    [self addRightNavigationButtonWithTitle:@"完成" target:self action:@selector(completeChange)];
    [self initializeMainView];
}
- (void)completeChange {
    NSString *name = [_userName stringBySpaceTrim];
    if (!KJudgeIsNullData(name)) {
        [SKHUD showMessageInWindowWithMessage:@"请输入正确名字"];
        return;
    }
    if (_selectImg) {
        [kUserMessageManager changeUserPhoto:_selectImg];
    }
    kUserMessageManager.nickName = name;
    kUserMessageManager.isBoy = _isBoy;
    if (_changeDate) {
        kUserMessageManager.birthDay = _changeDate;
    }
    [[NSNotificationCenter defaultCenter]postNotificationOnMainThreadWithName:kUserMessageChangeNotice object:nil];
    [self navigationBackClick];
}
#pragma mark -delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        TXBZSMUserPhotoCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMUserPhotoCell];
        [cell setupUserPhoto:_selectImg == nil?(_hasImage?kUserMessageManager.userPhoto:_isBoy?ImageNameInit(@"boy1"):ImageNameInit(@"girl1")):_selectImg ];
        WS(ws)
        
        cell.block = ^(BOOL isPhoto) {
            [ws changePhoto];
        };
        return cell;
    }else if (indexPath.row == 1){
        TXBZSMNameInputCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMNameInputCell];
        [cell setupCellContentWithName:_userName];
        @weakify(self)
        cell.nameBlock = ^(NSString *name) {
            @strongify(self)
            self->_userName = name;
        };
        return cell;
    }else {
        TXBZSMUserSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:kTXBZSMUserSelectCell];
        [cell setupCellContentWithTitle:[self returnLeftString:indexPath.row] detail:[self returnRightString:indexPath.row]];
        return cell;
    }
}
- (NSString *)returnLeftString:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 2:
            title = @"我的生日";
            break;
        case 3:
            title = @"我的性别";
            break;
        default:
            break;
    }
    return title;
}
- (NSString *)returnRightString:(NSInteger)index {
    NSString *title = nil;
    switch (index) {
        case 2:
            title = _selectDate;
            break;
        case 3:
            title = _isBoy == YES?@"男":@"女";
            break;
        default:
            break;
    }
    return title;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 80;
    }else {
        return 40;
    }
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.view endEditing:YES];
    if (indexPath.row == 2) {
        [self.datePickView showInView];
    }else if (indexPath.row == 3) {
        UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        @weakify(self)
        [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
            @strongify(self)
            if ([x integerValue] == 0) {
                self->_isBoy = YES;
            }else if ([x integerValue] == 1){
                self->_isBoy = NO;
            }
            if (!self->_hasImage) {
                [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0],[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }else {
                [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:3 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
            }
        }];
        [sheetView showInView:self.view];
    }
}
- (HSPDatePickView *)datePickView {
    if (!_datePickView) {
        HSPDatePickView *datePick = [[HSPDatePickView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, SCREEN_HEIGHT) tabbar:self.tabbarBetweenHeight];
        datePick.datePickerMode = UIDatePickerModeDateAndTime;
        datePick.minDate = [NSDate stringTransToDate:@"1940-01-01" withFormat:@"yyyy-MM-dd"];
        @weakify(self)
        datePick.dateBlock = ^(NSDate *date) {
            @strongify(self)
            self->_changeDate = date;
            self->_selectDate = [date dateTransformToString:@"yyyy-MM-dd HH:mm"];
            [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:2 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        };
        _datePickView = datePick;
        [[UIApplication sharedApplication].keyWindow addSubview:datePick];
    }
    _datePickView.maxDate = [NSDate date];
    return _datePickView;
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.view endEditing:YES];
}
- (void)changePhoto {
    UIActionSheet *sheetView = [[UIActionSheet alloc]initWithTitle:nil delegate:nil cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"手机相册", nil];
    @weakify(self)
    [sheetView.rac_buttonClickedSignal subscribeNext:^(NSNumber * _Nullable x) {
        @strongify(self)
        if ([x integerValue] == 0) {
            [self takeCameraPhoto];
        }else if ([x integerValue] == 1){
            [self takeLocationImage];
        }
    }];
    [sheetView showInView:self.view];
}
#pragma mark 拍照
- (void)takeCameraPhoto {
    [LSKImageManager isAvailableSelectAVCapture:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
            UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
            imagePick.delegate = self;
            imagePick.allowsEditing = YES;
            imagePick.sourceType = sourceType;
            [self presentViewController:imagePick animated:YES completion:^{
                
            }];
        }
    }];
}

- (void)takeLocationImage {
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *imagePick = [[UIImagePickerController alloc]init];
        imagePick.delegate = self;
        imagePick.sourceType = sourceType;
        [self presentViewController:imagePick animated:YES completion:^{
            
        }];
    }
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ( [type isEqualToString:@"public.image"] )
    {
        __strong UIImage *image=nil;
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
        {
            image=[info objectForKey:UIImagePickerControllerEditedImage];
        }else
        {
            image=[info objectForKey:UIImagePickerControllerOriginalImage];
        }
        [picker dismissViewControllerAnimated:NO completion:^{
        }];
        [self selectImage:image];
    }
}
- (void)selectImage:(UIImage *)image {
    RSKImageCropViewController *imageCropVC = [[RSKImageCropViewController alloc] initWithImage:image cropMode:RSKImageCropModeSquare];
    imageCropVC.delegate = self;
    imageCropVC.portraitSquareMaskRectInnerEdgeInset = (SCREEN_WIDTH - 300) / 2.0;
    imageCropVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:imageCropVC animated:NO];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark - RSKImageCropViewControllerDelegate

- (void)imageCropViewControllerDidCancelCrop:(RSKImageCropViewController *)controller
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)imageCropViewController:(RSKImageCropViewController *)controller didCropImage:(UIImage *)croppedImage usingCropRect:(CGRect)cropRect rotationAngle:(CGFloat)rotationAngle {
    _selectImg = croppedImage;
    [self.mainTableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)initializeMainView {
    _hasImage = [kUserMessageManager hasImage];
    _isBoy = kUserMessageManager.isBoy;
    _selectDate = [kUserMessageManager.birthDay dateTransformToString:@"yyyy-MM-dd HH:mm"];
    _userName = kUserMessageManager.nickName;
    UITableView *mainTableView = [LSKViewFactory initializeTableViewWithDelegate:self tableType:UITableViewStylePlain separatorStyle:1 headRefreshAction:nil footRefreshAction:nil separatorColor:nil backgroundColor:nil];
    mainTableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 5)];
    [mainTableView registerNib:[UINib nibWithNibName:kTXBZSMNameInputCell bundle:nil] forCellReuseIdentifier:kTXBZSMNameInputCell];
    [mainTableView registerNib:[UINib nibWithNibName:kTXBZSMUserPhotoCell bundle:nil] forCellReuseIdentifier:kTXBZSMUserPhotoCell];
    [mainTableView registerNib:[UINib nibWithNibName:kTXBZSMUserSelectCell bundle:nil] forCellReuseIdentifier:kTXBZSMUserSelectCell];
    self.mainTableView = mainTableView;
    [self.view addSubview:mainTableView];
    [mainTableView mas_makeConstraints:^(MASConstraintMaker *make) {
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
