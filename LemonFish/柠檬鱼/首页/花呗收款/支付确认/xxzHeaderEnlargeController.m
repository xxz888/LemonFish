
#import "xxzFriendsProgressController.h"
#import "xxzEditTitleView.h"
#import "xxzInyongkaView.h"

@interface xxzFriendsProgressController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) xxzEditTitleView *shoukkuanblock;
@property (nonatomic, strong) NSString *baocun;

@property (nonatomic, strong) NSString *insiNews;
@property (nonatomic , strong) NSString *huankuanjine;


@end

@implementation xxzFriendsProgressController


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

- (void)FbottomAction{
    
 
}
#pragma 确认刷卡接口

- (void)GetConfirmTheCharge{
    if ([self.shoukkuanblock.priceTf.text doubleValue] == 0) {
        [xxzBase showBottomWithText:@"支付金额不能为空"];
        return;
    }
    if ([self.startDic[@"needCity"] integerValue] == 1) {
        if([NSString isBlankString:self.shoukkuanblock.cityCode]){
            [xxzBase showBottomWithText:@"消费地区不能为空"];
            return;
        }
    }
    if ([self.startDic[@"needCode"] integerValue] == 1) {
        if([NSString isBlankString:self.shoukkuanblock.codeTf.text]){
            [xxzBase showBottomWithText:@"验证码不能为空"];
            return;
        }
    }
 
    
    NSMutableDictionary *kehushu = [NSMutableDictionary dictionary];
    NSDictionary *huabeiblock = [self loadUserData];
    [kehushu setValue:self.huankuanjine forKey:@"orderCode"];
    [kehushu setValue:self.startDic[@"id"] forKey:@"channelId"];
    [kehushu setValue:huabeiblock[@"idcard"] forKey:@"idCard"];
    [kehushu setValue:self.shoukkuanblock.codeTf.text forKey:@"smsCode"];
    [kehushu setValue:self.xinyongkaDic[@"cardNo"] forKey:@"bankCard"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/fast/confirm" Params:kehushu success:^(id  _Nonnull responseObject) {
        if ([responseObject[@"code"] intValue] == 3) {
            [self TheOrderStatus];
        }else{
            [xxzBase showBottomWithText:responseObject[@"message"]];
        }
    } failure:^(NSString * _Nonnull error) {
        
    }];
}
#pragma 查看订单状态

- (xxzEditTitleView *)shoukkuanblock
{
    if (!_shoukkuanblock) {
        _shoukkuanblock = [[xxzEditTitleView alloc] init];
    }
    return _shoukkuanblock;
}

-(void)fastApply{
    __weak typeof(self) weakSelf = self;
    NSDictionary *huabeiblockD = [self loadUserData];
    NSMutableDictionary *pass = [NSMutableDictionary dictionary];

    if([NSString isBlankString:self.shoukkuanblock.priceTf.text]){
        [xxzBase showBottomWithText:@"支付金额不能为空"];
        return;
    }
    
    if ([self.startDic[@"needCity"] integerValue] == 1) {
        if([NSString isBlankString:self.shoukkuanblock.cityCode]){
            [xxzBase showBottomWithText:@"消费地区不能为空"];
            return;
        }else{
            [pass setValue:self.shoukkuanblock.cityCode forKey:@"cityCode"];

        }
    }

    

    
    
    [pass setValue:self.startDic[@"id"] forKey:@"channelId"];
    [pass setValue:self.shoukkuanblock.priceTf.text forKey:@"amount"];
    [pass setValue:huabeiblockD[@"username"] forKey:@"loginPhone"];
    [pass setValue:huabeiblockD[@"idcard"] forKey:@"idCard"];

    [pass setValue:self.xinyongkaDic[@"bankName"] forKey:@"bankName"];
    [pass setValue:self.xinyongkaDic[@"cardNo"] forKey:@"bankCard"];
    [pass setValue:self.xinyongkaDic[@"phone"] forKey:@"bankPhone"];
    [pass setValue:self.xinyongkaDic[@"securityCode"] forKey:@"securityCode"];
    [pass setValue:self.xinyongkaDic[@"expiredTime"] forKey:@"expiredTime"];
    [pass setValue:self.xinyongkaDic[@"fullname"] forKey:@"userName"];
    
   
    [pass setValue:self.chuxukaDic[@"bankName"] forKey:@"debitBankName"];
    [pass setValue:self.chuxukaDic[@"cardNo"] forKey:@"debitBankCard"];
    [pass setValue:self.chuxukaDic[@"phone"] forKey:@"debitPhone"];
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/fast/apply" Params:pass success:^(id  _Nonnull responseObject) {
        weakSelf.huankuanjine = responseObject[@"data"];
        [xxzBase showBottomWithText:@"短信发送成功"];
        [weakSelf changeSendBtnText];
        
        if ([weakSelf.startDic[@"needCode"] integerValue] != 1) {
            [self TheOrderStatus];
        }
    } failure:^(NSString * _Nonnull error) {
        [xxzBase showBottomWithText:error];
    }];
    
    
}

#pragma 确定绑定

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mc_tableview.tableHeaderView = self.shoukkuanblock;
    self.shoukkuanblock.startDic = self.startDic;
    NSDictionary *huabeiblocki = [self loadUserData];
    self.shoukkuanblock.phoneLbl.text = [NSString stringWithFormat:@"需验证您在银行预留手机号%@",self.xinyongkaDic[@"phone"]];
    self.huankuanjine = @"";
 
    
    
    if ([self.startDic[@"needCity"] integerValue] == 1) {
        self.shoukkuanblock.xiaofeidiqvView.hidden = NO;
        self.shoukkuanblock.middleHeight.constant = 250;
    }else{
        self.shoukkuanblock.middleHeight.constant = 200;
    }
    if ([self.startDic[@"needCode"] integerValue] == 1) {
        self.shoukkuanblock.codeView.hidden = NO;
        self.shoukkuanblock.codeViewHeight.constant = 85;
    }else{
        self.shoukkuanblock.codeViewHeight.constant = 0;
    }
    
    
    
    
    self.shoukkuanblock.danbixianeLbl.text = [NSString stringWithFormat:@"%@-%@元",self.startDic[@"limitMin"],self.startDic[@"limitMax"]];
    self.shoukkuanblock.danrixianeLbl.text = [NSString stringWithFormat:@"%@元",self.startDic[@"dayMax"]];
    
    
    self.insiNews = @"";
    [self blockAction];
}


-(void)blockAction{
    
    __weak typeof(self) weakSelf = self;
    
    self.shoukkuanblock.nextblock = ^{
        
        
        
        if ([weakSelf.startDic[@"needCode"] integerValue] == 1) {
            [weakSelf GetConfirmTheCharge];
        }
        else{
           [weakSelf fastApply];
        }
    };
    
    self.shoukkuanblock.sendCodeBlock = ^{
        [weakSelf fastApply];
    };
    
    
}

- (void)TheOrderStatus{
    @weakify(self);
    NSMutableDictionary *kehushus = [NSMutableDictionary dictionary];
    [kehushus setValue:self.startDic[@"id"] forKey:@"channelId"];
    [kehushus setValue:self.huankuanjine forKey:@"orderCode"];
    NSDictionary *huabeiblockW = [self loadUserData];
    [kehushus setValue:huabeiblockW[@"idcard"] forKey:@"idCard"];
    
    [self NetWorkingPostWithURL:self hiddenHUD:NO url:@"/api/payment/fast/query" Params:kehushus success:^(id  _Nonnull responseObject) {
        
        xxzInyongkaView *jihuajine = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([xxzInyongkaView class]) owner:nil options:nil] lastObject];
        
            if ([responseObject[@"code"] intValue] == 0) {
                jihuajine.tradingStatus.text = @"交易成功";
            }else if ([responseObject[@"code"] intValue] == 1){
                jihuajine.tradingStatus.text = @"交易失败";
            }else if ([responseObject[@"code"] intValue] == 3){
                jihuajine.tradingStatus.text = @"处理中";
            }
        
            jihuajine.tradingPrice.text = [NSString stringWithFormat:@"¥ %.2f",[weak_self.shoukkuanblock.priceTf.text doubleValue]];

            jihuajine.tradingAcc.text = [NSString stringWithFormat:@"%@ 尾号%@ %@",self.chuxukaDic[@"bankName"],[self.chuxukaDic[@"cardNo"] substringFromIndex:[self.chuxukaDic[@"cardNo"] length]-4],@"储蓄卡"];

            jihuajine.tradingTime.text = [NSString stringWithFormat:@"%@",[NSDate GetCurrentDateType:DateTypeYMDHms]];
        
        
        
        LSTPopView *xplainView = [LSTPopView initWithCustomView:jihuajine
                                                      popStyle:LSTPopStyleSpringFromTop
                                                  dismissStyle:LSTDismissStyleSmoothToTop];
        LSTPopViewWK(xplainView);
            [jihuajine.backBtn bk_whenTapped:^{
                [wk_popView dismiss];
                [weak_self.xp_rootNavigationController popToRootViewControllerAnimated:YES];
            }];
        [jihuajine.sureBtn bk_whenTapped:^{
            [wk_popView dismiss];
            [weak_self.xp_rootNavigationController popToRootViewControllerAnimated:YES];
        }];
        
        [xplainView pop];
    } failure:^(NSString * _Nonnull error) {
        
    }];
    
}




@end
