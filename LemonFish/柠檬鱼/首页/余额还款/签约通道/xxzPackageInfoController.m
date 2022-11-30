
#import "xxzPackageInfoController.h"
#import "xxzOginView.h"

@interface xxzPackageInfoController ()
@property (nonatomic, strong) xxzOginView *shoukkuanblock;
@property (nonatomic ,strong)NSString * more;
@end

@implementation xxzPackageInfoController


-(void)fastApply{
    __weak typeof(self) weakSelf = self;
    NSMutableDictionary * pass= [[ NSMutableDictionary alloc]init];
    [pass setValue:self.startDic[@"creditCardNumber"] forKey:@"cardNo"];

    if (self.empowerToken) {
        [pass setValue:self.empowerToken forKey:@"empowerToken"];
    }
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/bind/card" Params:pass success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"message"] isEqualToString:@"重复签约"]) {
            [xxzBase showBottomWithText:@"你已经签此通道"];
            [weakSelf.xp_rootNavigationController qmui_popViewControllerAnimated:YES completion:^{
                weakSelf.singBlock();
            }];
            
            return;
        }
        
        if ([responseObject[@"code"] integerValue] == 0) {
            weakSelf.more = responseObject[@"data"];
            [xxzBase showBottomWithText:@"短信发送成功"];
            [weakSelf changeSendBtnText];
        }
    
        
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

#pragma 确定绑定

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    
    self.shoukkuanblock.xinyongkaIcon.image = [UIImage imageNamed:getBankLogo(self.xinyongkaDic[@"bankAcronym"])];
    self.shoukkuanblock.xinyongkaNum.text = [NSString stringWithFormat:@"%@(尾号%@)",self.startDic[@"bankName"],[self.startDic[@"creditCardNumber"] substringFromIndex:[self.startDic[@"creditCardNumber"] length]-4]];
    [self.shoukkuanblock.cardBackView insertSubview:[self returnCardView:CGRectMake(0,0,kScreenWidth-52,80) colorOne:self.colorOne colorTwo:self.colorTwo] atIndex:0];
    
    
    self.shoukkuanblock.anquanmaTf.text = self.startDic[@"securityCode"];
    self.shoukkuanblock.youxiaoqiTf.text = self.startDic[@"expiredTime"];
    self.shoukkuanblock.phoneTf.text = self.startDic[@"bankPhone"];

    [self blockAction];
}

- (void)changeSendBtnText{

    __block NSInteger acc = 60;
    
    dispatch_queue_t tixianjine = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_source_t sing = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, tixianjine);
    
    dispatch_source_set_timer(sing, dispatch_walltime(NULL, 0), 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    
    dispatch_source_set_event_handler(sing, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (acc >= 0) {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = NO;
                [self.shoukkuanblock.sendBtn setTitle:[NSString stringWithFormat:@"%lds", acc] forState:0];
                
                acc--;
                
                
            }else {
                self.shoukkuanblock.sendBtn.userInteractionEnabled = YES;
                dispatch_source_cancel(sing);
                [self.shoukkuanblock.sendBtn setTitle:@"重新发送" forState:0];

            }
            
        });
    });
    
    dispatch_resume(sing);
}


- (void)blockAction{


    [self.shoukkuanblock.sendBtn bk_whenTapped:^{
        
        [self fastApply];
    }];
    
    [self.shoukkuanblock.nextBtn bk_whenTapped:^{
        [self submitAction];
    }];
 
}


-(void)submitAction{
    if ([self isEmpty:self.shoukkuanblock.codeTf.text]) {
        [xxzBase showBottomWithText:@"请输入验证码"];
        return;
    }
    if ([self isEmpty:self.more]) {
        [xxzBase showBottomWithText:@"bindId获取失败"];
        return;
    }
    NSDictionary * date = @{@"cardNo":self.startDic[@"creditCardNumber"],
                           @"idCard":self.startDic[@"idcard"],
                           @"smsCode":self.shoukkuanblock.codeTf.text,
                           @"bindId":self.more
    };
    __weak typeof(self) weakSelf = self;
    
    
    
    NSMutableDictionary * passU= [[ NSMutableDictionary alloc]initWithDictionary:date];

    if (self.empowerToken) {
        [passU setValue:self.empowerToken forKey:@"empowerToken"];
    }
    
    
    
    
    
    [self NetWorkingPostWithAddressURL:self hiddenHUD:YES url:@"/api/credit/bind/card/confirm" Params:passU success:^(id  _Nonnull responseObject) {
        
        if ([responseObject[@"code"] intValue] == 0) {
            [xxzBase showBottomWithText:responseObject[@"message"]];
            [self.xp_rootNavigationController qmui_popViewControllerAnimated:YES completion:^{
                weakSelf.singBlock();
            }];
        }
        else{
            if ([responseObject[@"message"] isEqualToString:@"动态验证码不符"]) {
                [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
            }
            if ([responseObject[@"message"] isEqualToString:@"处理中"]) {
                [weakSelf.xp_rootNavigationController popViewControllerAnimated:YES];
            }
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}

- (xxzOginView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzOginView alloc] init];
    }
    return _shoukkuanblock;
}




@end
