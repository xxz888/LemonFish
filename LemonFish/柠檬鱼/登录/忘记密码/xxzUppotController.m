
#import "xxzUppotController.h"
#import "xxzTitlePrefixView.h"

@interface xxzUppotController ()
@property (nonatomic, strong) xxzTitlePrefixView *shoukkuanblock;

@end

@implementation xxzUppotController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.mc_tableview.backgroundColor = [UIColor colorWithHexString:@"#F8F8F8"];
    self.mc_tableview.tableHeaderView.height = kScreenHeight;
    
    if ([self.come isEqualToString:@"000"] ) {
        self.shoukkuanblock.regTip.text = @"注册";
        self.shoukkuanblock.regTip1.hidden =   self.shoukkuanblock.regtip2.hidden  =  self.shoukkuanblock.regtip3.hidden  = YES;
        self.shoukkuanblock.navTitle.text = @"注册";
    }
    
    __weak typeof(self) weakSelf = self;

    [self.shoukkuanblock.codeBtn bk_whenTapped:^{
        [weakSelf sendSms];
    }];
    
    [self.shoukkuanblock.sureBtn bk_whenTapped:^{
        [weakSelf loginAction];
    }];
}

-(void)sendSms{

    __weak typeof(self) weakSelf = self;
    if (weakSelf.shoukkuanblock.phoneTf.text.length != 11) {
        [xxzBase showBottomWithText:@"手机号码错误,请重新核对并输入正确的手机号"];
        return;
    }
    if ([self.come isEqualToString:@"000"] ) {
        [xxzBase showBottomWithText:@"短信发送成功"];
        return;
    }
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/notice/pass/sms/send" Params:@{@"phone":weakSelf.shoukkuanblock.phoneTf.text,@"type":@"0",@"brandId":brandId} success:^(id  _Nonnull responseObject) {
        
        
        
        if ([responseObject[@"code"] integerValue] == 0) {
            [xxzBase showBottomWithText:@"短信发送成功"];
            [weakSelf changeSendBtnText];
        }

        
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}


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

- (xxzTitlePrefixView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzTitlePrefixView alloc] init];
    }
    return _shoukkuanblock;
}

-(void)loginAction{
    __weak typeof(self) weakSelf = self;

        if (weakSelf.shoukkuanblock.phoneTf.text.length != 11) {
            [xxzBase showBottomWithText:@"手机号码错误,请重新核对并输入正确的手机号"];
            return;
        }
        if (weakSelf.shoukkuanblock.codeTf.text.length == 0) {
            [xxzBase showBottomWithText:@"请输入验证码"];
            return;
        }
        if (weakSelf.shoukkuanblock.onePsdTf.text.length == 0 || weakSelf.shoukkuanblock.twoPsdTf.text.length == 0) {
            [xxzBase showBottomWithText:@"请输入新密码"];
            return;
        }
        if (![weakSelf.shoukkuanblock.onePsdTf.text isEqualToString:weakSelf.shoukkuanblock.twoPsdTf.text]) {
            [xxzBase showBottomWithText:@"两次密码输入不一致"];
            return;
        }
        
        
            NSMutableDictionary *passe = [NSMutableDictionary dictionary];
            [passe setValue:brandId forKey:@"brandId"];
            [passe setValue:weakSelf.shoukkuanblock.codeTf.text forKey:@"smsCode"];
            [passe setValue:[NSString MD5ForUpper32Bate:weakSelf.shoukkuanblock.onePsdTf.text] forKey:@"password"];
            [passe setValue:weakSelf.shoukkuanblock.phoneTf.text forKey:@"username"];
            

            [weakSelf NetWorkingPostWithURL:weakSelf hiddenHUD:NO url:@"/api/user/update/pwd" Params:passe success:^(id  _Nonnull responseObject) {
                if([responseObject[@"code"] intValue] == 0){
                    [weakSelf dismissViewControllerAnimated:YES completion:nil];
                }
                [xxzBase showBottomWithText:responseObject[@"message"] duration:2.0];
            } failure:^(NSString * _Nonnull error) {}];

  
    
}


@end
