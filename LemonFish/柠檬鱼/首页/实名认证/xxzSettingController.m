
#import "xxzSettingController.h"
#import "xxzNewsView.h"
#import "xxzErsionUppotController.h"

#define ZhengMian_FailString @"身份证正面识别失败"
#define FanMian_FailString   @"身份证反面识别失败"

#define ZhengMian @"身份证正面"
#define FanMian   @"身份证反面"
@interface xxzSettingController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>{
    BOOL isSFZz;
    BOOL isSFZf;
}
@property (nonatomic, strong) xxzNewsView *shoukkuanblock;
@property(assign,nonatomic)NSString * offCell;
@property (nonatomic ,strong)NSString * name;
@property (nonatomic ,strong)NSString * idCard;

@end

@implementation xxzSettingController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.name = @"";
    self.idCard = @"";
    
    [self blockAction];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    
    
    if (self.iEmpowerToken) {
        [self getEmpowerToken];
    }
    
    
}

-(void)getEmpowerToken{
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/user/empower/token" Params:@{@"userId":self.startDic[@"id"]} success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.empowerToken = responseObject[@"data"];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}


-(void)blockAction{
    __weak typeof(self) weakSelf = self;
    self.shoukkuanblock.upLoadblock = ^(NSInteger tag) {
        if (tag == 1) {
            [weakSelf showSheet:ZhengMian];
        }
        if (tag == 2) {
            [weakSelf showSheet:FanMian];
        }
    };
    
    
    self.shoukkuanblock.nextblock = ^{
        if ([weakSelf.name isEqualToString:@""]) {
            [xxzBase showBottomWithText:@"识别身份证姓名失败"];

            return;
        }
        if ([weakSelf.idCard isEqualToString:@""]) {
            [xxzBase showBottomWithText:@"识别身份证姓卡号失败"];

            return;
        }
        xxzErsionUppotController * scriptController = [[xxzErsionUppotController alloc]init];
        scriptController.name = weakSelf.name;
        scriptController.idCard = weakSelf.idCard;
        scriptController.empowerToken = weakSelf.empowerToken;
        [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
    };

    
}
-(void)showSheet:(NSString *)zhengfan{
    self.offCell = zhengfan;
    
    UIAlertController *p_viewController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *request = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *seconds = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        UIImagePickerController *totalController = [[UIImagePickerController alloc]init];
        
        totalController.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        totalController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        totalController.delegate = self;
        
        totalController.allowsEditing = YES;
        [self presentViewController:totalController animated:YES completion:nil];
        if(![self CameraPermissions]) return;
    }];
    UIAlertAction *limit = [UIAlertAction actionWithTitle:@"选择照片" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UIImagePickerController *photoImage = [[UIImagePickerController alloc] init];
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
            photoImage.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            photoImage.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:photoImage.sourceType];
        }
        photoImage.delegate = self;
        photoImage.allowsEditing = NO;
        [self presentViewController:photoImage animated:YES completion:nil];
    }];
    [p_viewController addAction:request];
    [p_viewController addAction:seconds];
    [p_viewController addAction:limit];
    [self presentViewController:p_viewController animated:YES completion:nil];
}
#pragma mark Delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage* huankuanblockImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        if ([self.offCell isEqualToString:ZhengMian]) {
            
            [self upLoadZhengMian:huankuanblockImage];
        }else{
            
            [self upLoadFanMian:huankuanblockImage];
        }
    }
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark -----------点击上传身份证正面照片---------------

#pragma mark -----------向服务器上传身份证正面---------------
-(void)upLoadZhengMian:(UIImage *)img{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:img forKey:@"file"];
    
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithImageURL:self hiddenHUD:NO url:@"/api/user/ocr/front/upload" Params:pass success:^(id  _Nonnull responseObject) {
        NSDictionary *oney = responseObject[@"data"];
        
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.zhengmianImv.image = img;
            weakSelf.shoukkuanblock.zhengmianTag.hidden = YES;
            
            weakSelf.name = responseObject[@"data"][@"name"];
            weakSelf.idCard = responseObject[@"data"][@"number"];
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
    
}
#pragma mark -----------点击上传身份证反面照片---------------
-(void)fanmianAction{
    [self showSheet:FanMian];
}
#pragma mark -----------向服务器上传身份证反面---------------
-(void)upLoadFanMian:(UIImage *)img{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *passd = [NSMutableDictionary dictionary];
    [passd setValue:img forKey:@"file"];
    if (self.empowerToken) {
        [passd setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithImageURL:self hiddenHUD:YES url:@"/api/user/ocr/back/upload" Params:passd success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.fanmianImv.image = img;
            weakSelf.shoukkuanblock.fanmianTag.hidden = YES;
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    

}
- (xxzNewsView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzNewsView alloc] init];
    }
    return _shoukkuanblock;
}
@end
