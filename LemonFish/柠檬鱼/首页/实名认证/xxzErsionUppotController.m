
#import "xxzErsionUppotController.h"
#import "xxzControlView.h"
#import "xxzConfirmToolsController.h"
#import "xxzErsionController.h"
@interface xxzErsionUppotController ()
@property (nonatomic, strong) xxzControlView *shoukkuanblock;

@end

@implementation xxzErsionUppotController


-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        
        [weakSelf idcardUpdate];
    };
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    
    self.shoukkuanblock.nameTf.text = self.name;
    self.shoukkuanblock.idCardTf.text = self.idCard;
    [self blockAction];
}
#pragma 确定绑定

- (xxzControlView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzControlView alloc] init];
    }
    return _shoukkuanblock;
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
    if([NSString isBlankString:self.shoukkuanblock.idCardTf.text]){
        [xxzBase showBottomWithText:@"身份证不能为空"];
        return;
    }
    
    if([NSString isBlankString:self.shoukkuanblock.adressTf.text]){
        [xxzBase showBottomWithText:@"开卡户地不能为空"];
        return;
    }
  
    
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];
    [pass setValue:[self.shoukkuanblock.bankTf.text RemoveTheBlankSpace:self.shoukkuanblock.bankTf.text] forKey:@"bankcard"];
    [pass setValue:self.shoukkuanblock.adressTf.text forKey:@"provinceCity"];
    [pass setValue:self.shoukkuanblock.phoneTf.text forKey:@"phone"];
    [pass setValue:self.shoukkuanblock.idCardTf.text forKey:@"idcard"];
    [pass setValue:self.shoukkuanblock.nameTf.text forKey:@"fullname"];

    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    NSLog(@"data:%@",pass);
    
    
    
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/debit/card/bind" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            
            if (self.empowerToken) {
                
                xxzErsionController * scriptController = [[xxzErsionController alloc]initWithEmpowerToken:self.empowerToken userDic:pass];
                [weakSelf.xp_rootNavigationController pushViewController:scriptController animated:YES];
                
                
                

            }else{
                [weakSelf.xp_rootNavigationController popToRootViewControllerAnimated:YES];
            }
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
 
}



-(void)idcardUpdate{
    __weak typeof(self) weakSelf = self;
    if([NSString isBlankString:self.shoukkuanblock.nameTf.text]){
        [xxzBase showBottomWithText:@"账户姓名不能为空"];
        return;
    }
    if([NSString isBlankString:self.shoukkuanblock.idCardTf.text]){
        [xxzBase showBottomWithText:@"身份证不能为空"];
        return;
    }
    
    NSMutableDictionary *passw = [NSMutableDictionary dictionary];
    [passw setValue:self.shoukkuanblock.idCardTf.text forKey:@"idcard"];
    [passw setValue:self.shoukkuanblock.nameTf.text forKey:@"fullname"];
    
    if (self.empowerToken) {
        [passw setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/idcard/update" Params:passw success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [weakSelf FbottomAction];
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
}




@end
