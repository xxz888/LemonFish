
#import "xxzScriptController.h"
#import "xxzDelegateFormatterView.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"

#import "SDImageCache.h"
#import "xxzListHandlerController.h"

@interface xxzScriptController ()
@property (nonatomic, strong) xxzDelegateFormatterView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * tishi;
@property (nonatomic, strong) NSString * yitixian;


@end

@implementation xxzScriptController


- (void)changeSendBtnText{

    __block NSInteger acc = 60;
    
    dispatch_queue_t tixianjine = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t sing = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, tixianjine);
    
    dispatch_source_set_timer(sing, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(sing, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (acc >= 0) {
                self.shoukkuanblock.codeBtn.userInteractionEnabled = NO;
                [self.shoukkuanblock.codeBtn setTitle:[NSString stringWithFormat:@"%lds", acc] forState:0];
                
                acc--;
                
                
            }else {
                self.shoukkuanblock.codeBtn.userInteractionEnabled = YES;
                dispatch_source_cancel(sing);
                [self.shoukkuanblock.codeBtn setTitle:@"重新发送" forState:0];

            }
            
        });
    });
    
    dispatch_resume(sing);
}

-(void)sendSms{
    __weak typeof(self) weakSelf = self;
    if ([self.shoukkuanblock.phoneNew.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:@"请输入新手机号"];
        return;
    }
    NSDictionary *huabeiblock = [self loadUserData];
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/notice/pass/sms/send" Params:@{@"phone":self.shoukkuanblock.phoneNew.text,@"type":@"0",@"brandId":brandId} success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [xxzBase showBottomWithText:@"短信发送成功"];
            [weakSelf changeSendBtnText];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}


-(void)loginAction{
    __weak typeof(self) weakSelf = self;

        if (weakSelf.shoukkuanblock.codeTf.text.length == 0) {
            [xxzBase showBottomWithText:@"请输入验证码"];
            return;
        }
    if ([self.shoukkuanblock.phoneNew.text isEqualToString:@""]) {
        [xxzBase showBottomWithText:@"请输入新手机号"];
        return;
    }
        
            NSDictionary *huabeiblock5 = [self loadUserData];
            NSMutableDictionary *pass = [NSMutableDictionary dictionary];
            [pass setValue:weakSelf.shoukkuanblock.codeTf.text forKey:@"smsCode"];
            [pass setValue:self.shoukkuanblock.phoneNew.text forKey:@"phone"];
            

            [weakSelf NetWorkingPostWithAddressURL:weakSelf hiddenHUD:NO url:@"/api/user/change/username" Params:pass success:^(id  _Nonnull responseObject) {
                if([responseObject[@"code"] intValue] == 0){
                    AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                    xxzListHandlerController *originView = [[xxzListHandlerController alloc]init];
                    xxzMainCardController *shouxufei = [[xxzMainCardController alloc]initWithRootViewController:originView];
                    delegate.window.rootViewController = shouxufei;
                }
                [xxzBase showBottomWithText:responseObject[@"message"] duration:2.0];
            } failure:^(NSString * _Nonnull error) {}];

  
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

    NSDictionary *huabeiblockh = [self loadUserData];
    self.shoukkuanblock.oldPhone.text =    huabeiblockh[@"username"];
    
    
    __weak typeof(self) weakSelf = self;
    [self.shoukkuanblock.sureBtn bk_whenTapped:^{
        [weakSelf loginAction];
    }];
    
    [self.shoukkuanblock.codeBtn bk_whenTapped:^{
        [weakSelf sendSms];
    }];

}

- (xxzDelegateFormatterView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzDelegateFormatterView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}

@end
