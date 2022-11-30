
#import "xxzBaseEceiveController.h"
#import "xxzAddressMessageView.h"
#import "xxzListHandlerController.h"
#import "UIButton+WebCache.h"

@interface xxzBaseEceiveController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) xxzAddressMessageView *shoukkuanblock;
@property (nonatomic, strong) NSString *baocun;

@property (nonatomic, strong) NSString *insiNews;


@end

@implementation xxzBaseEceiveController


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self getData];
}

-(void)upLoadAvatar:(UIImage *)img{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:img forKey:@"file"];
    [self NetWorkingPostWithImageURL:self hiddenHUD:NO url:@"/api/user/update/avatar" Params:pass success:^(id  _Nonnull responseObject) {
        NSDictionary *oney = responseObject[@"data"];
        if ([responseObject[@"code"] intValue] == 0) {
            [weakSelf getData];

        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
    
}

- (xxzAddressMessageView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzAddressMessageView alloc] init];
    }
    return _shoukkuanblock;
}

-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        
        NSUserDefaults *goods = [NSUserDefaults standardUserDefaults];
        NSDictionary *date = [goods dictionaryRepresentation];
        for (id key in date) {
            [goods removeObjectForKey:key];
        }

        [goods synchronize];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [xxzBase showBottomWithText:@"已安全退出"];
        });

        AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        xxzListHandlerController *originView = [[xxzListHandlerController alloc]init];
        xxzMainCardController *shouxufei = [[xxzMainCardController alloc]initWithRootViewController:originView];
        delegate.window.rootViewController = shouxufei;
    };
    
    self.shoukkuanblock.upLoadblock = ^{
        [weakSelf showSheet];
    };
    
    [self.shoukkuanblock.nichengView bk_whenTapped:^{
        [weakSelf changeNick];
    }];
    
    [self.shoukkuanblock.weixinView bk_whenTapped:^{
        [weakSelf changeWeixin];
    }];
    
    [self.shoukkuanblock.zhifubaoView bk_whenTapped:^{
        [weakSelf changeAlipay];
    }];
    
}

-(void)changeNick{
    __weak typeof(self) weakSelf = self;

    UIAlertController *dengjiController = [UIAlertController alertControllerWithTitle:nil message:@"更改昵称" preferredStyle:UIAlertControllerStyleAlert];
        
        [dengjiController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [dengjiController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *ziyongfanxian = dengjiController.textFields.firstObject;
            if ([ziyongfanxian.text isEqualToString:@""]) {
                [xxzBase showBottomWithText:@"请输入昵称"];
                return;
            }
            [weakSelf changeInfo:@{@"nick":ziyongfanxian.text}];
        }]];

        

        [dengjiController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

            textField.placeholder = @"请输入昵称";


        }];
        [self presentViewController:dengjiController animated:true completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage* huankuanblockImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self upLoadAvatar:huankuanblockImage];
    }
}

-(void)changeInfo:(NSDictionary *)dic{
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/upd/user/date" Params:dic success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            [weakSelf getData];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
}

-(void)getData{
    
    __weak typeof(self) weakSelf = self;

    NSDictionary *huabeiblock = [self loadUserData];

    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/user/user/data" Params:[NSDictionary dictionary] success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            NSDictionary * dateC =  responseObject[@"data"];
            weakSelf.shoukkuanblock.nameTf.text = dateC[@"fullname"];
            weakSelf.shoukkuanblock.phoneTf.text = dateC[@"username"];
            weakSelf.shoukkuanblock.nickTf.text = dateC[@"nick"] ? dateC[@"nick"] : @"";
            weakSelf.shoukkuanblock.weixinTf.text = dateC[@"wechatNumber"] ? dateC[@"wechatNumber"] : @"";
            weakSelf.shoukkuanblock.zhifubaoTf.text = dateC[@"payId"] ? dateC[@"payId"] : @"";
            weakSelf.shoukkuanblock.shimingTf.text = [dateC[@"selfLevel"] intValue] == 0 ? @"未实名" : @"已实名";
            [weakSelf.shoukkuanblock.photoBtn sd_setImageWithURL:[NSURL URLWithString:dateC[@"avatar"]] forState:0 placeholderImage:[UIImage imageNamed:@"empowerYangkajigou"]];

        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}




-(void)changeWeixin{
    __weak typeof(self) weakSelf = self;

    UIAlertController *dengjiControllerh = [UIAlertController alertControllerWithTitle:nil message:@"更改微信号" preferredStyle:UIAlertControllerStyleAlert];
        
        [dengjiControllerh addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [dengjiControllerh addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *ziyongfanxianP = dengjiControllerh.textFields.firstObject;
            ziyongfanxianP.secureTextEntry = NO;

            if ([ziyongfanxianP.text isEqualToString:@""]) {
                [xxzBase showBottomWithText:@"请输入微信号"];
                return;
            }
            [weakSelf changeInfo:@{@"wechatNumber":ziyongfanxianP.text}];
        }]];

        

        [dengjiControllerh addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

            textField.placeholder = @"请输入微信号";


        }];
        [self presentViewController:dengjiControllerh animated:true completion:nil];
}


-(void)showSheet{
    
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

-(void)changeAlipay{
    __weak typeof(self) weakSelf = self;

    UIAlertController *dengjiControllerQ = [UIAlertController alertControllerWithTitle:nil message:@"更改支付宝号" preferredStyle:UIAlertControllerStyleAlert];
        
        [dengjiControllerQ addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        }]];

        [dengjiControllerQ addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            UITextField *ziyongfanxianY = dengjiControllerQ.textFields.firstObject;
            ziyongfanxianY.secureTextEntry = NO;

            if ([ziyongfanxianY.text isEqualToString:@""]) {
                [xxzBase showBottomWithText:@"请输入支付宝hao"];
                return;
            }
            [weakSelf changeInfo:@{@"payId":ziyongfanxianY.text}];
        }]];

        

        [dengjiControllerQ addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

            textField.placeholder = @"请输入支付宝号";


        }];
        [self presentViewController:dengjiControllerQ animated:true completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;

    

    

    
    
    
   
    [self blockAction];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}


@end
