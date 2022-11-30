
#import "xxzConstController.h"
#import "xxzEfreshView.h"
#import "xxzConstXplainController.h"
#import "xxzOprationView.h"

#import "SDImageCache.h"


@interface xxzConstController ()
@property (nonatomic, strong) xxzEfreshView *shoukkuanblock;
@property (nonatomic, strong) NSDictionary * tishi;
@property (nonatomic, strong) NSString * yitixian;


@end

@implementation xxzConstController


-(void)loginAction{
    __weak typeof(self) weakSelf = self;

    
        if (weakSelf.shoukkuanblock.codeTf.text.length == 0) {
            [xxzBase showBottomWithText:@"请输入验证码"];
            return;
        }
        if (weakSelf.shoukkuanblock.onePwdTf.text.length == 0 || weakSelf.shoukkuanblock.twoPwdTf.text.length == 0) {
            [xxzBase showBottomWithText:@"请输入新密码"];
            return;
        }
        if (![weakSelf.shoukkuanblock.onePwdTf.text isEqualToString:weakSelf.shoukkuanblock.twoPwdTf.text]) {
            [xxzBase showBottomWithText:@"两次密码输入不一致"];
            return;
        }
        
            NSDictionary *huabeiblock = [self loadUserData];
            NSMutableDictionary *passX = [NSMutableDictionary dictionary];
            [passX setValue:brandId forKey:@"brandId"];
            [passX setValue:weakSelf.shoukkuanblock.codeTf.text forKey:@"smsCode"];
            [passX setValue:[NSString MD5ForUpper32Bate:weakSelf.shoukkuanblock.onePwdTf.text] forKey:@"password"];
            [passX setValue:huabeiblock[@"username"] forKey:@"username"];
            

            [weakSelf NetWorkingPostWithURL:weakSelf hiddenHUD:NO url:@"/api/user/update/pwd" Params:passX success:^(id  _Nonnull responseObject) {
                if([responseObject[@"code"] intValue] == 0){
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }
                [xxzBase showBottomWithText:responseObject[@"message"] duration:2.0];
            } failure:^(NSString * _Nonnull error) {}];

  
    
}

- (xxzEfreshView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEfreshView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 1000)];
    }
    return _shoukkuanblock;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    

    __weak typeof(self) weakSelf = self;
    [self.shoukkuanblock.sureBtn bk_whenTapped:^{
        [weakSelf loginAction];
    }];
    
    [self.shoukkuanblock.codeBtn bk_whenTapped:^{
        [weakSelf sendSms];
    }];

}

-(void)sendSms{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblocki = [self loadUserData];
    [self NetWorkingPostWithURL:self hiddenHUD:YES url:@"/api/notice/pass/sms/send" Params:@{@"phone":huabeiblocki[@"username"],@"type":@"0",@"brandId":brandId} success:^(id  _Nonnull responseObject) {
        
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

@end
