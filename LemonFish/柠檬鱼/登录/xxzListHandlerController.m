
#import "xxzListHandlerController.h"
#import "xxzOurseView.h"
#import "xxzUppotController.h"

@interface xxzListHandlerController ()
@property (nonatomic, strong) xxzOurseView *shoukkuanblock;

@end

@implementation xxzListHandlerController


-(void)loginAction{
    __weak typeof(self) weakSelf = self;
    self.shoukkuanblock.loginBlock = ^(NSString * phone, NSString * password) {
 
        if (!weakSelf.shoukkuanblock.selectBtn.isSelected) {
            [xxzBase showBottomWithText:@"请先阅读并同意用户协议"];
            return;
        }
        
        if (phone.length != 11) {
            [xxzBase showBottomWithText:@"手机号码错误,请重新核对并输入正确的手机号"];
            return;
        }
        if (password.length == 0) {
            [xxzBase showBottomWithText:@"请输入密码"];
            return;
        }
     
            NSMutableDictionary *pass7 = [NSMutableDictionary dictionary];
            [pass7 setValue:brandId forKey:@"brandId"];
            [pass7 setValue:phone forKey:@"username"];
            [pass7 setValue:[NSString MD5ForUpper32Bate:password] forKey:@"password"];
            

            [weakSelf NetWorkingPostWithURL:weakSelf hiddenHUD:NO url:@"/api/user/pass/login/password" Params:pass7 success:^(id  _Nonnull responseObject) {
                if([responseObject[@"code"] intValue] == 0){
                    [weakSelf loginSucess:responseObject[@"data"]];
                }
                [xxzBase showBottomWithText:responseObject[@"message"] duration:2.0];
            } failure:^(NSString * _Nonnull error) {}];
        

        
    };
    
    [self.shoukkuanblock.selectBtn bk_whenTapped:^{
        weakSelf.shoukkuanblock.selectBtn.selected = !self.shoukkuanblock.selectBtn.selected;
    }];
    [self.shoukkuanblock.forgetBtn bk_whenTapped:^{
        
        [weakSelf presentViewController:[xxzUppotController new] animated:YES completion:nil];

    }];
    
}

- (xxzOurseView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzOurseView alloc] init];
    }
    return _shoukkuanblock;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    self.mc_tableview.tableHeaderView.height = kScreenHeight;
    
    
    [self loginAction];
}

#pragma 保存登录信息

-(void)loginSucess:(NSDictionary *) result{
    
    
    
    
    NSUserDefaults *lijitixian = [NSUserDefaults standardUserDefaults];
    [lijitixian setObject:result forKey:@"UserData"];
    [lijitixian synchronize];
    
    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    if ([result allKeys].count > 0 ) {
        xxzUnicodeController *library = [[xxzUnicodeController alloc]init];
        delegate.window.rootViewController = library;
    }else{
        
        
    }
}


@end
