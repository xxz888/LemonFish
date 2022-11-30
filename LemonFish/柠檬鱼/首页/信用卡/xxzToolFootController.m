
#import "xxzToolFootController.h"
#import "xxzToastNewsView.h"

@interface xxzToolFootController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) xxzToastNewsView *shoukkuanblock;
@property (nonatomic, strong) NSString *baocun;

@property (nonatomic, strong) NSString *insiNews;


@end

@implementation xxzToolFootController


-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        if (weakSelf.startDic) {
            [weakSelf changeCardAction];

        }else{
            [weakSelf FbottomAction];

        }
    };
    
    self.shoukkuanblock.upLoadblock = ^{
        [weakSelf showSheet];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    NSDictionary *huabeiblock = [self loadUserData];

    
    if (self.empowerToken) {
        self.shoukkuanblock.nameTf.text = self.userDic[@"fullname"];
        
        
        
        
        
        
        
        
    }else{
        self.shoukkuanblock.nameTf.text = huabeiblock[@"fullname"];
    }
    self.insiNews = @"";
    
    if (self.startDic) {
    
        self.shoukkuanblock.nameView.hidden = YES;
        self.shoukkuanblock.phoneView.hidden = YES;
        self.shoukkuanblock.zhangdanriTf.hidden = NO;
        self.shoukkuanblock.huankuanriTf.hidden = NO;
        
        
        self.shoukkuanblock.bankView.userInteractionEnabled = NO;
        self.shoukkuanblock.bankTf.text = [NSString stringWithFormat:@"%@",self.startDic[@"cardNo"]];
        self.shoukkuanblock.cvn2Tf.text = [NSString stringWithFormat:@"%@",self.startDic[@"securityCode"]];
        self.shoukkuanblock.youxiaoqiTf.text = [NSString stringWithFormat:@"%@",self.startDic[@"expiredTime"]];
        self.shoukkuanblock.zhangdanriTf.text = [NSString stringWithFormat:@"%@",self.startDic[@"billDay"]];
        self.shoukkuanblock.huankuanriTf.text = [NSString stringWithFormat:@"%@",self.startDic[@"repaymentDay"]];
        self.shoukkuanblock.stackViewHeight.constant = 320;
        self.shoukkuanblock.navTitle.text = @"修改资料";
        [self.shoukkuanblock.submitBtn setTitle:@"  修改" forState:0];
    }
    [self blockAction];
}

-(void)upLoadCard:(UIImage *)img{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:img forKey:@"file"];
    
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithImageURL:self hiddenHUD:NO url:@"/api/user/ocr/bankcard" Params:pass success:^(id  _Nonnull responseObject) {
        NSDictionary *oney = responseObject[@"data"];
   
        if ([responseObject[@"code"] intValue] == 0) {
            weakSelf.shoukkuanblock.bankTf.text = oney[@"card_number"];
            weakSelf.baocun = oney[@"card_number"];
            weakSelf.insiNews = oney[@"bank_name"];
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
    
}
#pragma 确定绑定

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}



- (void)FbottomAction{
    

    if([NSString isBlankString:self.shoukkuanblock.nameTf.text]){
        [xxzBase showBottomWithText:@"账户姓名不能为空"];
        return;
    }
    if([NSString isBlankString:self.shoukkuanblock.bankTf.text]){
        [xxzBase showBottomWithText:@"银行卡号不能为空"];
        return;
    }
    if([NSString isBlankString:self.shoukkuanblock.phoneTf.text]){
        [xxzBase showBottomWithText:@"手机号不能为空"];
        return;
    }

    if([NSString isBlankString:self.shoukkuanblock.cvn2Tf.text]){
        [xxzBase showBottomWithText:@"cvn2不能为空"];
        return;
    }
    
    if([NSString isBlankString:self.shoukkuanblock.youxiaoqiTf.text]){
        [xxzBase showBottomWithText:@"有效期不能为空"];
        return;
    }
    
    if([NSString isBlankString:self.shoukkuanblock.zhangdanriTf.text]){
        [xxzBase showBottomWithText:@"账单日不能为空"];
        return;
    }
    if([NSString isBlankString:self.shoukkuanblock.huankuanriTf.text]){
        [xxzBase showBottomWithText:@"还款日不能为空"];
        return;
    }
    NSDictionary *huabeiblockU = [self loadUserData];
    
    NSMutableDictionary *passc = [NSMutableDictionary dictionary];
    [passc setValue:[self.shoukkuanblock.bankTf.text RemoveTheBlankSpace:self.shoukkuanblock.bankTf.text] forKey:@"bankcard"];
    [passc setValue:self.shoukkuanblock.phoneTf.text forKey:@"phone"];
    [passc setValue:self.shoukkuanblock.youxiaoqiTf.text forKey:@"expiredTime"];
    [passc setValue:self.shoukkuanblock.cvn2Tf.text forKey:@"securityCode"];
    [passc setValue:self.shoukkuanblock.zhangdanriTf.text forKey:@"billDay"];
    [passc setValue:self.shoukkuanblock.huankuanriTf.text forKey:@"repaymentDay"];
    [passc setValue:self.shoukkuanblock.nameTf.text forKey:@"fullname"];
    [passc setValue:self.insiNews forKey:@"bankName"];
   
    
    NSLog(@"data:%@",passc);
    
    
    if (self.empowerToken) {
        [passc setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/bind/credit/card" Params:passc success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            
            [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
 
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

-(void)changeCardAction{
    if([NSString isBlankString:self.shoukkuanblock.cvn2Tf.text]){
        [xxzBase showBottomWithText:@"cvn2不能为空"];
        return;
    }
    
    if([NSString isBlankString:self.shoukkuanblock.youxiaoqiTf.text]){
        [xxzBase showBottomWithText:@"有效期不能为空"];
        return;
    }
    
    if([NSString isBlankString:self.shoukkuanblock.zhangdanriTf.text]){
        [xxzBase showBottomWithText:@"账单日不能为空"];
        return;
    }
    if([NSString isBlankString:self.shoukkuanblock.huankuanriTf.text]){
        [xxzBase showBottomWithText:@"还款日不能为空"];
        return;
    }

    NSMutableDictionary *passO = [NSMutableDictionary dictionary];
    [passO setValue:[NSString stringWithFormat:@"%@",self.startDic[@"id"]] forKey:@"id"];
    [passO setValue:[NSString stringWithFormat:@"%@",self.startDic[@"cardNo"]] forKey:@"cardNo"];
    [passO setValue:[NSString stringWithFormat:@"%@",self.startDic[@"phone"]] forKey:@"phone"];

    
    [passO setValue:self.shoukkuanblock.youxiaoqiTf.text forKey:@"expiredTime"];
    [passO setValue:self.shoukkuanblock.cvn2Tf.text forKey:@"securityCode"];
    [passO setValue:self.shoukkuanblock.zhangdanriTf.text forKey:@"billDay"];
    [passO setValue:self.shoukkuanblock.huankuanriTf.text forKey:@"repaymentDay"];
    
    NSLog(@"data:%@",passO);
    
    
    if (self.empowerToken) {
        [passO setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/credit/card/update" Params:passO success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            
            [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        UIImage* huankuanblockImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
        [self upLoadCard:huankuanblockImage];
    }
}
#pragma mark -----------点击上传身份证正面照片---------------

#pragma mark -----------向服务器上传身份证正面---------------

- (xxzToastNewsView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzToastNewsView alloc] init];
    }
    return _shoukkuanblock;
}


@end
