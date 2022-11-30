
#import "xxzHeaderController.h"
#import "xxzSettingOginView.h"

@interface xxzHeaderController ()
@property (nonatomic, strong) xxzSettingOginView *shoukkuanblock;

@end

@implementation xxzHeaderController


- (xxzSettingOginView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzSettingOginView alloc] init];
    }
    return _shoukkuanblock;
}

-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        
        [weakSelf FbottomAction];
    };
}
#pragma 确定绑定

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    
    [self blockAction];
    
    
    NSDictionary *huabeiblock = [self loadUserData];

    
    if (self.empowerToken) {
        self.shoukkuanblock.nameTf.text = self.userDic[@"fullname"];
        self.shoukkuanblock.idCardTf.text = self.userDic[@"idcard"];
        
        

    }else{
        if (huabeiblock[@"fullname"]) {
            self.shoukkuanblock.nameTf.text = huabeiblock[@"fullname"];
        }
        if (huabeiblock[@"idcard"]) {
            self.shoukkuanblock.idCardTf.text = huabeiblock[@"idcard"];

        }
        
    }

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

    
    NSLog(@"data:%@",pass);
    
    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    __weak typeof(self) weakSelf = self;
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/user/debit/card/bind" Params:pass success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            [weakSelf.xp_rootNavigationController qmui_popViewControllerAnimated:YES completion:^{
                if (weakSelf.block) {
                    weakSelf.block();
                }
            }];
            
        }else{
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
 
}




@end
